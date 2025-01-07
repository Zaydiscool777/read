#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
// to include: #include "lib.h"

/*** DEBUG ***/

int pass(int in)
{
    printf("\npass: %i %x\n", in, in);
    return in;
}

/*** DATASTRUCTS ***/

//http://www.cse.yorku.ca/~oz/hash.html
//see also: https://gist.github.com/hmic/1676398
unsigned long hash(unsigned char *str){
	unsigned long hash = 5381;
	int c;
	while(c = *str++)
		hash = ((hash << 5) + hash) + c;
	return hash;
}

// sha256: use https://github.com/B-Con/crypto-algorithms/blob/master/sha256.c instead.

// credit: https://www.geeksforgeeks.org/structures-c/

/* DATASTRUCT linked list*/

struct ll
{
    int datum;
    struct ll* next;
};

int ll_s(struct ll self, int set)
{
    self.datum = set;
}

void ll_p(struct ll self, struct ll to)
{
    self.next = &to;
}

int ll_g(struct ll self)
{
    return self.datum;
}
