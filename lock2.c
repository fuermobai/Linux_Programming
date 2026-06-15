#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>

const char * lock_file = "/tmp/LCK.test2";

int main(void)
{
	int file_desc;
	int tries = 10;

	while (tries--) {
		file_desc = open(lock_file,O_RDWR | O_CREAT | O_EXCL,0444);
	if (file_desc == -1) {
		printf("%d - Lock already present \n  ",getpid());
		sleep(5);
	} else {
		printf("%d - I have exclusive access \n",getpid());
		sleep(5);
		(void)close(file_desc);
		(void)unlink(lock_file);
		sleep(5);
	}
	}
	exit(EXIT_SUCCESS);
}
