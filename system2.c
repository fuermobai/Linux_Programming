#include <stdlib.h>
#include <stdio.h>
int main(void)
{
    printf("运行系统的 ps 指令");
    system("ps ax &");
    printf("完成！\n");
    exit(0);
}
