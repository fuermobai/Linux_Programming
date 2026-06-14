#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

const char *test_file = "/tmp/test_lock";
#define SIZE_TO_TRY 5

void show_lock_info(struct flock *to_show);


int main(void)
{
	int file_desc;
	int res;
	struct flock region_to_test;
	int start_type;

	file_desc = open(test_file,O_RDWR | O_CREAT,0666);
	if (!file_desc) {
		fprintf(stderr,"Unable to open %s for read/write \n",test_file);
		exit(EXIT_FAILURE);
	}


	for (int start_byte = 0; start_byte < 99; start_byte += SIZE_TO_TRY) {
		region_to_test.l_type = F_WRLCK;
		region_to_test.l_whence = SEEK_SET;
		region_to_test.l_start = start_byte;
		region_to_test.l_len = SIZE_TO_TRY;
		region_to_test.l_pid = -1;

		printf("Testing F_WRLCK on region from %d to %d \n",start_byte,start_byte + SIZE_TO_TRY);
	}


	region_2.l_type = F_WRLCK;
	region_2.l_whence = SEEK_SET;
	region_2.l_start = 40;
	region_2.l_len = 10;



	printf("Proccess %d locking file \n ",getpid());
	res = fcntl(file_desc,F_SETLK,&region_1);
	if (res == -1) {
		fprintf(stderr,"Failed to lock regin 1\n");
	}
	res = fcntl(file_desc,F_SETLK,&region_2);
	if (res == -1) {
		fprintf(stderr,"Failed to lock regin 2\n");
	}

	sleep(60);

	printf("Process %d closing file \n ",getpid());
	close(file_desc);
	exit(EXIT_SUCCESS);
}
