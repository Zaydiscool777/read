#include <stdio.h>
#include <stdlib.h>
// to include: #include "lib.h"

//http://www.cse.yorku.ca/~oz/hash.html
unsigned long hash(unsigned char *str){
	unsigned long hash = 5381;
	int c;
	while(c = *str++)
		hash = ((hash << 5) + hash) + c;
	return hash;
}
