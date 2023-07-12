.686
.model flat

public _przeciwna

.code
	_przeciwna PROC

		push ebp			; zapisanie zawartości EBP na stosie
		mov ebp,esp			; kopiowanie zawartości ESP do EBP
		push ebx			; przechowanie zawartości rejestru EBX
		push ecx

	; wpisanie do rejestru EBX adresu zmiennej zdefiniowanej
	; w kodzie w języku C
		mov ebx, [ebp+8]
		mov ecx, -1

		mov eax, [ebx]		; odczytanie wartości zmiennej
		imul ecx
		mov [ebx], eax ; odesłanie wyniku do zmiennej

	; uwaga: trzy powyższe rozkazy można zastąpić jednym rozkazem
	; w postaci: inc dword PTR [ebx]
		
		pop ecx
		pop ebx
		pop ebp
		ret

	_przeciwna ENDP
END