.data

.balign 4
maxi: .word 0
red: .word 0
green: .word 0
blue: .word 0
p2_maxi: .word 0

.text
.global grayscale
.func grayscale

grayscale:
assign:
  ldr ip, addr_maxi
  str r1, [ip]
  ldr ip, addr_red
  str r1, [ip]
  ldr ip, addr_green
  str r1, [ip]
  ldr ip, addr_blue
  str r1, [ip]
  ldr ip, addr_p2_maxi
  str r1, [ip]
grayscale_loop:
  ldr r1, [r2]
  add r2, r2, #1
  ldr ip, [r2]
  add r1, r1, ip
  add r2, r2, #1
  ldr ip, [r2]
  add r1, r1, ip
  add r2, r2, #1
  ldr ip, maxi
  @sdiv r1, r1, ip
  str r1, [r3]
  sub r0, r0, #1
  add r3, r3, #1
  cmp r0, #0
  bne grayscale_loop
  bx lr

addr_maxi: .word maxi
addr_red: .word red
addr_green: .word green
addr_blue: .word blue
addr_p2_maxi: .word p2_maxi
