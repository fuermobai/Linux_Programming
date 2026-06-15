#include<unistd.h>
#include<stdlib.h>
#include<ncurses.h>

int main(){
	initscr();
	endwin();

	move(5,15);
	printw("%s","Hello World");
	refresh();

	sleep(2);


	exit(EXIT_SUCCESS);
}
