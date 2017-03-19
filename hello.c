#include <stdio.h>

extern char const * const strHello;
extern char const * const strBuy;



int main(){

	printf(strHello);
	printf("\n");
	printf(strBuy);
 	printf("\n");
    return 0;
}

 char const * const strHello = "Hello World";
 char const * const strBuy =   "Goodbye world";
