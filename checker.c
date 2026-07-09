#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    char *ptr = (char *)malloc(1024);
    char ch;
    
    ch = ptr[1024];
    ptr[1024] = 0;// 内存泄漏点

    ptr = 0;//内存泄漏的根源，因为将ptr指针置零，无任何方式可以访问了
    exit(0);
}
