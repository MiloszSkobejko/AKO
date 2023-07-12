.686
.model flat
extern			__write			: PROC
extern			_ExitProcess@4	: PROC

					;************ DATA SEGMENT ************;

public _main
.data
znaki			db 12 dup (?)								;znak zapytania oznacza, ze wartosc jest nieznana
															; znaki to tablica 12 elementow
			
	
.code				;************ CODE SEGMENT ************;

wyswietl_EAX	PROC
				pusha

						mov		esi, 10						; indeks tablicy 'znaki'
						mov		ebx, 10						; dzielnik rowny 10
		
				konwersja:
						mov		edx, 0						; zerowanie starszej czesci dzielnej
						div		ebx							; dzielenie przez ebx [10], reszta w EDX (tabela)
															; iloraz w EAX
						add		dl, 30H						; zamiana reszty z dzielenia na kod ASCII

						mov		znaki[esi], dl				; zapisanie cyfry w kodzie ASCII
						dec		esi							; zmniejszenie indeksu
						cmp		eax, 0						; sprawdzenie, czy iloraz = 0
						jne		konwersja					; skok, gdy iloraz niezerowy

				; wypełnienie pozostałych bajtów spacjami i wpisanie 
				; znaków nowego wiersza

				wypelnij: 
						or		esi, esi
						jz		wyswietl					; skok, gdy esi = 0
						mov		byte PTR znaki [esi], 20H	;kod spacji, bez tej instrukcji liczby wyswietla sie maksymalnie z lewej
						dec		esi							;zmniejszenie indeksu
						jmp		wypelnij

				wyswietl:
						mov		byte PTR znaki [0], 0AH		;kod nowego wiersza
						mov		byte PTR znaki [11], 0AH	;kod nowego wiersza

				; wyświetlenie cyfr na ekranie
						push dword PTR 12					; liczba wyświetlanych znaków
						push dword PTR OFFSET znaki			; adres wyśw. obszaru
						push dword PTR 1					; numer urządzenia (ekran ma numer 1)
						call __write						; wyświetlenie liczby na ekranie
						add esp, 12
				

				popa
				ret
wyswietl_EAX	ENDP



				;************ MAIN SEGMENT ************;
_main PROC
				
				mov ebx,0									; Do dodania w następnym obiegu
				mov ecx,50									; Licznik pętli
				mov eax,1									; licznik ciagu


				petla:
					add eax,ebx
					call wyswietl_EAX
					inc ebx
					dec ecx
					jnz petla

				push 0
				call _ExitProcess@4
_main ENDP
END
