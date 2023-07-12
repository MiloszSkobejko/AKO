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
dekoder			db '0123456789AB'			


	
.code				;************ CODE SEGMENT ************;

; ### FUNKCJA WYSWIETLANIA LICZBY DZIESIETNIE W KONSOLI
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


; ### FUNKCJA WCZYTUJE LICZBY DWUNASTKOWE  W KONSOLI
wczytaj_do_EAX_dwun PROC
			; wczytywanie liczby szesnastkowej z klawiatury – liczba po konwersji na postać binarną zostaje wpisana do rejestru EAX
			; po wprowadzeniu ostatniej cyfry należy nacisnąć klawisz Enter

				push	ebx
				push	ecx
				push	edx
				push	esi
				push	edi
				push	ebp

			; rezerwacja 12 bajtów na stosie przeznaczonych na tymczasowe przechowanie cyfr szesnastkowych wyświetlanej liczby
				sub		esp, 12									; rezerwacja poprzez zmniejszenie ESP
				mov		esi, esp								; adres zarezerwowanego obszaru pamięci
				push	dword PTR 10							; max ilość znaków wczytyw. liczby
				push	esi										; adres obszaru pamięci
				push	dword PTR 0								; numer urządzenia (0 dla klawiatury)
				call	__read									; odczytywanie znaków z klawiatury

				add		esp, 12									; usunięcie parametrów ze stosu
				mov		eax, 0									; dotychczas uzyskany wynik

				pocz_konw:
						mov		 dl, [esi]						; pobranie kolejnego bajtu
						inc		 esi							; inkrementacja indeksu
						cmp		 dl, 10							; sprawdzenie czy naciśnięto Enter
						je gotowe								; skok do końca podprogramu
						
					; sprawdzenie czy wprowadzony znak jest cyfrą 0, 1, 2 , ..., 9
						cmp		dl, '0'
						jb pocz_konw							; inny znak jest ignorowany
						cmp		dl, '9'
						ja sprawdzaj_dalej
						sub		dl, '0' 						; zamiana kodu ASCII na wartość cyfry
						
				dopisz:
						;shl	eax, 4							; 

						mov		bl, byte PTR 12
						mul		bl

						add		al, dl							; dopisanie utworzonego kodu 4-bitowego na 4 ostatnie bity rejestru EAX
						jmp pocz_konw							; skok na początek pętli konwersji

			; sprawdzenie czy wprowadzony znak jest cyfrą A, B
				sprawdzaj_dalej:
						cmp		dl, 'A'
						jb pocz_konw							; inny znak jest ignorowany
						cmp		dl, 'B'
						ja sprawdzaj_dalej2
						sub		dl, 'A' - 10					; wyznaczenie kodu binarnego
						jmp dopisz
						
				sprawdzaj_dalej2:
						cmp		dl, 'a'
						jb pocz_konw							; inny znak jest ignorowany
						cmp		dl, 'b'
						ja pocz_konw							; inny znak jest ignorowany
						sub		dl, 'a' - 10
						jmp dopisz
			; zwolnienie zarezerwowanego obszaru pamięci
				gotowe:
						add		esp, 12

				pop		ebp
				pop		edi
				pop		esi
				pop		edx
				pop		ecx
				pop		ebx
				ret

wczytaj_do_EAX_dwun ENDP



				;************ MAIN SEGMENT ************;
_main PROC

				mov ebx, 0

				call wczytaj_do_EAX_dwun							; wyczytywanie pierwszej 
				mov ebx, eax

				call wczytaj_do_EAX_dwun							; wczytywanie drugiej
				mov edx, 0
				mov ecx, ebx
				mov ebx, eax
				mov eax, ecx

				;KOD DZIELENIA

				mov	edi, 0
				mov ecx, 5



				podziel_dalej:
						div ebx

						call wyswietl_EAX
						mov eax, edx
						mov edi, 10
						mul edi
						;call wyswietl_EAX
						dec ecx
						jnz podziel_dalej
				



				push 0
				call _ExitProcess@4
_main ENDP
END