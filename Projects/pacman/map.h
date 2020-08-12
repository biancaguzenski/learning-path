#ifndef _MAP_H_
#define _MAP_H_


#define HERO '@'
#define EMPTY '.'
#define WALL_V '|'
#define WALL_H '-'
#define GHOST 'F'
#define PIL 'P'

struct map {
	char** matrix;
	int lines;
	int columns; 
};

typedef struct map MAP;

void mapSpace(MAP* m);
void readMap(MAP* m);
void freeMap(MAP* m);

struct position {
	int x;
	int y;
};

typedef struct position POSITION;

int findMap(MAP* m, POSITION* p, char c);

int valid(MAP* m, int x, int y);
int wall(MAP* m, int x, int y);
int character(MAP* m, char character, int x, int y);

void walk(MAP* m, int xorig, int yorig, 
	int xdestin, int ydestin);

void copyMap(MAP* destiny, MAP* origin);

int go(MAP* m, char character, int x, int y);

#endif