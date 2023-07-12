#include<stdio.h>

float srednia_harm(float* tablica, unsigned int n);

int main()
{
	int size;
	

	scanf_s("%d", &size);

	float* liczby = malloc(size * sizeof(float));


	/* Wczytywanie wektora */
	for (int i = 0; i < size; i++)
		scanf_s("%f", liczby + i);


	printf("%f\n", srednia_harm(liczby, size));
	free(liczby);

	return 0;
}