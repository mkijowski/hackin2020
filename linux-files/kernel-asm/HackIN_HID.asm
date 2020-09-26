
HackIN_HID.ko:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <hid_hackin_probe>:
   0:	e8 00 00 00 00       	callq  5 <hid_hackin_probe+0x5>
   5:	53                   	push   %rbx
   6:	48 89 fb             	mov    %rdi,%rbx
   9:	48 83 ec 18          	sub    $0x18,%rsp
   d:	65 48 8b 04 25 28 00 	mov    %gs:0x28,%rax
  14:	00 00 
  16:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  1b:	31 c0                	xor    %eax,%eax
  1d:	81 8f 2c 1d 00 00 00 	orl    $0x800,0x1d2c(%rdi)
  24:	08 00 00 
  27:	e8 00 00 00 00       	callq  2c <hid_hackin_probe+0x2c>
  2c:	85 c0                	test   %eax,%eax
  2e:	75 43                	jne    73 <hid_hackin_probe+0x73>
  30:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  37:	31 c9                	xor    %ecx,%ecx
  39:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
  40:	48 89 e6             	mov    %rsp,%rsi
  43:	48 89 3c 24          	mov    %rdi,(%rsp)
  47:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
  4e:	00 00 
  50:	e8 00 00 00 00       	callq  55 <hid_hackin_probe+0x55>
  55:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
  5c:	bf 01 00 00 00       	mov    $0x1,%edi
  61:	e8 00 00 00 00       	callq  66 <hid_hackin_probe+0x66>
  66:	be 2d 00 00 00       	mov    $0x2d,%esi
  6b:	48 89 df             	mov    %rbx,%rdi
  6e:	e8 00 00 00 00       	callq  73 <hid_hackin_probe+0x73>
  73:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
  78:	65 48 33 14 25 28 00 	xor    %gs:0x28,%rdx
  7f:	00 00 
  81:	75 06                	jne    89 <hid_hackin_probe+0x89>
  83:	48 83 c4 18          	add    $0x18,%rsp
  87:	5b                   	pop    %rbx
  88:	c3                   	retq   
  89:	e8 00 00 00 00       	callq  8e <__UNIQUE_ID_srcversion19+0x16>

Disassembly of section .init.text:

0000000000000000 <init_module>:
   0:	e8 00 00 00 00       	callq  5 <init_module+0x5>
   5:	53                   	push   %rbx
   6:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx
   d:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi
  14:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  1b:	e8 00 00 00 00       	callq  20 <init_module+0x20>
  20:	89 c3                	mov    %eax,%ebx
  22:	85 c0                	test   %eax,%eax
  24:	74 0c                	je     32 <init_module+0x32>
  26:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  2d:	e8 00 00 00 00       	callq  32 <init_module+0x32>
  32:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  39:	e8 00 00 00 00       	callq  3e <init_module+0x3e>
  3e:	89 d8                	mov    %ebx,%eax
  40:	5b                   	pop    %rbx
  41:	c3                   	retq   

Disassembly of section .exit.text:

0000000000000000 <cleanup_module>:
   0:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
   7:	e9 00 00 00 00       	jmpq   c <cleanup_module+0xc>
