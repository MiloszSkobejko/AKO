
.686
.XMM ; zezwolenie na asemblację rozkazów grupy SSE
.model flat
public _int2float


.code

_int2float PROC
	 push ebp
	 mov ebp, esp

	 push ebx
	 push esi
	 push edi

	 mov edi, [ebp+8] ; adres pierwszej tablicy
	 mov esi, [ebp+12] ; adres drugiej tablicy


	; konwersja tablicy
	 cvtpi2ps xmm5, qword PTR [edi]


	; zapisanie  tablicy w pamięci 
	movups [esi], xmm5

	 pop edi
	 pop esi
	 pop ebx
	 pop ebp

	 ret

_int2float ENDP

END 