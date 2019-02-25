cmp     r14d, 2
movss   xmm6, cs:dword_396B376C
lea     r13, byte_396DD144
mov     r9, r13
mov     [rsp+468h+var_438], r13
jnb     loc_39688725

//Code above in hex

//33 C0 41
//83 FE 02 F3 0F 10 35 61  B1 02 00 4C 8D 2D 32 4B
//05 00 4D 8B CD 4C 89 6C  24 30 0F 83 05 01 00 00

movsxd  rdx, cs:dword_396DD140
or      rcx, 0FFFFFFFFFFFFFFFFh
xor     eax, eax
lea     rdi, aCorruptedDisco ; "Corrupted disconnect packet"
mov     [rsp+468h+arg_18], 1
repne scasb
not     rcx
lea     rbx, [rcx-1]
mov     ecx, cs:dword_396DD138
cmp     ecx, 1
jg      short loc_39688655