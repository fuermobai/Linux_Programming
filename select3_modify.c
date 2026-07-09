#include <stdlib.h>
#include <stdio.h>
#include <mysql/mysql.h>

MYSQL my_connection;
MYSQL_RES *res_ptr;
MYSQL_ROW sqlrow;

void display_header();
void display_row();

int main(int argc, char *argv[])
{
    int res;
    int first_row = 1;

    mysql_init(&my_connection);
    if (mysql_real_connect(&my_connection, "localhost", "libre", " ", "libre", 0, NULL, 0)) {
        printf("connection success\n");
// 连接数据库成功
        res = mysql_query(&my_connection, "SELECT childno,fname,age from children where age >= 5");



        if (res) {
            fprintf("SELECT error: %s\n ",mysql_error(&my_connection));
        }else {
            // select2 store 改为 use 
            res_ptr = mysql_use_result(&my_connection);
            if (res_ptr) {
                printf("Retriveved %lu rows\n ",(unsigned long)mysql_num_rows(res_ptr));
                while ((sqlrow = mysql_fetch_row(res_ptr))) {
                  printf("Fetched data...\n childno = %s,fname = %s,age = %s\n ",
                          sqlrow[0]?sqlrow[0]:"(NULL)",
                          sqlrow[1]?sqlrow[1]:"(NULL)",
                          sqlrow[2]?sqlrow[2]:"(NULL)"
                          );
                  display_row();
              }
              if (mysql_errno(&my_connection)) {
                fprintf(stderr , "Retrive error: %s\n ",mysql_error(&my_connection));
              }
              mysql_free_result(res_ptr);}
            }
        mysql_close(&my_connection);      
    } else {
        fprintf(stderr , "Connection failed\n");
                if (mysql_errno(&my_connection)) {
                fprintf(stderr, "Connection error %d: %s \n ",mysql_errno(&my_connection),mysql_error(&my_connection));
                }
    }
    return EXIT_SUCCESS;
}

//输出函数
void display_row(){
    unsigned int field_count;

    field_count = 0;

    while (field_count < mysql_field_count((&my_connection))) {
        printf("%s ",sqlrow[field_count]);
        field_count++;  
    }
    printf("\n");
}
