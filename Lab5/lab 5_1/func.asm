.686
.model flat

extern _ExitProcess@4 : PROC
public _srednia_harm

.code
_srednia_harm PROC

	push ebp
	mov  ebp, esp

	push ebx ; Adres tablicy
	mov ebx, [ebp + 8]

	push ecx ; Liczba elementów w tablicy
	mov ecx, [ebp + 12]

	finit ; Inicjalizacja koprocesora
	fldz  ; Ładujemy 0 na stos - to będzie nasz wynik w st(2)

Kolejny_element:
	fld dword PTR [ebx] ; Ładujemy następny element na stos
	fld1                ; Ładujemy 1 na stos
	fdiv st(0), st(1)   ; Dzielimy 1 / element
	fadd st(0), st(2)   ; Dodajemy wartość dzielenia do bufora

	fst st(2)           ; Usuwamy śmieci ze stosu
	fstp st(0)          ; 
	fstp st(0)          ; 

	add ebx, 4 ;		; Przesuniecie na następny element tablicy
	loop Kolejny_element

	; st(0) zawiera (1 / a1) + (1 / a2) + (1 / a3) + ...

	fild dword PTR [ebp + 12] ; Ładujemy ilość elementów n na stos
	                          ; st(0) = n, st(1) = suma dzieleń
	fdiv st(0), st(1)         ; Dzielimy n / suma dzieleń -> st(0)
	fstp st(1)

	pop ecx
	pop ebx

	pop ebp
	ret

_srednia_harm ENDP
END