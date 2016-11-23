global unsplice

section .text

unsplice:
  movaps xmm0, [rdi]  	;dane
	movaps xmm1, xmm0

	;; ;; Wycinka (wahadełkiem): 0 Y1 0 Y2 0 Y3 0 Y4 0 Y5 0 Y6 0 Y7 0 Y8
	psllw xmm0, 8
	psrlw xmm0, 8
	;; ;; Wycinka: 0 X1 0 X2 0 X3 0 X4 0 X5 0 X6 0 X7 0 X8
	psrlw xmm1, 8

        ;; ;; Zgęszczamy: Y1Y2 Y3Y4 Y5Y6 Y7Y8 Y1Y2 Y3Y4 Y5Y6 Y7Y8
	packuswb xmm0, xmm0
	packuswb xmm1, xmm1

	;; ;; Bierzemy po 8 bajtów (bez wyrównania do 16)
	movq [rdx], xmm0 	;dane2
	movq [rsi], xmm1 	;dane1
	ret
