typedef struct{
    char data[4096];
    int key;
} item;

item array[] = {
    {"bill",3},
    {"neil",4},
    {"john",2},
    {"rick",5},
    {"alex",1},
};
sort(a,n)
item *a;
{
    int i = 0,j = 0;
    int s;

    for ( ; i < n & s != 0; i++) {
        s = 0;//配合 27行进行循环
        for (j = 0; j < n - 1 ; j++) {
            if (a[j].key > a[j+1].key) {
                item t = a[j]; //交换逻辑
                a[j] = a[j+1];
                a[j+1] = t;
                s++;// 和21行的s = 0 配合循环，其实可以用while代替
            }
        }
        n--;
    }
}

#include <stdio.h>
main()
{
    sort(array,5);
    
}
