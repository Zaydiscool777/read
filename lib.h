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
unsigned long chash(unsigned char *str){
	unsigned long hash = 5381;
	int c;
	while(c = *str++)
		hash = ((hash << 5) + hash) + c;
	return hash;
}

//https://burtleburtle.net/bob/hash/integer.html
unsigned long ihash(unsigned int a)
{
    a -= (a<<6);
    a ^= (a>>17);
    a -= (a<<9);
    a ^= (a<<4);
    a -= (a<<3);
    a ^= (a<<10);
    a ^= (a>>15);
    return a;
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
