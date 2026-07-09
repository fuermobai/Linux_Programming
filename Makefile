all: app

app: app_mysql.c app_test.c -app_mysql.h 
	gcc -o app app_mysql.c app_test.c -lmysqlclient -L/usr/lib64/mysql
