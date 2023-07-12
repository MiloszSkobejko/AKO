#include <stdio.h>

#define SIZE 7

__int64 suma_siedmiu_liczb(__int64 v1, __int64 v2, __int64 v3, __int64 v4, __int64 v5, __int64 v6, __int64 v7);

int main()
{
	__int64 tab[SIZE] = {1,34,5,4,5,68,79};
	__int64 wynik, poprawny_wynik = 0;

	wynik = suma_siedmiu_liczb(tab[0], tab[1], tab[2], tab[3], tab[4], tab[5], tab[6]);

	for (int i = 0; i < SIZE; i++)
		poprawny_wynik += tab[i];

	printf("wynik: %d, powinno byc: %d\n\n", wynik, poprawny_wynik);
		

	return 0;
}