.686
.model flat

public _odejmij_jeden

.code
	_odejmij_jeden PROC

		push ebp			; zapisanie zawartości EBP na stosie
		mov ebp,esp			; kopiowanie zawartości ESP do EBP
		push ebx			; przechowanie zawartości rejestru EBX
		push ecx

	; wpisanie w ebx adresu na adres k (adresu wsk)
		mov ebx, [ebp+8]	;przekazanie adresu na adres do ebx

		mov ecx, [ebx]		; odczytanie wartości adresu wsk
		mov eax, [ecx]		; przkazanie adresu na jaki wskazuje wsk
		dec eax				
		mov [ecx], eax		; odesłanie adresu do zmiennej
		mov [ebx], ecx		; odesłanie wyniku do zmiennej
		
	; koniec podprogramu
		
		pop ecx
		pop ebx
		pop ebp
		ret

	_odejmij_jeden ENDP
END