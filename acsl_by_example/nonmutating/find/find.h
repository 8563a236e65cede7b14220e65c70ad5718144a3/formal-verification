#ifndef _FIND_H_
#define _FIND_H_

/*@
   requires		\valid_read(a + (0..n-1));
   assigns  	\nothing;
   ensures		0 <= \result <= n;

   behavior some:
   	assumes		\exists integer i; 0 <= i < n && a[i] == v;
   	assigns		\nothing;
   	ensures		0 <= \result < n;
   	ensures		a[\result] == v;
   	ensures		\forall integer i; 0 <= i < \result ==> a[i] != v;

   behavior none:
   	assumes		\forall integer i; 0 <= i < n ==> a[i] != v;
   	assigns		\nothing;
   	ensures		\result == n;

   complete behaviors;
   disjoint behaviors;
 */
unsigned int find(const int* a, unsigned int n, int v);


#endif
