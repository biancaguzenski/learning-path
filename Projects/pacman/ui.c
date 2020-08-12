#include <stdio.h>
#include "map.h"

char drawWall[4][7] = {
	{"......" },
	{"......" },
	{"......" },
	{"......" }
};

char deawGhost[4][7] = {
	{" .-.  " },
	{"| OO| " },
	{"|   | " },
	{"'^^^' " }
};

char drawHero[4][7] = {
	{" .--. "  },
	{"/ _.-'"  },
	{"\\  '-." },
	{" '--' "  }
};

char drawPil[4][7] = {
	{"      "},
	{" .-.  "},
	{" '-'  "},
	{"      "}
};

char drawEmpty[4][7] = {
	{"      "},
	{"      "},
	{"      "},
	{"      "}
};

void print(char draw[4][7], int part) {
	printf("%s", draw[part]);
}

void printMap(MAP* m) {
	for(int i = 0; i < m->lines; i++) {

		for(int part = 0; part < 4; part++) {
			for(int j = 0; j < m->columns; j++) {

				switch(m->matrix[i][j]) {
					case GHOST:
						print(deawGhost, part);
						break;
					case HERO:
						print(drawHero, part);
						break;
					case PIL:
						print(drawPil, part);
						break;
					case WALL_V:
					case WALL_H:
						print(drawWall, part);
						break;
					case EMPTY:
						print(drawEmpty, part);
						break;
				}
				
			}
			printf("\n");
		}

	}
}