#include <stdio.h>

#define SIZE 7

void przestaw(int tabl[], int n);
void print_vector(int* arr, int n);
void sort(int* tab, int n);

void print_vector(int* arr, int n)
{
	for (int i = 0; i < n; i++)
		printf("%d ", arr[i]);
	printf("\n");
}

int main()
{
	int arr[SIZE] = { -7, 10, 4, -2, 84, -2, 100};

	/* WYSWIETLANIE WEKTORA PRZED SORTOWANIEM */
	print_vector(arr, SIZE);


	/* SORTOWANIE WEKTORA ROSNĄCO */
	sort(arr, SIZE);


	/* WYSWIETLANIE WEKTORA PO SORTOWANIU */
	print_vector(arr, SIZE);

	return 0;
}

void sort(int* tab, int n)
{
	for (int i = 0; i < n - 1; i++)
	{
		//print_vector(tab, n); /* Wyświetlanie aktualnego wektora*/
		przestaw(tab, n - i);
	}
}