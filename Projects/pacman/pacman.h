#ifndef _PACMAN_H_
#define _PACMAN_H_

#define UP 'w'
#define DOWN 's'
#define RIGHT 'd'
#define LEFT 'a'
#define BOMB 'b'

int end();
void move(char direction);
 
int direction(char direction);
void ghosts();
void explodePil();
void explodePil2(int x, int y, int sumx, int sumy, int qtd);


#endif