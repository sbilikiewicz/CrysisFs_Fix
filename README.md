# CrysisFs Simple Hex Fix


## Bug

In Crysis the packet with type 0x08 is the disconnection packet and is
composed by an additional 8bit field which specifies the type of error
message and the textual message which, depending by its type, is
displayed directly in the server's console.

Although it's a "disconnection" packet it's enough to send a join
request (even invalid and with a wrong cdkey) for enabling its handling
and so without limitations for the attacker which can even spoof them.

This little introduction to this type of packet is necessary only to
explain one of the ways (or probably the only one because various other
tests performed after the release of this advisory have ever given
negative results so consider this format string related to the
disconnection packet only) for exploiting a security vulnerability
affecting the logging/display function of the game where the messages
(previously built with a vsprintf_s for adding the timestamp) are
passed to _vsnprintf without the necessary format argument:

  _vsnprintf(buffer, 4096, message);

The resulted format string vulnerability leads to the immediate crash
of the server and the "possible" (not verified) execution of code.

## Fix

<pre><code>
cmp     r14d, 2
movss   xmm6, cs:dword_396B376C
lea     r13, byte_396DD144
mov     r9, r13
mov     [rsp+468h+var_438], r13
jnb     loc_39688725

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
</code></pre>

To fix server crashing problem just open Bin64/CryNetwork.dll 
and replace jnb loc_396887250F(83 05 01 00 00) with 90 90 90 90 90 90
This gonna force server process some disconnect packets as corrupted
making  
