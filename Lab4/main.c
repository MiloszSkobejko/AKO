#include <stdio.h>

#define SIZE 10

int* replace_below_zero(int* tab, int n, int value);
void print_vector(int* arr, int n);


void print_vector(int* arr, int n)
{
	if (arr == NULL)
	{
		printf("NULL!");
		return 0;
	}


	for (int i = 0; i < n; i++)
		printf("%d ", arr[i]);
	printf("\n");
}

int main()
{
	int arr[SIZE];
	int* returnarr;
	int zam = 7;
	/* wszytywanie wektora 10 elementowego z konsoli*/
	printf("Podaj 8 elementow tablicy po spacji: ");

	for (int i = 0; i < SIZE; i++)
		scanf_s("%d", &arr[i]);

	/* czyszczenie bufora */
	while (getchar() != '\n');

	returnarr = replace_below_zero(arr, SIZE, zam);

	//print_vector(arr, SIZE);
	print_vector(returnarr, SIZE);
	printf("\n\n\n");

	return 0;
}