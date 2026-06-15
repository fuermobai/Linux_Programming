/*
 * =====================================================================================
 *
 *       Filename:  lock5.c
 *
 *    Description: 文件锁的竞争 
 *
 *        Version:  1.0
 *        Created:  06/15/26 15:45:06
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  YOUR NAME (fuermobai), 
 *   Organization:  
 *
 * =====================================================================================
 */
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>

const char *test_file = "/tmp/test_lock";

int main()
{
    int file_desc;
    struct flock region_to_lock;
    int res;

    file_desc = open(test_file, O_RDWR | O_CREAT,0666);
    if (!file_desc) {
        fprintf(stderr,"Unable to open %s for read/write\n",test_file);
        exit(EXIT_FAILURE);
    }
    region_to_lock.l_type = F_RDLCK;
    region_to_lock.l_whence = SEEK_SET;

}
