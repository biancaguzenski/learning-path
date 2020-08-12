#include <stdio.h>
#include <stdlib.h>
#include "map.h"
#include <string.h>

void readMap(MAP* m) {
	FILE* f;
	f = fopen("map.txt", "r");
	if(f == 0) {
		printf("Sorry, map not found");
		exit(1);
	}

	fscanf(f, "%d %d", &(m->lines), &(m->columns));
	mapSpace(m);
	
	for(int i = 0; i < m->lines; i++) {
		fscanf(f, "%s", m->matrix[i]);
	}

	fclose(f);
}

void mapSpace(MAP* m) {
	m->matrix = malloc(sizeof(char*) * m->lines);

	for(int i = 0; i < m->lines; i++) {
		m->matrix[i] = malloc(sizeof(char) * m->columns + 1);
	}
}

void copyMap(MAP* destiny, MAP* origin) {
	destiny->lines = origin->lines;
	destiny->columns = origin->columns;
	mapSpace(destiny);
	for(int i = 0; i < origin->lines; i++) {
		strcpy(destiny->matrix[i], origin->matrix[i]);
	}
}


void freeMap(MAP* m) {
	for(int i = 0; i < m->lines; i++) {
		free(m->matrix[i]);
	}

	free(m->matrix);
}


int findMap(MAP* m, POSITION* p, char c) {

	for(int i = 0; i < m->lines; i++) {
		for(int j = 0; j < m->columns; j++) {
			if(m->matrix[i][j] == c) {
				p->x = i;
				p->y = j;
				return 1;
			}
		}
	}

	return 0;
}

int go(MAP* m, char charact, int x, int y) {
	return 
		valid(m, x, y) && 
		!wall(m, x, y) &&
		!character(m, charact, x, y);
}

int valid(MAP* m, int x, int y) {
	if(x >= m->lines) 
		return 0;
	if(y >= m->columns) 
		return 0;

	return 1;	
}

int character(MAP* m, char character, int x, int y) {
	return
		m->matrix[x][y] == character;
}

int wall(MAP* m, int x, int y) {
	return 
		m->matrix[x][y] == WALL_V ||
		m->matrix[x][y] == WALL_H;
}


void walk(MAP* m, int xorig, int yorig, 
	int xdestin, int ydestin) {

	char character = m->matrix[xorig][yorig];
	m->matrix[xdestin][ydestin] = character;
	m->matrix[xorig][yorig] = EMPTY;

}