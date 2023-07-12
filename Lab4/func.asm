.686
.model flat

public _replace_below_zero

.data
newtab dd 16 DUP(0)

.code
	_replace_below_zero PROC

		push ebp				; zapisanie zawartości EBP na stosie
		mov ebp,esp				; kopiowanie zawartości ESP do EBP
		push ebx				; przechowanie zawartości rejestru EBX
		push edi
		push esi

	; wartosci startowe
		mov ebx, [ebp + 8]		; adres tablicy
		mov	ecx, [ebp + 12]		; liczba elementow tablicy
		mov edx, [ebp + 16]		; wartosc, na ktore mniejsze od zera maja sie zamienic

		mov esi, 0
		mov edi, offset newtab	; wrzucenie tablicy utworzonej tutaj do edi

	; sprawdzenie, czy tablica nie jest za duza
		cmp ecx, 7
		jg returnnull

	; petla wrzucajaca dane do nowej tablicy
		ptl:
			mov eax, [ebx + esi]; kolejny element tablicy
			cmp eax, 0
			jl zamiana
			mov [edi + esi], eax
			add esi, 4
			loop ptl
		
		jmp koniec
		
	; zamiana wartosci
		zamiana:
			mov [edi + esi], edx
			add esi, 4
			jmp ptl

		returnnull:
			mov eax, 0
			jmp koniec2

		koniec:
	; zwracanie wartosci
			mov eax, edi
			jmp koniec2

		koniec2:
			pop esi
			pop edi
			pop ebx					; odtworzenie zawartości rejestrów
			pop ebp					
			ret						; powrót do programu głównego


	_replace_below_zero ENDP
END