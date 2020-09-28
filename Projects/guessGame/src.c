#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main() {

    printf("Welcome to the guessing game!\n");

    int seconds = time(0);
    srand(seconds);

    int bigRand = rand();

    int secretNumber = bigRand % 100;
    int guess;
    int attempt = 1;
    double points = 1000;

    int guessed = 0;

    int level;
    printf("Choose your level\n");
    printf("1 - easy\n2 - intermediate\n3 - i'm lucky\n\n");
    scanf("%d", &level);

    int numberAttempts;
    switch(level) {
        case 1:
            numberAttempts = 20;
            break;
        case 2:
            numberAttempts = 15;
            break;
        default:
            numberAttempts = 6;
            break;
    }

    int i;

    printf("I'm thinking of a number between 0 and 100..");
    
    for(i = 1; i <= numberAttempts; i++) {

        printf("Attempt %d\n", attempt);
        printf("Try a number: ");

        scanf("%d", &guess);
        printf("You said: %d\n", guess);

        if(guess < 0) {
            printf("You can't choose a nevative number!\n");
            continue;
        }

        guessed = (guess == secretNumber);
        int bigger = guess > secretNumber;

        if(guessed) {
            break;
        } else if(bigger) {
            printf("Your number is bigger than mine\n");
        } else {
            printf("My number is bigger than yours\n");
        }

        attempt++;

        double lostPoints = abs(guess - secretNumber) / (double)2.0;
        points = points - lostPoints;
    }

    printf("GAME OVER\n");

    if(guessed) {

        printf("YOU WON!\n");
        printf("You guessed in %d attempts!\n", attempt);
        printf("Points: %.1f\n", points);
    }
    else {
        
        printf("Try again!\n");
    }
}