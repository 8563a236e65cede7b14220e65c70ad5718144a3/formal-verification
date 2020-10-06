#ifndef _FIND2_H_
#define _FIND2_H_

#include "../../logic/SomeNone.acsl"

/*@
 	 requires		valid:		\valid_read(a + (0..n-1));
 	 assigns					\nothing;
 	 ensures		result:		0 <= \result <= n;

 	 behavior some:
 	 	 assumes				SomeEqual(a, n, v);
 	 	 assigns				\nothing;
 	 	 ensures	bound:		0 <= \result < n;
 	 	 ensures	result:		a[\result] == v;
 	 	 ensures	first:		NoneEqual(a, \result, v);

 	 behavior none:
 	 	 assumes				NoneEqual(a, n, v);
 	 	 assigns				\nothing;
 	 	 ensures	result:		\result == n;

 	 complete behaviors;
 	 disjoint behaviors;
 */
unsigned int find2(const int* a, unsigned int n, int v);

#endif
