EXTERN	fileNameProc1ReturnAddress	:	QWORD
EXTERN	fileNameProc2ReturnAddress	:	QWORD
EXTERN	fileNameProc2CallAddress	:	QWORD
EXTERN	fileNameProcEscapedStrToUtf8	:	QWORD
EXTERN	fileNameProcUtf8ToEscapedStr	:	QWORD
EXTERN	fileNameProcReplaceTextObject	:	QWORD
EXTERN	fileNameProc4ReturnAddress	:	QWORD

ESCAPE_SEQ_1	=	10h
ESCAPE_SEQ_2	=	11h
ESCAPE_SEQ_3	=	12h
ESCAPE_SEQ_4	=	13h
LOW_SHIFT		=	0Fh
HIGH_SHIFT		=	9h
SHIFT_2			=	LOW_SHIFT
SHIFT_3			=	900h
SHIFT_4			=	8F1h
NO_FONT			=	98Fh
NOT_DEF			=	2026h


.CODE
fileNameProc1 PROC
	movsxd  r10, dword ptr [rcx+10h];

	push	fileNameProc1ReturnAddress;
	ret;
fileNameProc1 ENDP

;----------------------;

fileNameProc2 PROC
	lea     rcx, [rbp - 60h];
	call	fileNameProcEscapedStrToUtf8;

	lea		rcx, [rbp - 60h];
	mov		rdx, rax;
	call	fileNameProcReplaceTextObject;

	lea     rcx, [rbp - 60h];
	lea     rdx, [rsp + 218h - 1B8h];
	call	fileNameProc2CallAddress;

	mov		r8, qword ptr [rsp + 218h -1A0h];
	push	fileNameProc2ReturnAddress;
	ret;
fileNameProc2 ENDP

;----------------------;

fileNameProc4 PROC

	lea		rcx, [r15 + 50h];
	call	fileNameProcUtf8ToEscapedStr;

	lea		rcx, [r15 + 50h];
	mov		rdx, rax;
	call	fileNameProcReplaceTextObject;

	; 以下元のコード
	lea		rdx, [rsp + 138h - 0F8h];
	cmp		qword ptr [rsp + 138h - 0E0h], 10h
	cmovnb  rdx, qword ptr [rsp + 138h - 0F8h];

	push	fileNameProc4ReturnAddress;
	ret;
fileNameProc4 ENDP

;----------------------;

END