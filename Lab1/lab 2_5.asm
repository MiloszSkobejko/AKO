; wczytywanie i wyświetlanie tekstu wielkimi literami
; (inne znaki się nie zmieniają)

.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC ; (dwa znaki podkreślenia)
extern __read : PROC ; (dwa znaki podkreślenia)
public _main

.data
tekst_pocz			db		10, 'Proszę napisać jakiś tekst '
					db		'i nacisnac Enter', 10
koniec_t			db		?
magazyn				db		80 dup (?)
nowa_linia			db		10
liczba_znakow		dd		?

.code
_main PROC

; wyświetlenie tekstu informacyjnego

; liczba znaków tekstu
		mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
		push ecx

		push OFFSET tekst_pocz	; adres tekstu
		push 1					; nr urządzenia (tu: ekran - nr 1)
		call __write			; wyświetlenie tekstu początkowego

		add esp, 12				; usuniecie parametrów ze stosu


; czytanie wiersza z klawiatury
		push 80			; maksymalna liczba znaków
		push OFFSET magazyn
		push 0			; nr urządzenia (tu: klawiatura - nr 0)
		call __read		; czytanie znaków z klawiatury
		add esp, 12		; usuniecie parametrów ze stosu

; kody ASCII napisanego tekstu zostały wprowadzone
; do obszaru 'magazyn'

; funkcja read wpisuje do rejestru EAX liczbę
; wprowadzonych znaków
		mov liczba_znakow, eax


; rejestr ECX pełni rolę licznika obiegów pętli
		mov ecx, eax
		mov ebx, 0				; indeks początkowy


ptl:
	mov dl, magazyn[ebx] ; pobranie kolejnego znaku

	; litery polskie do zmiany
	cmp dl, 0A5H ; ą
	je zamA
	cmp dl, 86H  ; ć
	je zamC
	cmp dl, 0A9H ; ę
	je zamE
	cmp dl, 88H  ; ł
	je zamL
	cmp dl, 0E4H ; ń
	je zamN
	cmp dl, 0A2H ; ó
	je zamO
	cmp dl, 98H  ; ś
	je zamS
	cmp dl, 0ABH ; Ź
	je zamZi
	cmp dl, 0BEH ; Ż
	je zamZe

	cmp dl, 'a'
	jb  dalej   ; skok, gdy znak nie wymaga zamiany
	cmp dl, 'z'
	ja  dalej   ; skok, gdy znak nie wymaga zamiany

	sub dl, 20H ; zamiana na wielkie litery innych liter
	mov magazyn[ebx], dl ; odesłanie znaku do pamięci
	jmp dalej

	zamA:
		sub dl, 1
		jmp dalej

	zamC:
		add dl, 9
		jmp dalej

	zamE:
		sub dl, 1
		jmp dalej

	zamL:
		add dl, 21
		jmp dalej

	zamN:
		sub dl, 1
		jmp dalej

	zamO:
		add dl, 62
		jmp dalej

	zamS:
		sub dl, 1
		jmp dalej

	zamZi:
		sub dl, 30
		jmp dalej

	zamZe:
		sub dl, 1
		jmp dalej


dalej:	mov magazyn[ebx], dl
		inc ebx ; inkrementacja indeksu
		dec ecx
		jnz ptl ; sterowanie pętlą

; wyświetlenie przekształconego tekstu
		push liczba_znakow
		push OFFSET magazyn
		push 1
		call __write ; wyświetlenie przekształconego tekstu

		add esp, 12 ; usuniecie parametrów ze stosu

		push 0
		call _ExitProcess@4 ; zakończenie programu
_main ENDP
END