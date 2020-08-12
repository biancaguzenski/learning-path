#include <stdio.h>
#include <stdlib.h>
#include "time.h"
#include "pacman.h"
#include "map.h"
#include "ui.h"

MAP m;
POSITION hero;
int pil = 0;

int end() {
	POSITION pos;

	int lost = !findMap(&m, &pos, HERO);
	int won = !findMap(&m, &pos, GHOST);

	return won || lost;
		
}

int direction(char direction) {
	return
		direction == LEFT || 
		direction == UP ||
		direction == DOWN ||
		direction == RIGHT;
}

void move(char direction) {

	int nextx = hero.x;
	int nexty = hero.y;

	switch(direction) {
		case LEFT:
			nexty--;
			break;
		case UP:
			nextx--;
			break;
		case DOWN:
			nextx++;
			break;
		case RIGHT:
			nexty++;
			break;
	}

	if(!go(&m, HERO, nextx, nexty))
		return;

	if(character(&m, PIL, nextx, nexty)) {
		pil=1;
	}

	walk(&m, hero.x, hero.y, nextx, nexty);
	hero.x = nextx;
	hero.y = nexty;
}

int ghostWalk(int xnow, int ynow, 
	int* xdestiny, int* ydestiny) {

	int options[4][2] = { 
		{ xnow   , ynow+1 }, 
		{ xnow+1 , ynow   },  
		{ xnow   , ynow-1 }, 
		{ xnow-1 , ynow   }
	};

	srand(time(0));
	for(int i = 0; i < 10; i++) {
		int POSITION = rand() % 4;

		if(go(&m, GHOST, options[POSITION][0], options[POSITION][1])) {
			*xdestiny = options[POSITION][0];
			*ydestiny = options[POSITION][1];
			return 1;
		}
	}

	return 0;
}

void ghosts() {
	MAP copy;

	copyMap(&copy, &m);

	for(int i = 0; i < copy.lines; i++) {
		for(int j = 0; j < copy.columns; j++) {
			if(copy.matrix[i][j] == GHOST) {

				int xdestiny;
				int ydestiny;

				int found = ghostWalk(i, j, &xdestiny, &ydestiny);

				if(found) {
					walk(&m, i, j, xdestiny, ydestiny);
				}
			}
		}
	}

	freeMap(&copy);
}

void explodePil2(int x, int y, int sumx, int sumy, int amount) {

	if(amount == 0) return;

	int novox = x+sumx;
	int novoy = y+sumy;

	if(!valid(&m, novox, novoy)) return;
	if(wall(&m, novox, novoy)) return;

	m.matrix[novox][novoy] = EMPTY;
	explodePil2(novox, novoy, sumx, sumy, amount-1);
}

void explodePil() {
	if(!pil) return;
	
	explodePil2(hero.x, hero.y, 0, 1, 3);
	explodePil2(hero.x, hero.y, 0, -1, 3);
	explodePil2(hero.x, hero.y, 1, 0, 3);
	explodePil2(hero.x, hero.y, -1, 0, 3);
	
	pil = 0;
}

int main() {
	
	readMap(&m);
	findMap(&m, &hero, HERO);

	do {
		printf("pil: %s\n", (pil ? "y" : "n"));
		printMap(&m);

		char command;
		scanf(" %c", &command);

		if(direction(command)) move(command);
		if(command == BOMB) explodePil();

		ghosts();

	} while (!end());

	freeMap(&m);
}