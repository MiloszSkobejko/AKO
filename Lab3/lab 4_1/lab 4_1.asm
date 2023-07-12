.686
.model flat

public _szukaj_max
public _szukaj4_max

.code

; ############################### SZUKAJ 3 MAX ######################################
	_szukaj_max PROC

		push ebp									; zapisanie zawartości EBP na stosie
		mov ebp, esp								; kopiowanie zawartości ESP do EBP

		mov eax, [ebp+8]							; liczba x
		cmp eax, [ebp+12]							; porownanie liczb x i y
		jge x_wieksza								; skok, gdy x >= y

	; przypadek x < y
		mov eax, [ebp+12]							; liczba y
		cmp eax, [ebp+16]							; porownanie liczb y i z
		jge y_wieksza								; skok, gdy y >= z


	; przypadek y < z
	; zatem z jest liczbą najwiekszą

		wpisz_z: mov eax, [ebp+16]					; liczba z

		zakoncz:
			pop ebp
			ret

		x_wieksza:
			cmp eax, [ebp+16]						; porownanie x i z
			jge zakoncz								; skok, gdy x >= z
			jmp wpisz_z

		y_wieksza:
			mov eax, [ebp+12]						; liczba y
			jmp zakoncz

	_szukaj_max ENDP

; ############################### SZUKAJ 4 MAX ######################################

	_szukaj4_max PROC

		push ebp									; zapisanie zawartości EBP na stosie
		mov ebp, esp								; kopiowanie zawartości ESP do EBP

		mov eax, [ebp+8]							; liczba x
		cmp eax, [ebp+12]							; porownanie liczb x i y
		jge x_wieksza								; skok, gdy x >= y

	; przypadek x < y
		mov eax, [ebp+12]							; liczba y
		cmp eax, [ebp+16]							; porownanie liczb y i z
		jge y_wieksza								; skok, gdy y >= z


	; przypadek y < z
	; zatem z jest liczbą najwiekszą

		wpisz_z: mov eax, [ebp+16]					; liczba z

		w_wieksza:
			cmp eax, [ebp + 20]
			jge zakoncz
			mov eax, [ebp + 20]

		zakoncz:
			pop ebp
			ret

		x_wieksza:
			cmp eax, [ebp+16]						; porownanie x i z
			jge w_wieksza							; skok, gdy x >= z
			jmp wpisz_z

		y_wieksza:
			mov eax, [ebp+12]						; liczba y
			jmp w_wieksza
			

	_szukaj4_max ENDP
END