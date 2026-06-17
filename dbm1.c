#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

#include <ndbm.h>
// #include <gdbm.h>
#include <string.h>

#define TEST_DB_FILE "/tmp/dbm1_test"
#define ITEMS_USED 3

struct test_data{
    char misc_chars[15];
    int any_integer;
    char more_chars[21];
};
int main()
{
    struct test_data items_to_store[ITEMS_USED];
    struct test_data item_retrieved;

    char key_to_use[20];
    int i ,result;

    datum key_datum;
    datum data_datum;

    DBM *dbm_ptr;
    dbm_ptr = dbm_open(TEST_DB_FILE,O_RDWR | O_CREAT ,0666);
    if (!dbm_ptr) {
        fprintf(stderr,"Failed to open database\n");
        exit(EXIT_FAILURE);
    }
}

