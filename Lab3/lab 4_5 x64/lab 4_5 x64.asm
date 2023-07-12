
public suma_siedmiu_liczb

.code

	suma_siedmiu_liczb PROC

		push RBX
		mov RBX, RSP						; wierzcholek stosu do rbx

		mov RAX, RCX						; pierwszy argument
		add RAX, RDX						; drugi argument
		add RAX, R8							; trzeci argument
		add RAX, R9							; czwarty argument
		add RAX, [RBX + 32 + 8 + 8]			; RSP + shadow_space + slad call + offset
		add RAX, [RBX + 32 + 8 + 16]		; RSP + shadow_space + slad call + offset
		add RAX, [RBX + 32 + 8 + 24]		; RSP + shadow_space + slad call + offset

		pop RBX
		ret

	suma_siedmiu_liczb ENDP
END