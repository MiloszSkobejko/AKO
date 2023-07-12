#include <stdio.h>
#include <stdint.h>

int szukaj_max(int32_t a, int32_t b, int32_t c);
int szukaj4_max(int32_t a, int32_t b, int32_t c, int32_t d);

int main()
{
	int32_t x, y, z, w, wynik;

	printf("\nProsze podac 4 liczby calkowite ze znakiem: ");
	scanf_s("%d %d %d %d", &x, &y, &z, &w, 32);

	wynik = szukaj4_max(x, y, z, w);

	printf("\nSposrod %d, %d, %d %d, liczba %d jest najwieksza\n", x, y, z, w, wynik);
	return 0;
}