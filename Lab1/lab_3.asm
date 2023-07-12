; wczytywanie i wyświetlanie tekstu wielkimi literami
; (inne znaki się nie zmieniają)

.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC 
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

kot_emo	dw 0D83DH, 0DC08H
malpka	dw 0D83DH, 0DC12H

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
		mov eax, 0				; do zliczania duzych


ptl:
	mov dl, magazyn[ebx] ; pobranie kolejnego znaku



	cmp dl, 'A'
	jb  dalej   ; skok, gdy znak nie wymaga zamiany
	cmp dl, 'Z'
	ja  dalej   ; skok, gdy znak nie wymaga zamiany

	mov dl, 0	; usuniecie znaku
	add ax, 1	; dodanie 1 do licznika petli
	mov magazyn[ebx], dl ; odesłanie znaku do pamięci
	jmp dalej



dalej:	
		inc ebx ; inkrementacja indeksu
		dec ecx
		jnz ptl ; sterowanie pętlą


;spawdzanie ile duzych 

cmp eax, 4
ja kot

; Wyświetlanie malpki

		; WYSWIETLANIE TEKSTU ;

		push 0 ; stala MB_OK  
		push OFFSET malpka 
		push OFFSET malpka 
		push 0 ; NULL 
		call _MessageBoxW@16
		jmp koniec
		

; Wyświetlanie kota
kot:
			; WYSWIETLANIE TEKSTU ;

		push 0 ; stala MB_OK  
		push OFFSET kot_emo 
		push OFFSET kot_emo 
		push 0 ; NULL 
		call _MessageBoxW@16
		jmp koniec

	
koniec:
; wyświetlenie przekształconego tekstu
		push liczba_znakow
		push OFFSET magazyn
		push 1
		call __write ; wyświetlenie przekształconego tekstu
		add esp, 12 ; usuniecie parametrów ze stosu

push 0 ; kod powrotu programu
;call _ExitProcess@4
		
_main ENDP
END