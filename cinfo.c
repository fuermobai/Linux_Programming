#include <stdio.h>
#include <stdlib.h>

int main(void)
{
#ifdef DEBUG
    printf("Compiled: " __DATE__ " at " __TIME__ "\n");
    printf("这是文件 %s 的第 %d 行\n",__FILE__,__LINE__);
#endif
    printf("hello world\n");
    exit(0);
}
