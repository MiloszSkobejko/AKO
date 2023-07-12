.686
.model flat
extern			__write			: PROC
extern			__read			: PROC
extern			_ExitProcess@4	: PROC

					;************ DATA SEGMENT ************;

public _main
.data
znaki			db 12 dup (?)								;znak zapytania oznacza, ze wartosc jest nieznana
															; znaki to tablica 12 elementow
obszar			db 12 dup (?)
dziesiec		dd 10										; mnożnik (jako dd, aby bylo zgodnie z rejestrem EAX)
			


	
.code				;************ CODE SEGMENT ************;

; ### FUNKCJA WYSWIETLANIA LICZBY W KONSOLI
wyswietl_EAX	PROC
				pusha

						mov		esi, 10						; indeks tablicy 'znaki'
						mov		ebx, 10						; dzielnik rowny 10
		
				konwersja:
						mov		edx, 0						; zerowanie starszej czesci dzielnej
						div		ebx							; dzielenie przez ebx [10], reszta w EDX (tabela)
															; iloraz w EAX
						add		dl, 30H						; zamiana reszty z dzielenia na kod ASCII (np 7 ma kod 37H, po dodaniu 30H  do 007 otrzymamy to co chcemy, aby mozna to bylo wyswietlic)

						mov		znaki[esi], dl				; zapisanie cyfry w kodzie ASCII
						dec		esi							; zmniejszenie indeksu

						cmp		eax, 0						; sprawdzenie, czy iloraz = 0
						jne		konwersja					; skok, gdy iloraz niezerowy

				; wypełnienie pozostałych bajtów spacjami i wpisanie 
				; znaków nowego wiersza

				wypelnij: 
						or		esi, esi
						jz		wyswietl					; skok, gdy esi = 0
					   ;mov		byte PTR znaki [esi], 20H	;kod spacji, bez tej instrukcji liczby wyswietla sie maksymalnie z lewej
						dec		esi							;zmniejszenie indeksu
						jmp		wypelnij

				wyswietl:
					   ;mov		byte PTR znaki [0], 0AH		;kod nowego wiersza
						mov		byte PTR znaki [11], 0AH	;kod nowego wiersza

				; wyświetlenie cyfr na ekranie
						push	dword PTR 12				; liczba wyświetlanych znaków
						push	dword PTR OFFSET znaki		; adres wyśw. obszaru
						push	dword PTR 1					; numer urządzenia (ekran ma numer 1)
						call	 __write					; wyświetlenie liczby na ekranie
						add		esp, 12						; czyszczenie stosu
				

				popa
				ret
wyswietl_EAX	ENDP




; ### FUNKCJA WCZYTYWANIA LICZBY Z KONSOLI
wczytaj_do_EAX	PROC

				push ecx
				push ebx

				; max ilość znaków wczytywanej liczby 
				push	dword PTR 12
				push	dword PTR OFFSET obszar				; adres obszaru pamięci 
				push	dword PTR 0							; numer urządzenia (0 dla klawiatury)
				call	__read								; odczytywanie znaków z klawiatury 
				add		esp, 12								; usunięcie parametrów ze stosu


				; bieżąca wartość przekształcanej liczby przechowywana jest 
				; w rejestrze EAX; przyjmujemy 0 jako wartość początkową
				mov		eax, 0 
				mov		ebx, OFFSET obszar					; adres obszaru ze znakami

				pobieraj_znaki: 
						mov		 cl, [ebx]					; pobranie kolejnej cyfry w kodzie ASCII
						inc ebx								; zwiększenie indeksu 
						cmp cl,10							; sprawdzenie czy naciśnięto Enter 
						je byl_enter						; skok, gdy naciśnięto Enter 
						sub cl, 30H							; zamiana kodu ASCII na wartość cyfry 
						movzx ecx, cl						; przechowanie wartości cyfry w ; rejestrze ECX
						
						mul dword PTR dziesiec				; mnożenie wcześniej obliczonej wartości razy 10
						add eax, ecx						; dodanie ostatnio odczytanej cyfry
						jmp pobieraj_znaki					; skok na początek pętli

				byl_enter:									; wartość binarna wprowadzonej liczby znajduje się teraz w rejestrze EAX


				pop ebx										
				pop ecx

				ret
wczytaj_do_EAX	ENDP


				;************ MAIN SEGMENT ************;
_main PROC
				
				call wczytaj_do_EAX
				call wyswietl_EAX

				push 0
				call _ExitProcess@4
_main ENDP
END