#include "find.h"

unsigned int find(const int* a, unsigned int n, int v){

	unsigned int i;

	/*@
	   loop invariant 0 <= i <= n;
	   loop invariant \forall integer k; 0 <= k < i ==> a[k] != v;
	   loop assigns i;
	   loop variant n-i;
	 */
	for(i=0; i<n; i++){
		if(a[i] == v){
			return i;
		}
	}

	return n;

}
