; Przykład wywoływania funkcji MessageBoxA i MessageBoxW
.686 
.model flat 
extern _ExitProcess@4 : PROC 
extern _MessageBoxA@16 : PROC 
extern _MessageBoxW@16 : PROC 
public _main

.data

test_unicode	dw 'T', 'o', ' ', 'j','e', 's','t', ' ', 'k','o','t', ' ', 0D83DH, 0DC08H, 'i', ' ', 'p', 'i', 'e', 's', 0D83DH, 0DC15H, 0


.code 
_main PROC


		; WYSWIETLANIE TEKSTU ;

		push 0 ; stala MB_OK 
; adres obszaru zawierającego tytuł 
		push OFFSET test_unicode 
; adres obszaru zawierającego tekst 
		push OFFSET test_unicode 
		push 0 ; NULL 
		call _MessageBoxW@16


		push 0 ; kod powrotu programu
		call _ExitProcess@4
_main	ENDP
END