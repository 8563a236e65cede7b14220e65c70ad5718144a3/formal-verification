#include "find2.h"

unsigned int find2(const int* a, unsigned int n, int v){

	unsigned int i;

	/*@
	 	 loop invariant	bound:		0 <= i <= n;
	 	 loop invariant not_found:	NoneEqual(a, i, v);
	 	 loop assigns i;
	 	 loop variant n - i;
	 */
	for(i=0 ; i<n; i++){
		if(a[i] == v){
			return i;
		}
	}

	return n;

}
