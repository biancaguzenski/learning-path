#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include "hangman.h"

char secretWord[WORD_SIZE];
char guess[26];
int attempts = 0;

void welcome() {
    printf("************************\n");
    printf("*     HANGMAN GAME     *\n");
    printf("************************\n\n");
}

void try() {
    char attempt;
    printf("Which letter?? ");
    scanf(" %c", &attempt);

    guess[attempts] = attempt;
    attempts++;
}

void drawHangman() {

    int wrong = wrongGuess();

    printf("  _______       \n");
    printf(" |/      |      \n");
    printf(" |      %c%c%c  \n", (wrong >= 1 ? '(' : ' '),
        (wrong >= 1 ? '_' : ' '), (wrong >= 1 ? ')' : ' '));
    printf(" |      %c%c%c  \n", (wrong >= 3 ? '\\' : ' '),
        (wrong >=2 ? '|' : ' '), (wrong >= 3 ? '/' : ' '));
    printf(" |       %c     \n", (wrong >= 2 ? '|' : ' '));
    printf(" |      %c %c   \n", (wrong >= 4 ? '/' : ' '),
        (wrong >= 4 ? '\\' : ' '));
    printf(" |              \n");
    printf("_|___           \n");
    printf("\n\n");

    for(int i = 0; i < strlen(secretWord); i++) {

        int rightAnswer = tried(secretWord[i]);

        if(rightAnswer) {
            printf("%c ", secretWord[i]);
        } else {
            printf("_ ");
        }
    }
    printf("\n");
}

void newWord() {

    char yes;

    printf("Do you want to add a new letter to the game? (Y/N) ");
    scanf(" %c", &yes);

    if(yes == 'Y') {

        char new[WORD_SIZE];
        printf("Which one? ");
        scanf("%s", new);

        FILE* f;

        f = fopen("words.txt", "r+");
        if(f == 0) {
            printf("Sorry, database not found\n\n");
            exit(1);
        }

        int qtd;
        fscanf(f, "%d", &qtd);
        qtd++;

        fseek(f, 0, SEEK_SET);
        fprintf(f, "%d", qtd);

        fseek(f, 0, SEEK_END);
        fprintf(f, "\n%s", new);

        fclose(f);
    }
}

void chooseWord() {
    FILE* f;

    f = fopen("words.txt", "r");
    if(f == 0) {
        printf("Sorry, database not found\n\n");
        exit(1);
    }

    int wordsSize;
    fscanf(f, "%d", &wordsSize);

    srand(time(0));
    int random = rand() % wordsSize;

    for(int i = 0; i <= random; i++) {
        fscanf(f, "%s", secretWord);
    }

    fclose(f);
}

int gotit() {
    for(int i = 0; i < strlen(secretWord); i++) {
        if(!tried(secretWord[i])) {
            return 0;
        }
    }

    return 1;
}

int wrongGuess() {
    int wrong = 0;

    for(int i = 0; i < attempts; i++) {
        int exist = 0;

        for(int j = 0; j < strlen(secretWord); j++) {
            if(guess[i] == secretWord[j]) {

                exist = 1;
                break;
            }
        }

        if(!exist) wrong++;
    }

    return wrong;
}

int hanged() {

    return wrongGuess() >= 5;
}

int tried(char letra) {
    int rightAnswer = 0;

    for(int j = 0; j < attempts; j++) {
        if(guess[j] == letra) {
            rightAnswer = 1;
            break;
        }
    }

    return rightAnswer;
}

int main() {

    chooseWord(secretWord);
    welcome();

    do {

        drawHangman(secretWord, guess, attempts);

        try(guess, &attempts);

    } while(!gotit() && !hanged());

    if(gotit()) {
        printf("\nYOU WON!\n\n");
    
    } else {
        printf("\nYou lost...\n");
        
    }
}