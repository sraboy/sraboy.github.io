.t:004021DD crypto_4021DD:                          ; CODE XREF: .t:00402233j
.t:004021DD                 mov     dl, ds:byte_405090
.t:004021E3                 lea     eax, [ecx+esi]
.t:004021E6                 mov     bl, [ebp+eax-0BA8h]
.t:004021ED                 mov     eax, 7D8C42B3h
.t:004021F2                 xor     bl, dl
.t:004021F4                 imul    edi
.t:004021F6                 sar     edx, 8
.t:004021F9                 mov     eax, edx
.t:004021FB                 shr     eax, 1Fh
.t:004021FE                 add     edx, eax
.t:00402200                 mov     [ebp+edx-0BA8h], bl
.t:00402207                 mov     al, [ebp+esi-0BA8h]
.t:0040220E                 cmp     al, 44h
.t:00402210                 ja      short loc_40221B
.t:00402212                 dec     al
.t:00402214                 mov     [ebp+esi-0BA8h], al
.t:0040221B
.t:0040221B loc_40221B:                             ; CODE XREF: .t:00402210j
.t:0040221B                 inc     esi
.t:0040221C                 add     edi, 20Ah
.t:00402222                 mov     [ebp+8], esi
.t:00402225                 fild    dword ptr [ebp+8]
.t:00402228                 fcomp   ds:dbl_403AD0
.t:0040222E                 fnstsw  ax
.t:00402230                 test    ah, 44h
.t:00402233                 jnz     short crypto_4021DD
.t:00402235                 jmp     loc_4021A0