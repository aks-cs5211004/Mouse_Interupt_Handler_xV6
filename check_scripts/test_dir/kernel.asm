
kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot_header>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4                   	.byte 0xe4

0010000c <_start>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
  10000c:	bc e0 3c 10 00       	mov    $0x103ce0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
  100011:	b8 b0 06 10 00       	mov    $0x1006b0,%eax
  jmp *%eax
  100016:	ff e0                	jmp    *%eax
  100018:	66 90                	xchg   %ax,%ax
  10001a:	66 90                	xchg   %ax,%ax
  10001c:	66 90                	xchg   %ax,%ax
  10001e:	66 90                	xchg   %ax,%ax

00100020 <printint>:
static void consputc(int);
static int panicked = 0;

static void
printint(int xx, int base, int sign)
{
  100020:	55                   	push   %ebp
  100021:	89 e5                	mov    %esp,%ebp
  100023:	57                   	push   %edi
  100024:	56                   	push   %esi
  100025:	53                   	push   %ebx
  100026:	83 ec 2c             	sub    $0x2c,%esp
  100029:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  10002c:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
  10002f:	85 c9                	test   %ecx,%ecx
  100031:	74 04                	je     100037 <printint+0x17>
  100033:	85 c0                	test   %eax,%eax
  100035:	78 79                	js     1000b0 <printint+0x90>
    x = -xx;
  else
    x = xx;
  100037:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
  10003e:	89 c1                	mov    %eax,%ecx

  i = 0;
  100040:	31 db                	xor    %ebx,%ebx
  100042:	8d 7d d7             	lea    -0x29(%ebp),%edi
  100045:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
  100048:	89 c8                	mov    %ecx,%eax
  10004a:	31 d2                	xor    %edx,%edx
  10004c:	89 ce                	mov    %ecx,%esi
  10004e:	f7 75 d4             	divl   -0x2c(%ebp)
  100051:	0f be 92 00 1c 10 00 	movsbl 0x101c00(%edx),%edx
  100058:	89 45 d0             	mov    %eax,-0x30(%ebp)
  10005b:	89 d8                	mov    %ebx,%eax
  10005d:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
  100060:	8b 4d d0             	mov    -0x30(%ebp),%ecx
    buf[i++] = digits[x % base];
  100063:	88 14 1f             	mov    %dl,(%edi,%ebx,1)
  }while((x /= base) != 0);
  100066:	3b 75 d4             	cmp    -0x2c(%ebp),%esi
  100069:	73 dd                	jae    100048 <printint+0x28>

  if(sign)
  10006b:	89 c6                	mov    %eax,%esi
  10006d:	8b 45 cc             	mov    -0x34(%ebp),%eax
  100070:	85 c0                	test   %eax,%eax
  100072:	74 0c                	je     100080 <printint+0x60>
    buf[i++] = '-';
  100074:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
  100079:	89 de                	mov    %ebx,%esi
    buf[i++] = '-';
  10007b:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
  100080:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
  100084:	eb 10                	jmp    100096 <printint+0x76>
  100086:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10008d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i]);
  100090:	0f be 13             	movsbl (%ebx),%edx
  100093:	83 eb 01             	sub    $0x1,%ebx
consputc(int c)
{
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  100096:	83 ec 0c             	sub    $0xc,%esp
  100099:	52                   	push   %edx
  10009a:	e8 01 0a 00 00       	call   100aa0 <uartputc>
  while(--i >= 0)
  10009f:	83 c4 10             	add    $0x10,%esp
  1000a2:	39 fb                	cmp    %edi,%ebx
  1000a4:	75 ea                	jne    100090 <printint+0x70>
}
  1000a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  1000a9:	5b                   	pop    %ebx
  1000aa:	5e                   	pop    %esi
  1000ab:	5f                   	pop    %edi
  1000ac:	5d                   	pop    %ebp
  1000ad:	c3                   	ret    
  1000ae:	66 90                	xchg   %ax,%ax
    x = -xx;
  1000b0:	f7 d8                	neg    %eax
  1000b2:	89 c1                	mov    %eax,%ecx
  1000b4:	eb 8a                	jmp    100040 <printint+0x20>
  1000b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1000bd:	8d 76 00             	lea    0x0(%esi),%esi

001000c0 <cprintf>:
{
  1000c0:	55                   	push   %ebp
  1000c1:	89 e5                	mov    %esp,%ebp
  1000c3:	57                   	push   %edi
  1000c4:	56                   	push   %esi
  1000c5:	53                   	push   %ebx
  1000c6:	83 ec 1c             	sub    $0x1c,%esp
  if (fmt == 0)
  1000c9:	8b 75 08             	mov    0x8(%ebp),%esi
  1000cc:	85 f6                	test   %esi,%esi
  1000ce:	74 7b                	je     10014b <cprintf+0x8b>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  1000d0:	0f b6 16             	movzbl (%esi),%edx
  1000d3:	85 d2                	test   %edx,%edx
  1000d5:	74 74                	je     10014b <cprintf+0x8b>
  argp = (uint*)(void*)(&fmt + 1);
  1000d7:	8d 45 0c             	lea    0xc(%ebp),%eax
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  1000da:	31 db                	xor    %ebx,%ebx
  1000dc:	eb 4b                	jmp    100129 <cprintf+0x69>
  1000de:	66 90                	xchg   %ax,%ax
    c = fmt[++i] & 0xff;
  1000e0:	83 c3 01             	add    $0x1,%ebx
  1000e3:	0f b6 3c 1e          	movzbl (%esi,%ebx,1),%edi
    if(c == 0)
  1000e7:	85 ff                	test   %edi,%edi
  1000e9:	74 60                	je     10014b <cprintf+0x8b>
    switch(c){
  1000eb:	83 ff 70             	cmp    $0x70,%edi
  1000ee:	0f 84 b1 00 00 00    	je     1001a5 <cprintf+0xe5>
  1000f4:	7f 62                	jg     100158 <cprintf+0x98>
  1000f6:	83 ff 25             	cmp    $0x25,%edi
  1000f9:	0f 84 e1 00 00 00    	je     1001e0 <cprintf+0x120>
  1000ff:	83 ff 64             	cmp    $0x64,%edi
  100102:	0f 85 b5 00 00 00    	jne    1001bd <cprintf+0xfd>
      printint(*argp++, 10, 1);
  100108:	8d 78 04             	lea    0x4(%eax),%edi
  10010b:	8b 00                	mov    (%eax),%eax
  10010d:	b9 01 00 00 00       	mov    $0x1,%ecx
  100112:	ba 0a 00 00 00       	mov    $0xa,%edx
  100117:	e8 04 ff ff ff       	call   100020 <printint>
  10011c:	89 f8                	mov    %edi,%eax
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  10011e:	83 c3 01             	add    $0x1,%ebx
  100121:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
  100125:	85 d2                	test   %edx,%edx
  100127:	74 22                	je     10014b <cprintf+0x8b>
    if(c != '%'){
  100129:	83 fa 25             	cmp    $0x25,%edx
  10012c:	74 b2                	je     1000e0 <cprintf+0x20>
    uartputc(c);
  10012e:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  100131:	83 c3 01             	add    $0x1,%ebx
  100134:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    uartputc(c);
  100137:	52                   	push   %edx
  100138:	e8 63 09 00 00       	call   100aa0 <uartputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  10013d:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
      continue;
  100141:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100144:	83 c4 10             	add    $0x10,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
  100147:	85 d2                	test   %edx,%edx
  100149:	75 de                	jne    100129 <cprintf+0x69>
}
  10014b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  10014e:	5b                   	pop    %ebx
  10014f:	5e                   	pop    %esi
  100150:	5f                   	pop    %edi
  100151:	5d                   	pop    %ebp
  100152:	c3                   	ret    
  100153:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100157:	90                   	nop
    switch(c){
  100158:	83 ff 73             	cmp    $0x73,%edi
  10015b:	75 43                	jne    1001a0 <cprintf+0xe0>
      if((s = (char*)*argp++) == 0)
  10015d:	8d 48 04             	lea    0x4(%eax),%ecx
  100160:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  100163:	8b 08                	mov    (%eax),%ecx
  100165:	85 c9                	test   %ecx,%ecx
  100167:	0f 84 93 00 00 00    	je     100200 <cprintf+0x140>
      for(; *s; s++)
  10016d:	0f be 11             	movsbl (%ecx),%edx
      if((s = (char*)*argp++) == 0)
  100170:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100173:	89 cf                	mov    %ecx,%edi
      for(; *s; s++)
  100175:	84 d2                	test   %dl,%dl
  100177:	74 a5                	je     10011e <cprintf+0x5e>
  100179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartputc(c);
  100180:	83 ec 0c             	sub    $0xc,%esp
      for(; *s; s++)
  100183:	83 c7 01             	add    $0x1,%edi
    uartputc(c);
  100186:	52                   	push   %edx
  100187:	e8 14 09 00 00       	call   100aa0 <uartputc>
      for(; *s; s++)
  10018c:	0f be 17             	movsbl (%edi),%edx
  10018f:	83 c4 10             	add    $0x10,%esp
  100192:	84 d2                	test   %dl,%dl
  100194:	75 ea                	jne    100180 <cprintf+0xc0>
    uartputc(c);
  100196:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100199:	eb 83                	jmp    10011e <cprintf+0x5e>
  10019b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10019f:	90                   	nop
    switch(c){
  1001a0:	83 ff 78             	cmp    $0x78,%edi
  1001a3:	75 18                	jne    1001bd <cprintf+0xfd>
      printint(*argp++, 16, 0);
  1001a5:	8d 78 04             	lea    0x4(%eax),%edi
  1001a8:	8b 00                	mov    (%eax),%eax
  1001aa:	31 c9                	xor    %ecx,%ecx
  1001ac:	ba 10 00 00 00       	mov    $0x10,%edx
  1001b1:	e8 6a fe ff ff       	call   100020 <printint>
  1001b6:	89 f8                	mov    %edi,%eax
      break;
  1001b8:	e9 61 ff ff ff       	jmp    10011e <cprintf+0x5e>
    uartputc(c);
  1001bd:	83 ec 0c             	sub    $0xc,%esp
  1001c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1001c3:	6a 25                	push   $0x25
  1001c5:	e8 d6 08 00 00       	call   100aa0 <uartputc>
  1001ca:	89 3c 24             	mov    %edi,(%esp)
  1001cd:	e8 ce 08 00 00       	call   100aa0 <uartputc>
  1001d2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1001d5:	83 c4 10             	add    $0x10,%esp
  1001d8:	e9 41 ff ff ff       	jmp    10011e <cprintf+0x5e>
  1001dd:	8d 76 00             	lea    0x0(%esi),%esi
  1001e0:	83 ec 0c             	sub    $0xc,%esp
  1001e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1001e6:	6a 25                	push   $0x25
  1001e8:	e8 b3 08 00 00       	call   100aa0 <uartputc>
}
  1001ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1001f0:	83 c4 10             	add    $0x10,%esp
  1001f3:	e9 26 ff ff ff       	jmp    10011e <cprintf+0x5e>
  1001f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1001ff:	90                   	nop
        s = "(null)";
  100200:	bf d0 1b 10 00       	mov    $0x101bd0,%edi
      for(; *s; s++)
  100205:	ba 28 00 00 00       	mov    $0x28,%edx
  10020a:	e9 71 ff ff ff       	jmp    100180 <cprintf+0xc0>
  10020f:	90                   	nop

00100210 <halt>:
{
  100210:	55                   	push   %ebp
  100211:	89 e5                	mov    %esp,%ebp
  100213:	83 ec 10             	sub    $0x10,%esp
  cprintf("Bye COL%d!\n\0", 331);
  100216:	68 4b 01 00 00       	push   $0x14b
  10021b:	68 f0 1b 10 00       	push   $0x101bf0
  100220:	e8 9b fe ff ff       	call   1000c0 <cprintf>
}

static inline void
outw(ushort port, ushort data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100225:	b8 00 20 00 00       	mov    $0x2000,%eax
  10022a:	ba 02 06 00 00       	mov    $0x602,%edx
  10022f:	66 ef                	out    %ax,(%dx)
  100231:	ba 02 b0 ff ff       	mov    $0xffffb002,%edx
  100236:	66 ef                	out    %ax,(%dx)
}
  100238:	83 c4 10             	add    $0x10,%esp
  for(;;);
  10023b:	eb fe                	jmp    10023b <halt+0x2b>
  10023d:	8d 76 00             	lea    0x0(%esi),%esi

00100240 <panic>:
{
  100240:	55                   	push   %ebp
  100241:	89 e5                	mov    %esp,%ebp
  100243:	56                   	push   %esi
  100244:	53                   	push   %ebx
  100245:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
  100248:	fa                   	cli    
  cprintf("lapicid %d: panic: ", lapicid());
  100249:	e8 12 04 00 00       	call   100660 <lapicid>
  10024e:	83 ec 08             	sub    $0x8,%esp
  getcallerpcs(&s, pcs);
  100251:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  100254:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
  100257:	50                   	push   %eax
  100258:	68 d7 1b 10 00       	push   $0x101bd7
  10025d:	e8 5e fe ff ff       	call   1000c0 <cprintf>
  cprintf(s);
  100262:	58                   	pop    %eax
  100263:	ff 75 08             	push   0x8(%ebp)
  100266:	e8 55 fe ff ff       	call   1000c0 <cprintf>
  cprintf("\n");
  10026b:	c7 04 24 a9 1c 10 00 	movl   $0x101ca9,(%esp)
  100272:	e8 49 fe ff ff       	call   1000c0 <cprintf>
  getcallerpcs(&s, pcs);
  100277:	8d 45 08             	lea    0x8(%ebp),%eax
  10027a:	5a                   	pop    %edx
  10027b:	59                   	pop    %ecx
  10027c:	53                   	push   %ebx
  10027d:	50                   	push   %eax
  10027e:	e8 3d 0d 00 00       	call   100fc0 <getcallerpcs>
  for(i=0; i<10; i++)
  100283:	83 c4 10             	add    $0x10,%esp
  100286:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10028d:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf(" %p", pcs[i]);
  100290:	83 ec 08             	sub    $0x8,%esp
  100293:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
  100295:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
  100298:	68 eb 1b 10 00       	push   $0x101beb
  10029d:	e8 1e fe ff ff       	call   1000c0 <cprintf>
  for(i=0; i<10; i++)
  1002a2:	83 c4 10             	add    $0x10,%esp
  1002a5:	39 f3                	cmp    %esi,%ebx
  1002a7:	75 e7                	jne    100290 <panic+0x50>
  halt();
  1002a9:	e8 62 ff ff ff       	call   100210 <halt>
  1002ae:	66 90                	xchg   %ax,%ax

001002b0 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
  1002b0:	55                   	push   %ebp
  1002b1:	89 e5                	mov    %esp,%ebp
  1002b3:	53                   	push   %ebx
  1002b4:	83 ec 14             	sub    $0x14,%esp
  1002b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c;

  while((c = getc()) >= 0){
  1002ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1002c0:	ff d3                	call   *%ebx
  1002c2:	85 c0                	test   %eax,%eax
  1002c4:	0f 88 9b 00 00 00    	js     100365 <consoleintr+0xb5>
    switch(c){
  1002ca:	83 f8 15             	cmp    $0x15,%eax
  1002cd:	0f 84 9d 00 00 00    	je     100370 <consoleintr+0xc0>
  1002d3:	83 f8 7f             	cmp    $0x7f,%eax
  1002d6:	0f 84 04 01 00 00    	je     1003e0 <consoleintr+0x130>
  1002dc:	83 f8 08             	cmp    $0x8,%eax
  1002df:	0f 84 fb 00 00 00    	je     1003e0 <consoleintr+0x130>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
  1002e5:	85 c0                	test   %eax,%eax
  1002e7:	74 d7                	je     1002c0 <consoleintr+0x10>
  1002e9:	8b 15 88 24 10 00    	mov    0x102488,%edx
  1002ef:	89 d1                	mov    %edx,%ecx
  1002f1:	2b 0d 80 24 10 00    	sub    0x102480,%ecx
  1002f7:	83 f9 7f             	cmp    $0x7f,%ecx
  1002fa:	77 c4                	ja     1002c0 <consoleintr+0x10>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
  1002fc:	8d 4a 01             	lea    0x1(%edx),%ecx
  1002ff:	83 e2 7f             	and    $0x7f,%edx
  100302:	89 0d 88 24 10 00    	mov    %ecx,0x102488
        c = (c == '\r') ? '\n' : c;
  100308:	83 f8 0d             	cmp    $0xd,%eax
  10030b:	0f 84 12 01 00 00    	je     100423 <consoleintr+0x173>
        input.buf[input.e++ % INPUT_BUF] = c;
  100311:	88 82 00 24 10 00    	mov    %al,0x102400(%edx)
  if(c == BACKSPACE){
  100317:	3d 00 01 00 00       	cmp    $0x100,%eax
  10031c:	0f 85 24 01 00 00    	jne    100446 <consoleintr+0x196>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  100322:	83 ec 0c             	sub    $0xc,%esp
  100325:	6a 08                	push   $0x8
  100327:	e8 74 07 00 00       	call   100aa0 <uartputc>
  10032c:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  100333:	e8 68 07 00 00       	call   100aa0 <uartputc>
  100338:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10033f:	e8 5c 07 00 00       	call   100aa0 <uartputc>
  100344:	83 c4 10             	add    $0x10,%esp
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
  100347:	a1 80 24 10 00       	mov    0x102480,%eax
  10034c:	83 e8 80             	sub    $0xffffff80,%eax
  10034f:	39 05 88 24 10 00    	cmp    %eax,0x102488
  100355:	0f 84 e1 00 00 00    	je     10043c <consoleintr+0x18c>
  while((c = getc()) >= 0){
  10035b:	ff d3                	call   *%ebx
  10035d:	85 c0                	test   %eax,%eax
  10035f:	0f 89 65 ff ff ff    	jns    1002ca <consoleintr+0x1a>
        }
      }
      break;
    }
  }
  100365:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100368:	c9                   	leave  
  100369:	c3                   	ret    
  10036a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
  100370:	a1 88 24 10 00       	mov    0x102488,%eax
  100375:	3b 05 84 24 10 00    	cmp    0x102484,%eax
  10037b:	75 46                	jne    1003c3 <consoleintr+0x113>
  10037d:	e9 3e ff ff ff       	jmp    1002c0 <consoleintr+0x10>
  100382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
  100388:	83 ec 0c             	sub    $0xc,%esp
        input.e--;
  10038b:	a3 88 24 10 00       	mov    %eax,0x102488
    uartputc('\b'); uartputc(' '); uartputc('\b');
  100390:	6a 08                	push   $0x8
  100392:	e8 09 07 00 00       	call   100aa0 <uartputc>
  100397:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10039e:	e8 fd 06 00 00       	call   100aa0 <uartputc>
  1003a3:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1003aa:	e8 f1 06 00 00       	call   100aa0 <uartputc>
      while(input.e != input.w &&
  1003af:	a1 88 24 10 00       	mov    0x102488,%eax
  1003b4:	83 c4 10             	add    $0x10,%esp
  1003b7:	3b 05 84 24 10 00    	cmp    0x102484,%eax
  1003bd:	0f 84 fd fe ff ff    	je     1002c0 <consoleintr+0x10>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
  1003c3:	83 e8 01             	sub    $0x1,%eax
  1003c6:	89 c2                	mov    %eax,%edx
  1003c8:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
  1003cb:	80 ba 00 24 10 00 0a 	cmpb   $0xa,0x102400(%edx)
  1003d2:	75 b4                	jne    100388 <consoleintr+0xd8>
  1003d4:	e9 e7 fe ff ff       	jmp    1002c0 <consoleintr+0x10>
  1003d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(input.e != input.w){
  1003e0:	a1 88 24 10 00       	mov    0x102488,%eax
  1003e5:	3b 05 84 24 10 00    	cmp    0x102484,%eax
  1003eb:	0f 84 cf fe ff ff    	je     1002c0 <consoleintr+0x10>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  1003f1:	83 ec 0c             	sub    $0xc,%esp
        input.e--;
  1003f4:	83 e8 01             	sub    $0x1,%eax
    uartputc('\b'); uartputc(' '); uartputc('\b');
  1003f7:	6a 08                	push   $0x8
        input.e--;
  1003f9:	a3 88 24 10 00       	mov    %eax,0x102488
    uartputc('\b'); uartputc(' '); uartputc('\b');
  1003fe:	e8 9d 06 00 00       	call   100aa0 <uartputc>
  100403:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10040a:	e8 91 06 00 00       	call   100aa0 <uartputc>
  10040f:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  100416:	e8 85 06 00 00       	call   100aa0 <uartputc>
  10041b:	83 c4 10             	add    $0x10,%esp
  10041e:	e9 9d fe ff ff       	jmp    1002c0 <consoleintr+0x10>
    uartputc(c);
  100423:	83 ec 0c             	sub    $0xc,%esp
        input.buf[input.e++ % INPUT_BUF] = c;
  100426:	c6 82 00 24 10 00 0a 	movb   $0xa,0x102400(%edx)
    uartputc(c);
  10042d:	6a 0a                	push   $0xa
  10042f:	e8 6c 06 00 00       	call   100aa0 <uartputc>
          input.w = input.e;
  100434:	a1 88 24 10 00       	mov    0x102488,%eax
  100439:	83 c4 10             	add    $0x10,%esp
  10043c:	a3 84 24 10 00       	mov    %eax,0x102484
  100441:	e9 7a fe ff ff       	jmp    1002c0 <consoleintr+0x10>
    uartputc(c);
  100446:	83 ec 0c             	sub    $0xc,%esp
  100449:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10044c:	50                   	push   %eax
  10044d:	e8 4e 06 00 00       	call   100aa0 <uartputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
  100452:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100455:	83 c4 10             	add    $0x10,%esp
  100458:	83 f8 0a             	cmp    $0xa,%eax
  10045b:	74 09                	je     100466 <consoleintr+0x1b6>
  10045d:	83 f8 04             	cmp    $0x4,%eax
  100460:	0f 85 e1 fe ff ff    	jne    100347 <consoleintr+0x97>
          input.w = input.e;
  100466:	a1 88 24 10 00       	mov    0x102488,%eax
  10046b:	eb cf                	jmp    10043c <consoleintr+0x18c>
  10046d:	66 90                	xchg   %ax,%ax
  10046f:	90                   	nop

00100470 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
  100470:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  100471:	c7 05 8c 24 10 00 00 	movl   $0xfec00000,0x10248c
  100478:	00 c0 fe 
{
  10047b:	89 e5                	mov    %esp,%ebp
  10047d:	56                   	push   %esi
  10047e:	53                   	push   %ebx
  ioapic->reg = reg;
  10047f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
  100486:	00 00 00 
  return ioapic->data;
  100489:	8b 15 8c 24 10 00    	mov    0x10248c,%edx
  10048f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
  100492:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
  100498:	8b 0d 8c 24 10 00    	mov    0x10248c,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
  10049e:	0f b6 15 94 24 10 00 	movzbl 0x102494,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  1004a5:	c1 ee 10             	shr    $0x10,%esi
  1004a8:	89 f0                	mov    %esi,%eax
  1004aa:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
  1004ad:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
  1004b0:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
  1004b3:	39 c2                	cmp    %eax,%edx
  1004b5:	74 16                	je     1004cd <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
  1004b7:	83 ec 0c             	sub    $0xc,%esp
  1004ba:	68 14 1c 10 00       	push   $0x101c14
  1004bf:	e8 fc fb ff ff       	call   1000c0 <cprintf>
  ioapic->reg = reg;
  1004c4:	8b 0d 8c 24 10 00    	mov    0x10248c,%ecx
  1004ca:	83 c4 10             	add    $0x10,%esp
  1004cd:	83 c6 21             	add    $0x21,%esi
{
  1004d0:	ba 10 00 00 00       	mov    $0x10,%edx
  1004d5:	b8 20 00 00 00       	mov    $0x20,%eax
  1004da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
  1004e0:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
  1004e2:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
  1004e4:	8b 0d 8c 24 10 00    	mov    0x10248c,%ecx
  for(i = 0; i <= maxintr; i++){
  1004ea:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
  1004ed:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
  1004f3:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
  1004f6:	8d 5a 01             	lea    0x1(%edx),%ebx
  for(i = 0; i <= maxintr; i++){
  1004f9:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
  1004fc:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
  1004fe:	8b 0d 8c 24 10 00    	mov    0x10248c,%ecx
  100504:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
  10050b:	39 f0                	cmp    %esi,%eax
  10050d:	75 d1                	jne    1004e0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
  10050f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  100512:	5b                   	pop    %ebx
  100513:	5e                   	pop    %esi
  100514:	5d                   	pop    %ebp
  100515:	c3                   	ret    
  100516:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10051d:	8d 76 00             	lea    0x0(%esi),%esi

00100520 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
  100520:	55                   	push   %ebp
  ioapic->reg = reg;
  100521:	8b 0d 8c 24 10 00    	mov    0x10248c,%ecx
{
  100527:	89 e5                	mov    %esp,%ebp
  100529:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  10052c:	8d 50 20             	lea    0x20(%eax),%edx
  10052f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
  100533:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
  100535:	8b 0d 8c 24 10 00    	mov    0x10248c,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  10053b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
  10053e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  100541:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
  100544:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
  100546:	a1 8c 24 10 00       	mov    0x10248c,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  10054b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
  10054e:	89 50 10             	mov    %edx,0x10(%eax)
}
  100551:	5d                   	pop    %ebp
  100552:	c3                   	ret    
  100553:	66 90                	xchg   %ax,%ax
  100555:	66 90                	xchg   %ax,%ax
  100557:	66 90                	xchg   %ax,%ax
  100559:	66 90                	xchg   %ax,%ax
  10055b:	66 90                	xchg   %ax,%ax
  10055d:	66 90                	xchg   %ax,%ax
  10055f:	90                   	nop

00100560 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
  100560:	a1 90 24 10 00       	mov    0x102490,%eax
  100565:	85 c0                	test   %eax,%eax
  100567:	0f 84 cb 00 00 00    	je     100638 <lapicinit+0xd8>
  lapic[index] = value;
  10056d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
  100574:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
  100577:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  10057a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
  100581:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  100584:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  100587:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
  10058e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
  100591:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  100594:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
  10059b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
  10059e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  1005a1:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
  1005a8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  1005ab:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  1005ae:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
  1005b5:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  1005b8:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
  1005bb:	8b 50 30             	mov    0x30(%eax),%edx
  1005be:	c1 ea 10             	shr    $0x10,%edx
  1005c1:	81 e2 fc 00 00 00    	and    $0xfc,%edx
  1005c7:	75 77                	jne    100640 <lapicinit+0xe0>
  lapic[index] = value;
  1005c9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
  1005d0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1005d3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  1005d6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  1005dd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1005e0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  1005e3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  1005ea:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1005ed:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  1005f0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  1005f7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1005fa:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  1005fd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
  100604:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  100607:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
  10060a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
  100611:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
  100614:	8b 50 20             	mov    0x20(%eax),%edx
  100617:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10061e:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
  100620:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
  100626:	80 e6 10             	and    $0x10,%dh
  100629:	75 f5                	jne    100620 <lapicinit+0xc0>
  lapic[index] = value;
  10062b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
  100632:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  100635:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
  100638:	c3                   	ret    
  100639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
  100640:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
  100647:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  10064a:	8b 50 20             	mov    0x20(%eax),%edx
}
  10064d:	e9 77 ff ff ff       	jmp    1005c9 <lapicinit+0x69>
  100652:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100660 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
  100660:	a1 90 24 10 00       	mov    0x102490,%eax
  100665:	85 c0                	test   %eax,%eax
  100667:	74 07                	je     100670 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
  100669:	8b 40 20             	mov    0x20(%eax),%eax
  10066c:	c1 e8 18             	shr    $0x18,%eax
  10066f:	c3                   	ret    
    return 0;
  100670:	31 c0                	xor    %eax,%eax
}
  100672:	c3                   	ret    
  100673:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10067a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100680 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
  100680:	a1 90 24 10 00       	mov    0x102490,%eax
  100685:	85 c0                	test   %eax,%eax
  100687:	74 0d                	je     100696 <lapiceoi+0x16>
  lapic[index] = value;
  100689:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  100690:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  100693:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
  100696:	c3                   	ret    
  100697:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10069e:	66 90                	xchg   %ax,%ax

001006a0 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
  1006a0:	c3                   	ret    
  1006a1:	66 90                	xchg   %ax,%ax
  1006a3:	66 90                	xchg   %ax,%ax
  1006a5:	66 90                	xchg   %ax,%ax
  1006a7:	66 90                	xchg   %ax,%ax
  1006a9:	66 90                	xchg   %ax,%ax
  1006ab:	66 90                	xchg   %ax,%ax
  1006ad:	66 90                	xchg   %ax,%ax
  1006af:	90                   	nop

001006b0 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
  1006b0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  1006b4:	83 e4 f0             	and    $0xfffffff0,%esp
  1006b7:	ff 71 fc             	push   -0x4(%ecx)
  1006ba:	55                   	push   %ebp
  1006bb:	89 e5                	mov    %esp,%ebp
  1006bd:	51                   	push   %ecx
  1006be:	83 ec 04             	sub    $0x4,%esp
  mpinit();        // detect other processors
  1006c1:	e8 ba 00 00 00       	call   100780 <mpinit>
  lapicinit();     // interrupt controller
  1006c6:	e8 95 fe ff ff       	call   100560 <lapicinit>
  picinit();       // disable pic
  1006cb:	e8 90 02 00 00       	call   100960 <picinit>
  ioapicinit();    // another interrupt controller
  1006d0:	e8 9b fd ff ff       	call   100470 <ioapicinit>
  uartinit();       // serial port
  1006d5:	e8 d6 02 00 00       	call   1009b0 <uartinit>
  mouseinit();   
  1006da:	e8 b1 04 00 00       	call   100b90 <mouseinit>
  cprintf("Mouse has been initialized");
  1006df:	83 ec 0c             	sub    $0xc,%esp
  1006e2:	68 46 1c 10 00       	push   $0x101c46
  1006e7:	e8 d4 f9 ff ff       	call   1000c0 <cprintf>
  tvinit();        // trap vectors
  1006ec:	e8 3f 09 00 00       	call   101030 <tvinit>
  idtinit();       // load idt register
  1006f1:	e8 7a 09 00 00       	call   101070 <idtinit>


static inline void
sti(void)
{
  asm volatile("sti");
  1006f6:	fb                   	sti    
}
  1006f7:	83 c4 10             	add    $0x10,%esp
  1006fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

static inline void
wfi(void)
{
  asm volatile("hlt");
  100700:	f4                   	hlt    
  100701:	eb fd                	jmp    100700 <main+0x50>
  100703:	66 90                	xchg   %ax,%ax
  100705:	66 90                	xchg   %ax,%ax
  100707:	66 90                	xchg   %ax,%ax
  100709:	66 90                	xchg   %ax,%ax
  10070b:	66 90                	xchg   %ax,%ax
  10070d:	66 90                	xchg   %ax,%ax
  10070f:	90                   	nop

00100710 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
  100710:	55                   	push   %ebp
  100711:	89 e5                	mov    %esp,%ebp
  100713:	57                   	push   %edi
  100714:	56                   	push   %esi
  100715:	53                   	push   %ebx
  uchar *e, *p, *addr;

  // addr = P2V(a);
  addr = (uchar*) a;
  e = addr+len;
  100716:	8d 1c 10             	lea    (%eax,%edx,1),%ebx
{
  100719:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
  10071c:	39 d8                	cmp    %ebx,%eax
  10071e:	73 50                	jae    100770 <mpsearch1+0x60>
  100720:	89 c6                	mov    %eax,%esi
  100722:	eb 0a                	jmp    10072e <mpsearch1+0x1e>
  100724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100728:	89 fe                	mov    %edi,%esi
  10072a:	39 fb                	cmp    %edi,%ebx
  10072c:	76 42                	jbe    100770 <mpsearch1+0x60>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  10072e:	83 ec 04             	sub    $0x4,%esp
  100731:	8d 7e 10             	lea    0x10(%esi),%edi
  100734:	6a 04                	push   $0x4
  100736:	68 61 1c 10 00       	push   $0x101c61
  10073b:	56                   	push   %esi
  10073c:	e8 2f 06 00 00       	call   100d70 <memcmp>
  100741:	83 c4 10             	add    $0x10,%esp
  100744:	85 c0                	test   %eax,%eax
  100746:	75 e0                	jne    100728 <mpsearch1+0x18>
  100748:	89 f2                	mov    %esi,%edx
  10074a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
  100750:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
  100753:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
  100756:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
  100758:	39 fa                	cmp    %edi,%edx
  10075a:	75 f4                	jne    100750 <mpsearch1+0x40>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  10075c:	84 c0                	test   %al,%al
  10075e:	75 c8                	jne    100728 <mpsearch1+0x18>
      return (struct mp*)p;
  return 0;
}
  100760:	8d 65 f4             	lea    -0xc(%ebp),%esp
  100763:	89 f0                	mov    %esi,%eax
  100765:	5b                   	pop    %ebx
  100766:	5e                   	pop    %esi
  100767:	5f                   	pop    %edi
  100768:	5d                   	pop    %ebp
  100769:	c3                   	ret    
  10076a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100770:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
  100773:	31 f6                	xor    %esi,%esi
}
  100775:	5b                   	pop    %ebx
  100776:	89 f0                	mov    %esi,%eax
  100778:	5e                   	pop    %esi
  100779:	5f                   	pop    %edi
  10077a:	5d                   	pop    %ebp
  10077b:	c3                   	ret    
  10077c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00100780 <mpinit>:
  return conf;
}

void
mpinit(void)
{
  100780:	55                   	push   %ebp
  100781:	89 e5                	mov    %esp,%ebp
  100783:	57                   	push   %edi
  100784:	56                   	push   %esi
  100785:	53                   	push   %ebx
  100786:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
  100789:	0f b6 05 0f 04 00 00 	movzbl 0x40f,%eax
  100790:	0f b6 15 0e 04 00 00 	movzbl 0x40e,%edx
  100797:	c1 e0 08             	shl    $0x8,%eax
  10079a:	09 d0                	or     %edx,%eax
  10079c:	c1 e0 04             	shl    $0x4,%eax
  10079f:	75 1b                	jne    1007bc <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
  1007a1:	0f b6 05 14 04 00 00 	movzbl 0x414,%eax
  1007a8:	0f b6 15 13 04 00 00 	movzbl 0x413,%edx
  1007af:	c1 e0 08             	shl    $0x8,%eax
  1007b2:	09 d0                	or     %edx,%eax
  1007b4:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
  1007b7:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
  1007bc:	ba 00 04 00 00       	mov    $0x400,%edx
  1007c1:	e8 4a ff ff ff       	call   100710 <mpsearch1>
  1007c6:	89 c6                	mov    %eax,%esi
  1007c8:	85 c0                	test   %eax,%eax
  1007ca:	0f 84 28 01 00 00    	je     1008f8 <mpinit+0x178>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  1007d0:	8b 5e 04             	mov    0x4(%esi),%ebx
  1007d3:	85 db                	test   %ebx,%ebx
  1007d5:	0f 84 b5 00 00 00    	je     100890 <mpinit+0x110>
  if(memcmp(conf, "PCMP", 4) != 0)
  1007db:	83 ec 04             	sub    $0x4,%esp
  1007de:	6a 04                	push   $0x4
  1007e0:	68 66 1c 10 00       	push   $0x101c66
  1007e5:	53                   	push   %ebx
  1007e6:	e8 85 05 00 00       	call   100d70 <memcmp>
  1007eb:	83 c4 10             	add    $0x10,%esp
  1007ee:	85 c0                	test   %eax,%eax
  1007f0:	0f 85 9a 00 00 00    	jne    100890 <mpinit+0x110>
  if(conf->version != 1 && conf->version != 4)
  1007f6:	0f b6 43 06          	movzbl 0x6(%ebx),%eax
  1007fa:	3c 01                	cmp    $0x1,%al
  1007fc:	74 08                	je     100806 <mpinit+0x86>
  1007fe:	3c 04                	cmp    $0x4,%al
  100800:	0f 85 8a 00 00 00    	jne    100890 <mpinit+0x110>
  if(sum((uchar*)conf, conf->length) != 0)
  100806:	0f b7 53 04          	movzwl 0x4(%ebx),%edx
  for(i=0; i<len; i++)
  10080a:	66 85 d2             	test   %dx,%dx
  10080d:	0f 84 32 01 00 00    	je     100945 <mpinit+0x1c5>
  100813:	0f b7 fa             	movzwl %dx,%edi
  100816:	89 d8                	mov    %ebx,%eax
  sum = 0;
  100818:	31 d2                	xor    %edx,%edx
  10081a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  10081d:	01 df                	add    %ebx,%edi
  10081f:	90                   	nop
    sum += addr[i];
  100820:	0f b6 08             	movzbl (%eax),%ecx
  for(i=0; i<len; i++)
  100823:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
  100826:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
  100828:	39 c7                	cmp    %eax,%edi
  10082a:	75 f4                	jne    100820 <mpinit+0xa0>
  if(sum((uchar*)conf, conf->length) != 0)
  10082c:	84 d2                	test   %dl,%dl
  10082e:	75 60                	jne    100890 <mpinit+0x110>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  100830:	8b 43 24             	mov    0x24(%ebx),%eax
  ismp = 1;
  100833:	b9 01 00 00 00       	mov    $0x1,%ecx
  lapic = (uint*)conf->lapicaddr;
  100838:	a3 90 24 10 00       	mov    %eax,0x102490
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  10083d:	8d 43 2c             	lea    0x2c(%ebx),%eax
  100840:	03 5d e4             	add    -0x1c(%ebp),%ebx
  100843:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100847:	90                   	nop
  100848:	39 d8                	cmp    %ebx,%eax
  10084a:	73 19                	jae    100865 <mpinit+0xe5>
    switch(*p){
  10084c:	0f b6 10             	movzbl (%eax),%edx
  10084f:	80 fa 02             	cmp    $0x2,%dl
  100852:	0f 84 88 00 00 00    	je     1008e0 <mpinit+0x160>
  100858:	77 46                	ja     1008a0 <mpinit+0x120>
  10085a:	84 d2                	test   %dl,%dl
  10085c:	74 52                	je     1008b0 <mpinit+0x130>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
  10085e:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  100861:	39 d8                	cmp    %ebx,%eax
  100863:	72 e7                	jb     10084c <mpinit+0xcc>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
  100865:	85 c9                	test   %ecx,%ecx
  100867:	0f 84 e4 00 00 00    	je     100951 <mpinit+0x1d1>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
  10086d:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
  100871:	74 15                	je     100888 <mpinit+0x108>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100873:	b8 70 00 00 00       	mov    $0x70,%eax
  100878:	ba 22 00 00 00       	mov    $0x22,%edx
  10087d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  10087e:	ba 23 00 00 00       	mov    $0x23,%edx
  100883:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  100884:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100887:	ee                   	out    %al,(%dx)
  }
}
  100888:	8d 65 f4             	lea    -0xc(%ebp),%esp
  10088b:	5b                   	pop    %ebx
  10088c:	5e                   	pop    %esi
  10088d:	5f                   	pop    %edi
  10088e:	5d                   	pop    %ebp
  10088f:	c3                   	ret    
    panic("Expect to run on an SMP");
  100890:	83 ec 0c             	sub    $0xc,%esp
  100893:	68 6b 1c 10 00       	push   $0x101c6b
  100898:	e8 a3 f9 ff ff       	call   100240 <panic>
  10089d:	8d 76 00             	lea    0x0(%esi),%esi
    switch(*p){
  1008a0:	83 ea 03             	sub    $0x3,%edx
  1008a3:	80 fa 01             	cmp    $0x1,%dl
  1008a6:	76 b6                	jbe    10085e <mpinit+0xde>
  1008a8:	31 c9                	xor    %ecx,%ecx
  1008aa:	eb 9c                	jmp    100848 <mpinit+0xc8>
  1008ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
  1008b0:	8b 3d 98 24 10 00    	mov    0x102498,%edi
  1008b6:	83 ff 07             	cmp    $0x7,%edi
  1008b9:	7f 13                	jg     1008ce <mpinit+0x14e>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
  1008bb:	0f b6 50 01          	movzbl 0x1(%eax),%edx
        ncpu++;
  1008bf:	83 c7 01             	add    $0x1,%edi
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
  1008c2:	88 97 9b 24 10 00    	mov    %dl,0x10249b(%edi)
        ncpu++;
  1008c8:	89 3d 98 24 10 00    	mov    %edi,0x102498
      p += sizeof(struct mpproc);
  1008ce:	83 c0 14             	add    $0x14,%eax
      continue;
  1008d1:	e9 72 ff ff ff       	jmp    100848 <mpinit+0xc8>
  1008d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1008dd:	8d 76 00             	lea    0x0(%esi),%esi
      ioapicid = ioapic->apicno;
  1008e0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
  1008e4:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
  1008e7:	88 15 94 24 10 00    	mov    %dl,0x102494
      continue;
  1008ed:	e9 56 ff ff ff       	jmp    100848 <mpinit+0xc8>
  1008f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  1008f8:	be 00 00 0f 00       	mov    $0xf0000,%esi
  1008fd:	eb 0b                	jmp    10090a <mpinit+0x18a>
  1008ff:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
  100900:	89 de                	mov    %ebx,%esi
  100902:	81 fb 00 00 10 00    	cmp    $0x100000,%ebx
  100908:	74 86                	je     100890 <mpinit+0x110>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  10090a:	83 ec 04             	sub    $0x4,%esp
  10090d:	8d 5e 10             	lea    0x10(%esi),%ebx
  100910:	6a 04                	push   $0x4
  100912:	68 61 1c 10 00       	push   $0x101c61
  100917:	56                   	push   %esi
  100918:	e8 53 04 00 00       	call   100d70 <memcmp>
  10091d:	83 c4 10             	add    $0x10,%esp
  100920:	85 c0                	test   %eax,%eax
  100922:	75 dc                	jne    100900 <mpinit+0x180>
  100924:	89 f2                	mov    %esi,%edx
  100926:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10092d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
  100930:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
  100933:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
  100936:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
  100938:	39 da                	cmp    %ebx,%edx
  10093a:	75 f4                	jne    100930 <mpinit+0x1b0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  10093c:	84 c0                	test   %al,%al
  10093e:	75 c0                	jne    100900 <mpinit+0x180>
  100940:	e9 8b fe ff ff       	jmp    1007d0 <mpinit+0x50>
  100945:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  10094c:	e9 df fe ff ff       	jmp    100830 <mpinit+0xb0>
    panic("Didn't find a suitable machine");
  100951:	83 ec 0c             	sub    $0xc,%esp
  100954:	68 84 1c 10 00       	push   $0x101c84
  100959:	e8 e2 f8 ff ff       	call   100240 <panic>
  10095e:	66 90                	xchg   %ax,%ax

00100960 <picinit>:
  100960:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100965:	ba 21 00 00 00       	mov    $0x21,%edx
  10096a:	ee                   	out    %al,(%dx)
  10096b:	ba a1 00 00 00       	mov    $0xa1,%edx
  100970:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
  100971:	c3                   	ret    
  100972:	66 90                	xchg   %ax,%ax
  100974:	66 90                	xchg   %ax,%ax
  100976:	66 90                	xchg   %ax,%ax
  100978:	66 90                	xchg   %ax,%ax
  10097a:	66 90                	xchg   %ax,%ax
  10097c:	66 90                	xchg   %ax,%ax
  10097e:	66 90                	xchg   %ax,%ax

00100980 <uartgetc>:


static int
uartgetc(void)
{
  if(!uart)
  100980:	a1 a4 24 10 00       	mov    0x1024a4,%eax
  100985:	85 c0                	test   %eax,%eax
  100987:	74 17                	je     1009a0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100989:	ba fd 03 00 00       	mov    $0x3fd,%edx
  10098e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
  10098f:	a8 01                	test   $0x1,%al
  100991:	74 0d                	je     1009a0 <uartgetc+0x20>
  100993:	ba f8 03 00 00       	mov    $0x3f8,%edx
  100998:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
  100999:	0f b6 c0             	movzbl %al,%eax
  10099c:	c3                   	ret    
  10099d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
  1009a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1009a5:	c3                   	ret    
  1009a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1009ad:	8d 76 00             	lea    0x0(%esi),%esi

001009b0 <uartinit>:
{
  1009b0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1009b1:	31 c9                	xor    %ecx,%ecx
  1009b3:	89 c8                	mov    %ecx,%eax
  1009b5:	89 e5                	mov    %esp,%ebp
  1009b7:	57                   	push   %edi
  1009b8:	bf fa 03 00 00       	mov    $0x3fa,%edi
  1009bd:	56                   	push   %esi
  1009be:	89 fa                	mov    %edi,%edx
  1009c0:	53                   	push   %ebx
  1009c1:	83 ec 1c             	sub    $0x1c,%esp
  1009c4:	ee                   	out    %al,(%dx)
  1009c5:	be fb 03 00 00       	mov    $0x3fb,%esi
  1009ca:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
  1009cf:	89 f2                	mov    %esi,%edx
  1009d1:	ee                   	out    %al,(%dx)
  1009d2:	b8 0c 00 00 00       	mov    $0xc,%eax
  1009d7:	ba f8 03 00 00       	mov    $0x3f8,%edx
  1009dc:	ee                   	out    %al,(%dx)
  1009dd:	bb f9 03 00 00       	mov    $0x3f9,%ebx
  1009e2:	89 c8                	mov    %ecx,%eax
  1009e4:	89 da                	mov    %ebx,%edx
  1009e6:	ee                   	out    %al,(%dx)
  1009e7:	b8 03 00 00 00       	mov    $0x3,%eax
  1009ec:	89 f2                	mov    %esi,%edx
  1009ee:	ee                   	out    %al,(%dx)
  1009ef:	ba fc 03 00 00       	mov    $0x3fc,%edx
  1009f4:	89 c8                	mov    %ecx,%eax
  1009f6:	ee                   	out    %al,(%dx)
  1009f7:	b8 01 00 00 00       	mov    $0x1,%eax
  1009fc:	89 da                	mov    %ebx,%edx
  1009fe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1009ff:	ba fd 03 00 00       	mov    $0x3fd,%edx
  100a04:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
  100a05:	3c ff                	cmp    $0xff,%al
  100a07:	0f 84 83 00 00 00    	je     100a90 <uartinit+0xe0>
  uart = 1;
  100a0d:	c7 05 a4 24 10 00 01 	movl   $0x1,0x1024a4
  100a14:	00 00 00 
  100a17:	89 fa                	mov    %edi,%edx
  100a19:	ec                   	in     (%dx),%al
  100a1a:	ba f8 03 00 00       	mov    $0x3f8,%edx
  100a1f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
  100a20:	83 ec 08             	sub    $0x8,%esp
  if(!uart)
  100a23:	bf 76 00 00 00       	mov    $0x76,%edi
  for(p="xv6...\n"; *p; p++)
  100a28:	be a3 1c 10 00       	mov    $0x101ca3,%esi
  100a2d:	bb fd 03 00 00       	mov    $0x3fd,%ebx
  ioapicenable(IRQ_COM1, 0);
  100a32:	6a 00                	push   $0x0
  100a34:	6a 04                	push   $0x4
  100a36:	e8 e5 fa ff ff       	call   100520 <ioapicenable>
  if(!uart)
  100a3b:	a1 a4 24 10 00       	mov    0x1024a4,%eax
  for(p="xv6...\n"; *p; p++)
  100a40:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  if(!uart)
  100a44:	83 c4 10             	add    $0x10,%esp
  100a47:	89 45 e0             	mov    %eax,-0x20(%ebp)
  100a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100a50:	8b 45 e0             	mov    -0x20(%ebp),%eax
  100a53:	b9 80 00 00 00       	mov    $0x80,%ecx
  100a58:	85 c0                	test   %eax,%eax
  100a5a:	75 09                	jne    100a65 <uartinit+0xb5>
  100a5c:	eb 18                	jmp    100a76 <uartinit+0xc6>
  100a5e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++);
  100a60:	83 e9 01             	sub    $0x1,%ecx
  100a63:	74 07                	je     100a6c <uartinit+0xbc>
  100a65:	89 da                	mov    %ebx,%edx
  100a67:	ec                   	in     (%dx),%al
  100a68:	a8 20                	test   $0x20,%al
  100a6a:	74 f4                	je     100a60 <uartinit+0xb0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100a6c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  100a70:	ba f8 03 00 00       	mov    $0x3f8,%edx
  100a75:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
  100a76:	89 f8                	mov    %edi,%eax
  100a78:	83 c6 01             	add    $0x1,%esi
  100a7b:	84 c0                	test   %al,%al
  100a7d:	74 11                	je     100a90 <uartinit+0xe0>
  100a7f:	88 45 e7             	mov    %al,-0x19(%ebp)
  100a82:	0f b6 7e 01          	movzbl 0x1(%esi),%edi
  100a86:	eb c8                	jmp    100a50 <uartinit+0xa0>
  100a88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100a8f:	90                   	nop
}
  100a90:	8d 65 f4             	lea    -0xc(%ebp),%esp
  100a93:	5b                   	pop    %ebx
  100a94:	5e                   	pop    %esi
  100a95:	5f                   	pop    %edi
  100a96:	5d                   	pop    %ebp
  100a97:	c3                   	ret    
  100a98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100a9f:	90                   	nop

00100aa0 <uartputc>:
  if(!uart)
  100aa0:	a1 a4 24 10 00       	mov    0x1024a4,%eax
  100aa5:	85 c0                	test   %eax,%eax
  100aa7:	74 2f                	je     100ad8 <uartputc+0x38>
{
  100aa9:	55                   	push   %ebp
  100aaa:	b9 80 00 00 00       	mov    $0x80,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100aaf:	ba fd 03 00 00       	mov    $0x3fd,%edx
  100ab4:	89 e5                	mov    %esp,%ebp
  100ab6:	eb 0d                	jmp    100ac5 <uartputc+0x25>
  100ab8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100abf:	90                   	nop
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++);
  100ac0:	83 e9 01             	sub    $0x1,%ecx
  100ac3:	74 05                	je     100aca <uartputc+0x2a>
  100ac5:	ec                   	in     (%dx),%al
  100ac6:	a8 20                	test   $0x20,%al
  100ac8:	74 f6                	je     100ac0 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100aca:	8b 45 08             	mov    0x8(%ebp),%eax
  100acd:	ba f8 03 00 00       	mov    $0x3f8,%edx
  100ad2:	ee                   	out    %al,(%dx)
}
  100ad3:	5d                   	pop    %ebp
  100ad4:	c3                   	ret    
  100ad5:	8d 76 00             	lea    0x0(%esi),%esi
  100ad8:	c3                   	ret    
  100ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100ae0 <uartintr>:

void
uartintr(void)
{
  100ae0:	55                   	push   %ebp
  100ae1:	89 e5                	mov    %esp,%ebp
  100ae3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
  100ae6:	68 80 09 10 00       	push   $0x100980
  100aeb:	e8 c0 f7 ff ff       	call   1002b0 <consoleintr>
  100af0:	83 c4 10             	add    $0x10,%esp
  100af3:	c9                   	leave  
  100af4:	c3                   	ret    
  100af5:	66 90                	xchg   %ax,%ax
  100af7:	66 90                	xchg   %ax,%ax
  100af9:	66 90                	xchg   %ax,%ax
  100afb:	66 90                	xchg   %ax,%ax
  100afd:	66 90                	xchg   %ax,%ax
  100aff:	90                   	nop

00100b00 <mousewait_send>:
#include "traps.h"

// Wait until the mouse controller is ready for us to send a packet
void 
mousewait_send(void) 
{
  100b00:	b9 9f 86 01 00       	mov    $0x1869f,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100b05:	ba 64 00 00 00       	mov    $0x64,%edx
  100b0a:	eb 09                	jmp    100b15 <mousewait_send+0x15>
  100b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    // Implement your code here
    uint time=100000;
    while(--time){
  100b10:	83 e9 01             	sub    $0x1,%ecx
  100b13:	74 05                	je     100b1a <mousewait_send+0x1a>
  100b15:	ec                   	in     (%dx),%al
        if((inb(0x64) & 2)==0)
  100b16:	a8 02                	test   $0x2,%al
  100b18:	75 f6                	jne    100b10 <mousewait_send+0x10>
            return;
    }
}
  100b1a:	c3                   	ret    
  100b1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100b1f:	90                   	nop

00100b20 <mousewait_recv>:

// Wait until the mouse controller has data for us to receive
void 
mousewait_recv(void) 
{
  100b20:	b9 9f 86 01 00       	mov    $0x1869f,%ecx
  100b25:	ba 64 00 00 00       	mov    $0x64,%edx
  100b2a:	eb 09                	jmp    100b35 <mousewait_recv+0x15>
  100b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    // Implement your code here
    uint time=100000;
    while(--time){
  100b30:	83 e9 01             	sub    $0x1,%ecx
  100b33:	74 05                	je     100b3a <mousewait_recv+0x1a>
  100b35:	ec                   	in     (%dx),%al
        if((inb(0x64) & 1)==1)
  100b36:	a8 01                	test   $0x1,%al
  100b38:	74 f6                	je     100b30 <mousewait_recv+0x10>
            return;
    }
}
  100b3a:	c3                   	ret    
  100b3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100b3f:	90                   	nop

00100b40 <mousecmd>:

// Send a one-byte command to the mouse controller, and wait for it
// to be properly acknowledged
void 
mousecmd(uchar cmd) 
{
  100b40:	55                   	push   %ebp
  100b41:	b9 9f 86 01 00       	mov    $0x1869f,%ecx
  100b46:	ba 64 00 00 00       	mov    $0x64,%edx
  100b4b:	89 e5                	mov    %esp,%ebp
  100b4d:	53                   	push   %ebx
  100b4e:	0f b6 5d 08          	movzbl 0x8(%ebp),%ebx
  100b52:	eb 09                	jmp    100b5d <mousecmd+0x1d>
  100b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(--time){
  100b58:	83 e9 01             	sub    $0x1,%ecx
  100b5b:	74 05                	je     100b62 <mousecmd+0x22>
  100b5d:	ec                   	in     (%dx),%al
        if((inb(0x64) & 2)==0)
  100b5e:	a8 02                	test   $0x2,%al
  100b60:	75 f6                	jne    100b58 <mousecmd+0x18>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100b62:	b8 d4 ff ff ff       	mov    $0xffffffd4,%eax
  100b67:	ba 64 00 00 00       	mov    $0x64,%edx
  100b6c:	ee                   	out    %al,(%dx)
  100b6d:	b9 9f 86 01 00       	mov    $0x1869f,%ecx
  100b72:	eb 09                	jmp    100b7d <mousecmd+0x3d>
  100b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(--time){
  100b78:	83 e9 01             	sub    $0x1,%ecx
  100b7b:	74 05                	je     100b82 <mousecmd+0x42>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100b7d:	ec                   	in     (%dx),%al
        if((inb(0x64) & 2)==0)
  100b7e:	a8 02                	test   $0x2,%al
  100b80:	75 f6                	jne    100b78 <mousecmd+0x38>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100b82:	ba 60 00 00 00       	mov    $0x60,%edx
  100b87:	89 d8                	mov    %ebx,%eax
  100b89:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100b8a:	ec                   	in     (%dx),%al
        ;
    }


    return;
}
  100b8b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100b8e:	c9                   	leave  
  100b8f:	c3                   	ret    

00100b90 <mouseinit>:

void
mouseinit(void)
{
  100b90:	55                   	push   %ebp
  100b91:	b9 9f 86 01 00       	mov    $0x1869f,%ecx
  100b96:	ba 64 00 00 00       	mov    $0x64,%edx
  100b9b:	89 e5                	mov    %esp,%ebp
  100b9d:	53                   	push   %ebx
  100b9e:	83 ec 04             	sub    $0x4,%esp
  100ba1:	eb 0a                	jmp    100bad <mouseinit+0x1d>
  100ba3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100ba7:	90                   	nop
    while(--time){
  100ba8:	83 e9 01             	sub    $0x1,%ecx
  100bab:	74 05                	je     100bb2 <mouseinit+0x22>
  100bad:	ec                   	in     (%dx),%al
        if((inb(0x64) & 2)==0)
  100bae:	a8 02                	test   $0x2,%al
  100bb0:	75 f6                	jne    100ba8 <mouseinit+0x18>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100bb2:	b8 a8 ff ff ff       	mov    $0xffffffa8,%eax
  100bb7:	ba 64 00 00 00       	mov    $0x64,%edx
  100bbc:	ee                   	out    %al,(%dx)
  100bbd:	b9 9f 86 01 00       	mov    $0x1869f,%ecx
  100bc2:	eb 09                	jmp    100bcd <mouseinit+0x3d>
  100bc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(--time){
  100bc8:	83 e9 01             	sub    $0x1,%ecx
  100bcb:	74 05                	je     100bd2 <mouseinit+0x42>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100bcd:	ec                   	in     (%dx),%al
        if((inb(0x64) & 2)==0)
  100bce:	a8 02                	test   $0x2,%al
  100bd0:	75 f6                	jne    100bc8 <mouseinit+0x38>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100bd2:	b8 20 00 00 00       	mov    $0x20,%eax
  100bd7:	ba 64 00 00 00       	mov    $0x64,%edx
  100bdc:	ee                   	out    %al,(%dx)
  100bdd:	b9 9f 86 01 00       	mov    $0x1869f,%ecx
  100be2:	eb 09                	jmp    100bed <mouseinit+0x5d>
  100be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(--time){
  100be8:	83 e9 01             	sub    $0x1,%ecx
  100beb:	74 05                	je     100bf2 <mouseinit+0x62>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100bed:	ec                   	in     (%dx),%al
        if((inb(0x64) & 1)==1)
  100bee:	a8 01                	test   $0x1,%al
  100bf0:	74 f6                	je     100be8 <mouseinit+0x58>
  100bf2:	ba 60 00 00 00       	mov    $0x60,%edx
  100bf7:	ec                   	in     (%dx),%al
    mousewait_send();
    outb(0x64, 0xA8); //Enable the mouse boy
    mousewait_send(); 
    outb(0x64,0x20); //Hey I want the status byte man!
    mousewait_recv();
    uint status= (inb(0x60) | 2);
  100bf8:	83 c8 02             	or     $0x2,%eax
  100bfb:	b9 9f 86 01 00       	mov    $0x1869f,%ecx
  100c00:	ba 64 00 00 00       	mov    $0x64,%edx
  100c05:	89 c3                	mov    %eax,%ebx
    while(--time){
  100c07:	eb 0c                	jmp    100c15 <mouseinit+0x85>
  100c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100c10:	83 e9 01             	sub    $0x1,%ecx
  100c13:	74 05                	je     100c1a <mouseinit+0x8a>
  100c15:	ec                   	in     (%dx),%al
        if((inb(0x64) & 2)==0)
  100c16:	a8 02                	test   $0x2,%al
  100c18:	75 f6                	jne    100c10 <mouseinit+0x80>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100c1a:	b8 60 00 00 00       	mov    $0x60,%eax
  100c1f:	ba 64 00 00 00       	mov    $0x64,%edx
  100c24:	ee                   	out    %al,(%dx)
  100c25:	b9 9f 86 01 00       	mov    $0x1869f,%ecx
  100c2a:	eb 09                	jmp    100c35 <mouseinit+0xa5>
  100c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(--time){
  100c30:	83 e9 01             	sub    $0x1,%ecx
  100c33:	74 05                	je     100c3a <mouseinit+0xaa>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100c35:	ec                   	in     (%dx),%al
        if((inb(0x64) & 2)==0)
  100c36:	a8 02                	test   $0x2,%al
  100c38:	75 f6                	jne    100c30 <mouseinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100c3a:	ba 60 00 00 00       	mov    $0x60,%edx
  100c3f:	89 d8                	mov    %ebx,%eax
  100c41:	ee                   	out    %al,(%dx)
    mousewait_send();
    outb(0x60,status);


    // 4
    mousecmd(0xF6);
  100c42:	83 ec 0c             	sub    $0xc,%esp
  100c45:	68 f6 00 00 00       	push   $0xf6
  100c4a:	e8 f1 fe ff ff       	call   100b40 <mousecmd>
    // 5
    mousecmd(0xF4);
  100c4f:	c7 04 24 f4 00 00 00 	movl   $0xf4,(%esp)
  100c56:	e8 e5 fe ff ff       	call   100b40 <mousecmd>

    // 6
    ioapicenable(IRQ_MOUSE, 0);
  100c5b:	58                   	pop    %eax
  100c5c:	5a                   	pop    %edx
  100c5d:	6a 00                	push   $0x0
  100c5f:	6a 0c                	push   $0xc
  100c61:	e8 ba f8 ff ff       	call   100520 <ioapicenable>


    return;
}
  100c66:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return;
  100c69:	83 c4 10             	add    $0x10,%esp
}
  100c6c:	c9                   	leave  
  100c6d:	c3                   	ret    
  100c6e:	66 90                	xchg   %ax,%ax

00100c70 <mouseintr>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100c70:	ba 64 00 00 00       	mov    $0x64,%edx
  100c75:	ec                   	in     (%dx),%al
void
mouseintr(void)
{
    // Implement your code here
    int c=0;
    while((inb(0x64) & 1)==1){
  100c76:	a8 01                	test   $0x1,%al
  100c78:	0f 84 9a 00 00 00    	je     100d18 <mouseintr+0xa8>
{
  100c7e:	55                   	push   %ebp
  100c7f:	89 e5                	mov    %esp,%ebp
  100c81:	57                   	push   %edi
  100c82:	bf 60 00 00 00       	mov    $0x60,%edi
  100c87:	56                   	push   %esi
  100c88:	be 64 00 00 00       	mov    $0x64,%esi
  100c8d:	53                   	push   %ebx
    int c=0;
  100c8e:	31 db                	xor    %ebx,%ebx
{
  100c90:	83 ec 0c             	sub    $0xc,%esp
  100c93:	eb 15                	jmp    100caa <mouseintr+0x3a>
  100c95:	8d 76 00             	lea    0x0(%esi),%esi

        if(c%3==0){
            if((data1 & 1) == 1){
            cprintf("LEFT\n");
            }
            else if (((data1 & 2)>>1)==1){
  100c98:	a8 02                	test   $0x2,%al
  100c9a:	75 3c                	jne    100cd8 <mouseintr+0x68>
                cprintf("RIGHT\n");
            }
            else if (((data1 & 4)>>2) ==1){
  100c9c:	a8 04                	test   $0x4,%al
  100c9e:	75 60                	jne    100d00 <mouseintr+0x90>
                cprintf("MID\n");
            }
        }
        c++;
  100ca0:	83 c3 01             	add    $0x1,%ebx
  100ca3:	89 f2                	mov    %esi,%edx
  100ca5:	ec                   	in     (%dx),%al
    while((inb(0x64) & 1)==1){
  100ca6:	a8 01                	test   $0x1,%al
  100ca8:	74 46                	je     100cf0 <mouseintr+0x80>
  100caa:	89 fa                	mov    %edi,%edx
  100cac:	ec                   	in     (%dx),%al
  100cad:	69 d3 ab aa aa aa    	imul   $0xaaaaaaab,%ebx,%edx
        if(c%3==0){
  100cb3:	81 fa 55 55 55 55    	cmp    $0x55555555,%edx
  100cb9:	77 e5                	ja     100ca0 <mouseintr+0x30>
            if((data1 & 1) == 1){
  100cbb:	a8 01                	test   $0x1,%al
  100cbd:	74 d9                	je     100c98 <mouseintr+0x28>
            cprintf("LEFT\n");
  100cbf:	83 ec 0c             	sub    $0xc,%esp
  100cc2:	68 ab 1c 10 00       	push   $0x101cab
  100cc7:	e8 f4 f3 ff ff       	call   1000c0 <cprintf>
  100ccc:	83 c4 10             	add    $0x10,%esp
  100ccf:	eb cf                	jmp    100ca0 <mouseintr+0x30>
  100cd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                cprintf("RIGHT\n");
  100cd8:	83 ec 0c             	sub    $0xc,%esp
  100cdb:	68 b1 1c 10 00       	push   $0x101cb1
  100ce0:	e8 db f3 ff ff       	call   1000c0 <cprintf>
  100ce5:	83 c4 10             	add    $0x10,%esp
  100ce8:	eb b6                	jmp    100ca0 <mouseintr+0x30>
  100cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    }



    return;
  100cf0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  100cf3:	5b                   	pop    %ebx
  100cf4:	5e                   	pop    %esi
  100cf5:	5f                   	pop    %edi
  100cf6:	5d                   	pop    %ebp
  100cf7:	c3                   	ret    
  100cf8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100cff:	90                   	nop
                cprintf("MID\n");
  100d00:	83 ec 0c             	sub    $0xc,%esp
  100d03:	68 b8 1c 10 00       	push   $0x101cb8
  100d08:	e8 b3 f3 ff ff       	call   1000c0 <cprintf>
  100d0d:	83 c4 10             	add    $0x10,%esp
  100d10:	eb 8e                	jmp    100ca0 <mouseintr+0x30>
  100d12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100d18:	c3                   	ret    
  100d19:	66 90                	xchg   %ax,%ax
  100d1b:	66 90                	xchg   %ax,%ax
  100d1d:	66 90                	xchg   %ax,%ax
  100d1f:	90                   	nop

00100d20 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
  100d20:	55                   	push   %ebp
  100d21:	89 e5                	mov    %esp,%ebp
  100d23:	57                   	push   %edi
  100d24:	8b 55 08             	mov    0x8(%ebp),%edx
  100d27:	8b 4d 10             	mov    0x10(%ebp),%ecx
  100d2a:	53                   	push   %ebx
  100d2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
  100d2e:	89 d7                	mov    %edx,%edi
  100d30:	09 cf                	or     %ecx,%edi
  100d32:	83 e7 03             	and    $0x3,%edi
  100d35:	75 29                	jne    100d60 <memset+0x40>
    c &= 0xFF;
  100d37:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  100d3a:	c1 e0 18             	shl    $0x18,%eax
  100d3d:	89 fb                	mov    %edi,%ebx
  100d3f:	c1 e9 02             	shr    $0x2,%ecx
  100d42:	c1 e3 10             	shl    $0x10,%ebx
  100d45:	09 d8                	or     %ebx,%eax
  100d47:	09 f8                	or     %edi,%eax
  100d49:	c1 e7 08             	shl    $0x8,%edi
  100d4c:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
  100d4e:	89 d7                	mov    %edx,%edi
  100d50:	fc                   	cld    
  100d51:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
  100d53:	5b                   	pop    %ebx
  100d54:	89 d0                	mov    %edx,%eax
  100d56:	5f                   	pop    %edi
  100d57:	5d                   	pop    %ebp
  100d58:	c3                   	ret    
  100d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
  100d60:	89 d7                	mov    %edx,%edi
  100d62:	fc                   	cld    
  100d63:	f3 aa                	rep stos %al,%es:(%edi)
  100d65:	5b                   	pop    %ebx
  100d66:	89 d0                	mov    %edx,%eax
  100d68:	5f                   	pop    %edi
  100d69:	5d                   	pop    %ebp
  100d6a:	c3                   	ret    
  100d6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100d6f:	90                   	nop

00100d70 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
  100d70:	55                   	push   %ebp
  100d71:	89 e5                	mov    %esp,%ebp
  100d73:	56                   	push   %esi
  100d74:	8b 75 10             	mov    0x10(%ebp),%esi
  100d77:	8b 55 08             	mov    0x8(%ebp),%edx
  100d7a:	53                   	push   %ebx
  100d7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  100d7e:	85 f6                	test   %esi,%esi
  100d80:	74 2e                	je     100db0 <memcmp+0x40>
  100d82:	01 c6                	add    %eax,%esi
  100d84:	eb 14                	jmp    100d9a <memcmp+0x2a>
  100d86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100d8d:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  100d90:	83 c0 01             	add    $0x1,%eax
  100d93:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
  100d96:	39 f0                	cmp    %esi,%eax
  100d98:	74 16                	je     100db0 <memcmp+0x40>
    if(*s1 != *s2)
  100d9a:	0f b6 0a             	movzbl (%edx),%ecx
  100d9d:	0f b6 18             	movzbl (%eax),%ebx
  100da0:	38 d9                	cmp    %bl,%cl
  100da2:	74 ec                	je     100d90 <memcmp+0x20>
      return *s1 - *s2;
  100da4:	0f b6 c1             	movzbl %cl,%eax
  100da7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
  100da9:	5b                   	pop    %ebx
  100daa:	5e                   	pop    %esi
  100dab:	5d                   	pop    %ebp
  100dac:	c3                   	ret    
  100dad:	8d 76 00             	lea    0x0(%esi),%esi
  100db0:	5b                   	pop    %ebx
  return 0;
  100db1:	31 c0                	xor    %eax,%eax
}
  100db3:	5e                   	pop    %esi
  100db4:	5d                   	pop    %ebp
  100db5:	c3                   	ret    
  100db6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100dbd:	8d 76 00             	lea    0x0(%esi),%esi

00100dc0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
  100dc0:	55                   	push   %ebp
  100dc1:	89 e5                	mov    %esp,%ebp
  100dc3:	57                   	push   %edi
  100dc4:	8b 55 08             	mov    0x8(%ebp),%edx
  100dc7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  100dca:	56                   	push   %esi
  100dcb:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
  100dce:	39 d6                	cmp    %edx,%esi
  100dd0:	73 26                	jae    100df8 <memmove+0x38>
  100dd2:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
  100dd5:	39 fa                	cmp    %edi,%edx
  100dd7:	73 1f                	jae    100df8 <memmove+0x38>
  100dd9:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
  100ddc:	85 c9                	test   %ecx,%ecx
  100dde:	74 0c                	je     100dec <memmove+0x2c>
      *--d = *--s;
  100de0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
  100de4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
  100de7:	83 e8 01             	sub    $0x1,%eax
  100dea:	73 f4                	jae    100de0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
  100dec:	5e                   	pop    %esi
  100ded:	89 d0                	mov    %edx,%eax
  100def:	5f                   	pop    %edi
  100df0:	5d                   	pop    %ebp
  100df1:	c3                   	ret    
  100df2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
  100df8:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
  100dfb:	89 d7                	mov    %edx,%edi
  100dfd:	85 c9                	test   %ecx,%ecx
  100dff:	74 eb                	je     100dec <memmove+0x2c>
  100e01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
  100e08:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
  100e09:	39 c6                	cmp    %eax,%esi
  100e0b:	75 fb                	jne    100e08 <memmove+0x48>
}
  100e0d:	5e                   	pop    %esi
  100e0e:	89 d0                	mov    %edx,%eax
  100e10:	5f                   	pop    %edi
  100e11:	5d                   	pop    %ebp
  100e12:	c3                   	ret    
  100e13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100e1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100e20 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
  100e20:	eb 9e                	jmp    100dc0 <memmove>
  100e22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100e30 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
  100e30:	55                   	push   %ebp
  100e31:	89 e5                	mov    %esp,%ebp
  100e33:	56                   	push   %esi
  100e34:	8b 75 10             	mov    0x10(%ebp),%esi
  100e37:	8b 4d 08             	mov    0x8(%ebp),%ecx
  100e3a:	53                   	push   %ebx
  100e3b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(n > 0 && *p && *p == *q)
  100e3e:	85 f6                	test   %esi,%esi
  100e40:	74 2e                	je     100e70 <strncmp+0x40>
  100e42:	01 d6                	add    %edx,%esi
  100e44:	eb 18                	jmp    100e5e <strncmp+0x2e>
  100e46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100e4d:	8d 76 00             	lea    0x0(%esi),%esi
  100e50:	38 d8                	cmp    %bl,%al
  100e52:	75 14                	jne    100e68 <strncmp+0x38>
    n--, p++, q++;
  100e54:	83 c2 01             	add    $0x1,%edx
  100e57:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
  100e5a:	39 f2                	cmp    %esi,%edx
  100e5c:	74 12                	je     100e70 <strncmp+0x40>
  100e5e:	0f b6 01             	movzbl (%ecx),%eax
  100e61:	0f b6 1a             	movzbl (%edx),%ebx
  100e64:	84 c0                	test   %al,%al
  100e66:	75 e8                	jne    100e50 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
  100e68:	29 d8                	sub    %ebx,%eax
}
  100e6a:	5b                   	pop    %ebx
  100e6b:	5e                   	pop    %esi
  100e6c:	5d                   	pop    %ebp
  100e6d:	c3                   	ret    
  100e6e:	66 90                	xchg   %ax,%ax
  100e70:	5b                   	pop    %ebx
    return 0;
  100e71:	31 c0                	xor    %eax,%eax
}
  100e73:	5e                   	pop    %esi
  100e74:	5d                   	pop    %ebp
  100e75:	c3                   	ret    
  100e76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100e7d:	8d 76 00             	lea    0x0(%esi),%esi

00100e80 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
  100e80:	55                   	push   %ebp
  100e81:	89 e5                	mov    %esp,%ebp
  100e83:	57                   	push   %edi
  100e84:	56                   	push   %esi
  100e85:	8b 75 08             	mov    0x8(%ebp),%esi
  100e88:	53                   	push   %ebx
  100e89:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  100e8c:	89 f0                	mov    %esi,%eax
  100e8e:	eb 15                	jmp    100ea5 <strncpy+0x25>
  100e90:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  100e94:	8b 7d 0c             	mov    0xc(%ebp),%edi
  100e97:	83 c0 01             	add    $0x1,%eax
  100e9a:	0f b6 57 ff          	movzbl -0x1(%edi),%edx
  100e9e:	88 50 ff             	mov    %dl,-0x1(%eax)
  100ea1:	84 d2                	test   %dl,%dl
  100ea3:	74 09                	je     100eae <strncpy+0x2e>
  100ea5:	89 cb                	mov    %ecx,%ebx
  100ea7:	83 e9 01             	sub    $0x1,%ecx
  100eaa:	85 db                	test   %ebx,%ebx
  100eac:	7f e2                	jg     100e90 <strncpy+0x10>
    ;
  while(n-- > 0)
  100eae:	89 c2                	mov    %eax,%edx
  100eb0:	85 c9                	test   %ecx,%ecx
  100eb2:	7e 17                	jle    100ecb <strncpy+0x4b>
  100eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
  100eb8:	83 c2 01             	add    $0x1,%edx
  100ebb:	89 c1                	mov    %eax,%ecx
  100ebd:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
  while(n-- > 0)
  100ec1:	29 d1                	sub    %edx,%ecx
  100ec3:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
  100ec7:	85 c9                	test   %ecx,%ecx
  100ec9:	7f ed                	jg     100eb8 <strncpy+0x38>
  return os;
}
  100ecb:	5b                   	pop    %ebx
  100ecc:	89 f0                	mov    %esi,%eax
  100ece:	5e                   	pop    %esi
  100ecf:	5f                   	pop    %edi
  100ed0:	5d                   	pop    %ebp
  100ed1:	c3                   	ret    
  100ed2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100ee0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
  100ee0:	55                   	push   %ebp
  100ee1:	89 e5                	mov    %esp,%ebp
  100ee3:	56                   	push   %esi
  100ee4:	8b 55 10             	mov    0x10(%ebp),%edx
  100ee7:	8b 75 08             	mov    0x8(%ebp),%esi
  100eea:	53                   	push   %ebx
  100eeb:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
  100eee:	85 d2                	test   %edx,%edx
  100ef0:	7e 25                	jle    100f17 <safestrcpy+0x37>
  100ef2:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
  100ef6:	89 f2                	mov    %esi,%edx
  100ef8:	eb 16                	jmp    100f10 <safestrcpy+0x30>
  100efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
  100f00:	0f b6 08             	movzbl (%eax),%ecx
  100f03:	83 c0 01             	add    $0x1,%eax
  100f06:	83 c2 01             	add    $0x1,%edx
  100f09:	88 4a ff             	mov    %cl,-0x1(%edx)
  100f0c:	84 c9                	test   %cl,%cl
  100f0e:	74 04                	je     100f14 <safestrcpy+0x34>
  100f10:	39 d8                	cmp    %ebx,%eax
  100f12:	75 ec                	jne    100f00 <safestrcpy+0x20>
    ;
  *s = 0;
  100f14:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
  100f17:	89 f0                	mov    %esi,%eax
  100f19:	5b                   	pop    %ebx
  100f1a:	5e                   	pop    %esi
  100f1b:	5d                   	pop    %ebp
  100f1c:	c3                   	ret    
  100f1d:	8d 76 00             	lea    0x0(%esi),%esi

00100f20 <strlen>:

int
strlen(const char *s)
{
  100f20:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
  100f21:	31 c0                	xor    %eax,%eax
{
  100f23:	89 e5                	mov    %esp,%ebp
  100f25:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
  100f28:	80 3a 00             	cmpb   $0x0,(%edx)
  100f2b:	74 0c                	je     100f39 <strlen+0x19>
  100f2d:	8d 76 00             	lea    0x0(%esi),%esi
  100f30:	83 c0 01             	add    $0x1,%eax
  100f33:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100f37:	75 f7                	jne    100f30 <strlen+0x10>
    ;
  return n;
}
  100f39:	5d                   	pop    %ebp
  100f3a:	c3                   	ret    
  100f3b:	66 90                	xchg   %ax,%ax
  100f3d:	66 90                	xchg   %ax,%ax
  100f3f:	90                   	nop

00100f40 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  100f40:	55                   	push   %ebp
  100f41:	89 e5                	mov    %esp,%ebp
  100f43:	53                   	push   %ebx
  100f44:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  100f47:	9c                   	pushf  
  100f48:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
  100f49:	f6 c4 02             	test   $0x2,%ah
  100f4c:	75 44                	jne    100f92 <mycpu+0x52>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  100f4e:	e8 0d f7 ff ff       	call   100660 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
  100f53:	8b 1d 98 24 10 00    	mov    0x102498,%ebx
  100f59:	85 db                	test   %ebx,%ebx
  100f5b:	7e 28                	jle    100f85 <mycpu+0x45>
  100f5d:	31 d2                	xor    %edx,%edx
  100f5f:	eb 0e                	jmp    100f6f <mycpu+0x2f>
  100f61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100f68:	83 c2 01             	add    $0x1,%edx
  100f6b:	39 da                	cmp    %ebx,%edx
  100f6d:	74 16                	je     100f85 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
  100f6f:	0f b6 8a 9c 24 10 00 	movzbl 0x10249c(%edx),%ecx
  100f76:	39 c1                	cmp    %eax,%ecx
  100f78:	75 ee                	jne    100f68 <mycpu+0x28>
      return &cpus[i];
  }
  panic("unknown apicid\n");
  100f7a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return &cpus[i];
  100f7d:	8d 82 9c 24 10 00    	lea    0x10249c(%edx),%eax
  100f83:	c9                   	leave  
  100f84:	c3                   	ret    
  panic("unknown apicid\n");
  100f85:	83 ec 0c             	sub    $0xc,%esp
  100f88:	68 e6 1c 10 00       	push   $0x101ce6
  100f8d:	e8 ae f2 ff ff       	call   100240 <panic>
    panic("mycpu called with interrupts enabled\n");
  100f92:	83 ec 0c             	sub    $0xc,%esp
  100f95:	68 c0 1c 10 00       	push   $0x101cc0
  100f9a:	e8 a1 f2 ff ff       	call   100240 <panic>
  100f9f:	90                   	nop

00100fa0 <cpuid>:
cpuid() {
  100fa0:	55                   	push   %ebp
  100fa1:	89 e5                	mov    %esp,%ebp
  100fa3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
  100fa6:	e8 95 ff ff ff       	call   100f40 <mycpu>
}
  100fab:	c9                   	leave  
  return mycpu()-cpus;
  100fac:	2d 9c 24 10 00       	sub    $0x10249c,%eax
}
  100fb1:	c3                   	ret    
  100fb2:	66 90                	xchg   %ax,%ax
  100fb4:	66 90                	xchg   %ax,%ax
  100fb6:	66 90                	xchg   %ax,%ax
  100fb8:	66 90                	xchg   %ax,%ax
  100fba:	66 90                	xchg   %ax,%ax
  100fbc:	66 90                	xchg   %ax,%ax
  100fbe:	66 90                	xchg   %ax,%ax

00100fc0 <getcallerpcs>:
// #include "memlayout.h"

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  100fc0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  100fc1:	31 d2                	xor    %edx,%edx
{
  100fc3:	89 e5                	mov    %esp,%ebp
  100fc5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
  100fc6:	8b 45 08             	mov    0x8(%ebp),%eax
{
  100fc9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
  100fcc:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
  100fcf:	90                   	nop
    // if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
    if(ebp == 0 || ebp == (uint*)0xffffffff)
  100fd0:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100fd3:	83 fb fd             	cmp    $0xfffffffd,%ebx
  100fd6:	77 18                	ja     100ff0 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
  100fd8:	8b 58 04             	mov    0x4(%eax),%ebx
  100fdb:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
  100fde:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
  100fe1:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
  100fe3:	83 fa 0a             	cmp    $0xa,%edx
  100fe6:	75 e8                	jne    100fd0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
  100fe8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100feb:	c9                   	leave  
  100fec:	c3                   	ret    
  100fed:	8d 76 00             	lea    0x0(%esi),%esi
  for(; i < 10; i++)
  100ff0:	8d 04 91             	lea    (%ecx,%edx,4),%eax
  100ff3:	8d 51 28             	lea    0x28(%ecx),%edx
  100ff6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100ffd:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
  101000:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
  101006:	83 c0 04             	add    $0x4,%eax
  101009:	39 d0                	cmp    %edx,%eax
  10100b:	75 f3                	jne    101000 <getcallerpcs+0x40>
  10100d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  101010:	c9                   	leave  
  101011:	c3                   	ret    

00101012 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushal
  101012:	60                   	pusha  
  
  # Call trap(tf), where tf=%esp
  pushl %esp
  101013:	54                   	push   %esp
  call trap
  101014:	e8 87 00 00 00       	call   1010a0 <trap>
  addl $4, %esp
  101019:	83 c4 04             	add    $0x4,%esp

0010101c <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
  10101c:	61                   	popa   
  addl $0x8, %esp  # trapno and errcode
  10101d:	83 c4 08             	add    $0x8,%esp
  iret
  101020:	cf                   	iret   
  101021:	66 90                	xchg   %ax,%ax
  101023:	66 90                	xchg   %ax,%ax
  101025:	66 90                	xchg   %ax,%ax
  101027:	66 90                	xchg   %ax,%ax
  101029:	66 90                	xchg   %ax,%ax
  10102b:	66 90                	xchg   %ax,%ax
  10102d:	66 90                	xchg   %ax,%ax
  10102f:	90                   	nop

00101030 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
  101030:	31 c0                	xor    %eax,%eax
  101032:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  101038:	8b 14 85 00 20 10 00 	mov    0x102000(,%eax,4),%edx
  10103f:	c7 04 c5 e2 24 10 00 	movl   $0x8e000008,0x1024e2(,%eax,8)
  101046:	08 00 00 8e 
  10104a:	66 89 14 c5 e0 24 10 	mov    %dx,0x1024e0(,%eax,8)
  101051:	00 
  101052:	c1 ea 10             	shr    $0x10,%edx
  101055:	66 89 14 c5 e6 24 10 	mov    %dx,0x1024e6(,%eax,8)
  10105c:	00 
  for(i = 0; i < 256; i++)
  10105d:	83 c0 01             	add    $0x1,%eax
  101060:	3d 00 01 00 00       	cmp    $0x100,%eax
  101065:	75 d1                	jne    101038 <tvinit+0x8>
}
  101067:	c3                   	ret    
  101068:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10106f:	90                   	nop

00101070 <idtinit>:

void
idtinit(void)
{
  101070:	55                   	push   %ebp
  pd[0] = size-1;
  101071:	b8 ff 07 00 00       	mov    $0x7ff,%eax
  101076:	89 e5                	mov    %esp,%ebp
  101078:	83 ec 10             	sub    $0x10,%esp
  10107b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
  10107f:	b8 e0 24 10 00       	mov    $0x1024e0,%eax
  101084:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
  101088:	c1 e8 10             	shr    $0x10,%eax
  10108b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
  10108f:	8d 45 fa             	lea    -0x6(%ebp),%eax
  101092:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
  101095:	c9                   	leave  
  101096:	c3                   	ret    
  101097:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  10109e:	66 90                	xchg   %ax,%ax

001010a0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  1010a0:	55                   	push   %ebp
  1010a1:	89 e5                	mov    %esp,%ebp
  1010a3:	57                   	push   %edi
  1010a4:	56                   	push   %esi
  1010a5:	53                   	push   %ebx
  1010a6:	83 ec 0c             	sub    $0xc,%esp
  1010a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  switch(tf->trapno){
  1010ac:	8b 43 20             	mov    0x20(%ebx),%eax
  1010af:	83 e8 20             	sub    $0x20,%eax
  1010b2:	83 f8 1f             	cmp    $0x1f,%eax
  1010b5:	77 7c                	ja     101133 <trap+0x93>
  1010b7:	ff 24 85 54 1d 10 00 	jmp    *0x101d54(,%eax,4)
  1010be:	66 90                	xchg   %ax,%ax
    mouseintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
  1010c0:	8b 73 28             	mov    0x28(%ebx),%esi
  1010c3:	0f b7 5b 2c          	movzwl 0x2c(%ebx),%ebx
  1010c7:	e8 d4 fe ff ff       	call   100fa0 <cpuid>
  1010cc:	56                   	push   %esi
  1010cd:	53                   	push   %ebx
  1010ce:	50                   	push   %eax
  1010cf:	68 f8 1c 10 00       	push   $0x101cf8
  1010d4:	e8 e7 ef ff ff       	call   1000c0 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
  1010d9:	83 c4 10             	add    $0x10,%esp
  default:
    cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
            tf->trapno, cpuid(), tf->eip, rcr2());
    panic("trap");
  }
}
  1010dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
  1010df:	5b                   	pop    %ebx
  1010e0:	5e                   	pop    %esi
  1010e1:	5f                   	pop    %edi
  1010e2:	5d                   	pop    %ebp
    lapiceoi();
  1010e3:	e9 98 f5 ff ff       	jmp    100680 <lapiceoi>
  1010e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1010ef:	90                   	nop
    mouseintr();
  1010f0:	e8 7b fb ff ff       	call   100c70 <mouseintr>
}
  1010f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
  1010f8:	5b                   	pop    %ebx
  1010f9:	5e                   	pop    %esi
  1010fa:	5f                   	pop    %edi
  1010fb:	5d                   	pop    %ebp
    lapiceoi();
  1010fc:	e9 7f f5 ff ff       	jmp    100680 <lapiceoi>
  101101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
  101108:	e8 d3 f9 ff ff       	call   100ae0 <uartintr>
}
  10110d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  101110:	5b                   	pop    %ebx
  101111:	5e                   	pop    %esi
  101112:	5f                   	pop    %edi
  101113:	5d                   	pop    %ebp
    lapiceoi();
  101114:	e9 67 f5 ff ff       	jmp    100680 <lapiceoi>
  101119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ticks++;
  101120:	83 05 c0 24 10 00 01 	addl   $0x1,0x1024c0
}
  101127:	8d 65 f4             	lea    -0xc(%ebp),%esp
  10112a:	5b                   	pop    %ebx
  10112b:	5e                   	pop    %esi
  10112c:	5f                   	pop    %edi
  10112d:	5d                   	pop    %ebp
    lapiceoi();
  10112e:	e9 4d f5 ff ff       	jmp    100680 <lapiceoi>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
  101133:	0f 20 d7             	mov    %cr2,%edi
    cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
  101136:	8b 73 28             	mov    0x28(%ebx),%esi
  101139:	e8 62 fe ff ff       	call   100fa0 <cpuid>
  10113e:	83 ec 0c             	sub    $0xc,%esp
  101141:	57                   	push   %edi
  101142:	56                   	push   %esi
  101143:	50                   	push   %eax
  101144:	ff 73 20             	push   0x20(%ebx)
  101147:	68 1c 1d 10 00       	push   $0x101d1c
  10114c:	e8 6f ef ff ff       	call   1000c0 <cprintf>
    panic("trap");
  101151:	83 c4 14             	add    $0x14,%esp
  101154:	68 4e 1d 10 00       	push   $0x101d4e
  101159:	e8 e2 f0 ff ff       	call   100240 <panic>

0010115e <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
  10115e:	6a 00                	push   $0x0
  pushl $0
  101160:	6a 00                	push   $0x0
  jmp alltraps
  101162:	e9 ab fe ff ff       	jmp    101012 <alltraps>

00101167 <vector1>:
.globl vector1
vector1:
  pushl $0
  101167:	6a 00                	push   $0x0
  pushl $1
  101169:	6a 01                	push   $0x1
  jmp alltraps
  10116b:	e9 a2 fe ff ff       	jmp    101012 <alltraps>

00101170 <vector2>:
.globl vector2
vector2:
  pushl $0
  101170:	6a 00                	push   $0x0
  pushl $2
  101172:	6a 02                	push   $0x2
  jmp alltraps
  101174:	e9 99 fe ff ff       	jmp    101012 <alltraps>

00101179 <vector3>:
.globl vector3
vector3:
  pushl $0
  101179:	6a 00                	push   $0x0
  pushl $3
  10117b:	6a 03                	push   $0x3
  jmp alltraps
  10117d:	e9 90 fe ff ff       	jmp    101012 <alltraps>

00101182 <vector4>:
.globl vector4
vector4:
  pushl $0
  101182:	6a 00                	push   $0x0
  pushl $4
  101184:	6a 04                	push   $0x4
  jmp alltraps
  101186:	e9 87 fe ff ff       	jmp    101012 <alltraps>

0010118b <vector5>:
.globl vector5
vector5:
  pushl $0
  10118b:	6a 00                	push   $0x0
  pushl $5
  10118d:	6a 05                	push   $0x5
  jmp alltraps
  10118f:	e9 7e fe ff ff       	jmp    101012 <alltraps>

00101194 <vector6>:
.globl vector6
vector6:
  pushl $0
  101194:	6a 00                	push   $0x0
  pushl $6
  101196:	6a 06                	push   $0x6
  jmp alltraps
  101198:	e9 75 fe ff ff       	jmp    101012 <alltraps>

0010119d <vector7>:
.globl vector7
vector7:
  pushl $0
  10119d:	6a 00                	push   $0x0
  pushl $7
  10119f:	6a 07                	push   $0x7
  jmp alltraps
  1011a1:	e9 6c fe ff ff       	jmp    101012 <alltraps>

001011a6 <vector8>:
.globl vector8
vector8:
  pushl $8
  1011a6:	6a 08                	push   $0x8
  jmp alltraps
  1011a8:	e9 65 fe ff ff       	jmp    101012 <alltraps>

001011ad <vector9>:
.globl vector9
vector9:
  pushl $0
  1011ad:	6a 00                	push   $0x0
  pushl $9
  1011af:	6a 09                	push   $0x9
  jmp alltraps
  1011b1:	e9 5c fe ff ff       	jmp    101012 <alltraps>

001011b6 <vector10>:
.globl vector10
vector10:
  pushl $10
  1011b6:	6a 0a                	push   $0xa
  jmp alltraps
  1011b8:	e9 55 fe ff ff       	jmp    101012 <alltraps>

001011bd <vector11>:
.globl vector11
vector11:
  pushl $11
  1011bd:	6a 0b                	push   $0xb
  jmp alltraps
  1011bf:	e9 4e fe ff ff       	jmp    101012 <alltraps>

001011c4 <vector12>:
.globl vector12
vector12:
  pushl $12
  1011c4:	6a 0c                	push   $0xc
  jmp alltraps
  1011c6:	e9 47 fe ff ff       	jmp    101012 <alltraps>

001011cb <vector13>:
.globl vector13
vector13:
  pushl $13
  1011cb:	6a 0d                	push   $0xd
  jmp alltraps
  1011cd:	e9 40 fe ff ff       	jmp    101012 <alltraps>

001011d2 <vector14>:
.globl vector14
vector14:
  pushl $14
  1011d2:	6a 0e                	push   $0xe
  jmp alltraps
  1011d4:	e9 39 fe ff ff       	jmp    101012 <alltraps>

001011d9 <vector15>:
.globl vector15
vector15:
  pushl $0
  1011d9:	6a 00                	push   $0x0
  pushl $15
  1011db:	6a 0f                	push   $0xf
  jmp alltraps
  1011dd:	e9 30 fe ff ff       	jmp    101012 <alltraps>

001011e2 <vector16>:
.globl vector16
vector16:
  pushl $0
  1011e2:	6a 00                	push   $0x0
  pushl $16
  1011e4:	6a 10                	push   $0x10
  jmp alltraps
  1011e6:	e9 27 fe ff ff       	jmp    101012 <alltraps>

001011eb <vector17>:
.globl vector17
vector17:
  pushl $17
  1011eb:	6a 11                	push   $0x11
  jmp alltraps
  1011ed:	e9 20 fe ff ff       	jmp    101012 <alltraps>

001011f2 <vector18>:
.globl vector18
vector18:
  pushl $0
  1011f2:	6a 00                	push   $0x0
  pushl $18
  1011f4:	6a 12                	push   $0x12
  jmp alltraps
  1011f6:	e9 17 fe ff ff       	jmp    101012 <alltraps>

001011fb <vector19>:
.globl vector19
vector19:
  pushl $0
  1011fb:	6a 00                	push   $0x0
  pushl $19
  1011fd:	6a 13                	push   $0x13
  jmp alltraps
  1011ff:	e9 0e fe ff ff       	jmp    101012 <alltraps>

00101204 <vector20>:
.globl vector20
vector20:
  pushl $0
  101204:	6a 00                	push   $0x0
  pushl $20
  101206:	6a 14                	push   $0x14
  jmp alltraps
  101208:	e9 05 fe ff ff       	jmp    101012 <alltraps>

0010120d <vector21>:
.globl vector21
vector21:
  pushl $0
  10120d:	6a 00                	push   $0x0
  pushl $21
  10120f:	6a 15                	push   $0x15
  jmp alltraps
  101211:	e9 fc fd ff ff       	jmp    101012 <alltraps>

00101216 <vector22>:
.globl vector22
vector22:
  pushl $0
  101216:	6a 00                	push   $0x0
  pushl $22
  101218:	6a 16                	push   $0x16
  jmp alltraps
  10121a:	e9 f3 fd ff ff       	jmp    101012 <alltraps>

0010121f <vector23>:
.globl vector23
vector23:
  pushl $0
  10121f:	6a 00                	push   $0x0
  pushl $23
  101221:	6a 17                	push   $0x17
  jmp alltraps
  101223:	e9 ea fd ff ff       	jmp    101012 <alltraps>

00101228 <vector24>:
.globl vector24
vector24:
  pushl $0
  101228:	6a 00                	push   $0x0
  pushl $24
  10122a:	6a 18                	push   $0x18
  jmp alltraps
  10122c:	e9 e1 fd ff ff       	jmp    101012 <alltraps>

00101231 <vector25>:
.globl vector25
vector25:
  pushl $0
  101231:	6a 00                	push   $0x0
  pushl $25
  101233:	6a 19                	push   $0x19
  jmp alltraps
  101235:	e9 d8 fd ff ff       	jmp    101012 <alltraps>

0010123a <vector26>:
.globl vector26
vector26:
  pushl $0
  10123a:	6a 00                	push   $0x0
  pushl $26
  10123c:	6a 1a                	push   $0x1a
  jmp alltraps
  10123e:	e9 cf fd ff ff       	jmp    101012 <alltraps>

00101243 <vector27>:
.globl vector27
vector27:
  pushl $0
  101243:	6a 00                	push   $0x0
  pushl $27
  101245:	6a 1b                	push   $0x1b
  jmp alltraps
  101247:	e9 c6 fd ff ff       	jmp    101012 <alltraps>

0010124c <vector28>:
.globl vector28
vector28:
  pushl $0
  10124c:	6a 00                	push   $0x0
  pushl $28
  10124e:	6a 1c                	push   $0x1c
  jmp alltraps
  101250:	e9 bd fd ff ff       	jmp    101012 <alltraps>

00101255 <vector29>:
.globl vector29
vector29:
  pushl $0
  101255:	6a 00                	push   $0x0
  pushl $29
  101257:	6a 1d                	push   $0x1d
  jmp alltraps
  101259:	e9 b4 fd ff ff       	jmp    101012 <alltraps>

0010125e <vector30>:
.globl vector30
vector30:
  pushl $0
  10125e:	6a 00                	push   $0x0
  pushl $30
  101260:	6a 1e                	push   $0x1e
  jmp alltraps
  101262:	e9 ab fd ff ff       	jmp    101012 <alltraps>

00101267 <vector31>:
.globl vector31
vector31:
  pushl $0
  101267:	6a 00                	push   $0x0
  pushl $31
  101269:	6a 1f                	push   $0x1f
  jmp alltraps
  10126b:	e9 a2 fd ff ff       	jmp    101012 <alltraps>

00101270 <vector32>:
.globl vector32
vector32:
  pushl $0
  101270:	6a 00                	push   $0x0
  pushl $32
  101272:	6a 20                	push   $0x20
  jmp alltraps
  101274:	e9 99 fd ff ff       	jmp    101012 <alltraps>

00101279 <vector33>:
.globl vector33
vector33:
  pushl $0
  101279:	6a 00                	push   $0x0
  pushl $33
  10127b:	6a 21                	push   $0x21
  jmp alltraps
  10127d:	e9 90 fd ff ff       	jmp    101012 <alltraps>

00101282 <vector34>:
.globl vector34
vector34:
  pushl $0
  101282:	6a 00                	push   $0x0
  pushl $34
  101284:	6a 22                	push   $0x22
  jmp alltraps
  101286:	e9 87 fd ff ff       	jmp    101012 <alltraps>

0010128b <vector35>:
.globl vector35
vector35:
  pushl $0
  10128b:	6a 00                	push   $0x0
  pushl $35
  10128d:	6a 23                	push   $0x23
  jmp alltraps
  10128f:	e9 7e fd ff ff       	jmp    101012 <alltraps>

00101294 <vector36>:
.globl vector36
vector36:
  pushl $0
  101294:	6a 00                	push   $0x0
  pushl $36
  101296:	6a 24                	push   $0x24
  jmp alltraps
  101298:	e9 75 fd ff ff       	jmp    101012 <alltraps>

0010129d <vector37>:
.globl vector37
vector37:
  pushl $0
  10129d:	6a 00                	push   $0x0
  pushl $37
  10129f:	6a 25                	push   $0x25
  jmp alltraps
  1012a1:	e9 6c fd ff ff       	jmp    101012 <alltraps>

001012a6 <vector38>:
.globl vector38
vector38:
  pushl $0
  1012a6:	6a 00                	push   $0x0
  pushl $38
  1012a8:	6a 26                	push   $0x26
  jmp alltraps
  1012aa:	e9 63 fd ff ff       	jmp    101012 <alltraps>

001012af <vector39>:
.globl vector39
vector39:
  pushl $0
  1012af:	6a 00                	push   $0x0
  pushl $39
  1012b1:	6a 27                	push   $0x27
  jmp alltraps
  1012b3:	e9 5a fd ff ff       	jmp    101012 <alltraps>

001012b8 <vector40>:
.globl vector40
vector40:
  pushl $0
  1012b8:	6a 00                	push   $0x0
  pushl $40
  1012ba:	6a 28                	push   $0x28
  jmp alltraps
  1012bc:	e9 51 fd ff ff       	jmp    101012 <alltraps>

001012c1 <vector41>:
.globl vector41
vector41:
  pushl $0
  1012c1:	6a 00                	push   $0x0
  pushl $41
  1012c3:	6a 29                	push   $0x29
  jmp alltraps
  1012c5:	e9 48 fd ff ff       	jmp    101012 <alltraps>

001012ca <vector42>:
.globl vector42
vector42:
  pushl $0
  1012ca:	6a 00                	push   $0x0
  pushl $42
  1012cc:	6a 2a                	push   $0x2a
  jmp alltraps
  1012ce:	e9 3f fd ff ff       	jmp    101012 <alltraps>

001012d3 <vector43>:
.globl vector43
vector43:
  pushl $0
  1012d3:	6a 00                	push   $0x0
  pushl $43
  1012d5:	6a 2b                	push   $0x2b
  jmp alltraps
  1012d7:	e9 36 fd ff ff       	jmp    101012 <alltraps>

001012dc <vector44>:
.globl vector44
vector44:
  pushl $0
  1012dc:	6a 00                	push   $0x0
  pushl $44
  1012de:	6a 2c                	push   $0x2c
  jmp alltraps
  1012e0:	e9 2d fd ff ff       	jmp    101012 <alltraps>

001012e5 <vector45>:
.globl vector45
vector45:
  pushl $0
  1012e5:	6a 00                	push   $0x0
  pushl $45
  1012e7:	6a 2d                	push   $0x2d
  jmp alltraps
  1012e9:	e9 24 fd ff ff       	jmp    101012 <alltraps>

001012ee <vector46>:
.globl vector46
vector46:
  pushl $0
  1012ee:	6a 00                	push   $0x0
  pushl $46
  1012f0:	6a 2e                	push   $0x2e
  jmp alltraps
  1012f2:	e9 1b fd ff ff       	jmp    101012 <alltraps>

001012f7 <vector47>:
.globl vector47
vector47:
  pushl $0
  1012f7:	6a 00                	push   $0x0
  pushl $47
  1012f9:	6a 2f                	push   $0x2f
  jmp alltraps
  1012fb:	e9 12 fd ff ff       	jmp    101012 <alltraps>

00101300 <vector48>:
.globl vector48
vector48:
  pushl $0
  101300:	6a 00                	push   $0x0
  pushl $48
  101302:	6a 30                	push   $0x30
  jmp alltraps
  101304:	e9 09 fd ff ff       	jmp    101012 <alltraps>

00101309 <vector49>:
.globl vector49
vector49:
  pushl $0
  101309:	6a 00                	push   $0x0
  pushl $49
  10130b:	6a 31                	push   $0x31
  jmp alltraps
  10130d:	e9 00 fd ff ff       	jmp    101012 <alltraps>

00101312 <vector50>:
.globl vector50
vector50:
  pushl $0
  101312:	6a 00                	push   $0x0
  pushl $50
  101314:	6a 32                	push   $0x32
  jmp alltraps
  101316:	e9 f7 fc ff ff       	jmp    101012 <alltraps>

0010131b <vector51>:
.globl vector51
vector51:
  pushl $0
  10131b:	6a 00                	push   $0x0
  pushl $51
  10131d:	6a 33                	push   $0x33
  jmp alltraps
  10131f:	e9 ee fc ff ff       	jmp    101012 <alltraps>

00101324 <vector52>:
.globl vector52
vector52:
  pushl $0
  101324:	6a 00                	push   $0x0
  pushl $52
  101326:	6a 34                	push   $0x34
  jmp alltraps
  101328:	e9 e5 fc ff ff       	jmp    101012 <alltraps>

0010132d <vector53>:
.globl vector53
vector53:
  pushl $0
  10132d:	6a 00                	push   $0x0
  pushl $53
  10132f:	6a 35                	push   $0x35
  jmp alltraps
  101331:	e9 dc fc ff ff       	jmp    101012 <alltraps>

00101336 <vector54>:
.globl vector54
vector54:
  pushl $0
  101336:	6a 00                	push   $0x0
  pushl $54
  101338:	6a 36                	push   $0x36
  jmp alltraps
  10133a:	e9 d3 fc ff ff       	jmp    101012 <alltraps>

0010133f <vector55>:
.globl vector55
vector55:
  pushl $0
  10133f:	6a 00                	push   $0x0
  pushl $55
  101341:	6a 37                	push   $0x37
  jmp alltraps
  101343:	e9 ca fc ff ff       	jmp    101012 <alltraps>

00101348 <vector56>:
.globl vector56
vector56:
  pushl $0
  101348:	6a 00                	push   $0x0
  pushl $56
  10134a:	6a 38                	push   $0x38
  jmp alltraps
  10134c:	e9 c1 fc ff ff       	jmp    101012 <alltraps>

00101351 <vector57>:
.globl vector57
vector57:
  pushl $0
  101351:	6a 00                	push   $0x0
  pushl $57
  101353:	6a 39                	push   $0x39
  jmp alltraps
  101355:	e9 b8 fc ff ff       	jmp    101012 <alltraps>

0010135a <vector58>:
.globl vector58
vector58:
  pushl $0
  10135a:	6a 00                	push   $0x0
  pushl $58
  10135c:	6a 3a                	push   $0x3a
  jmp alltraps
  10135e:	e9 af fc ff ff       	jmp    101012 <alltraps>

00101363 <vector59>:
.globl vector59
vector59:
  pushl $0
  101363:	6a 00                	push   $0x0
  pushl $59
  101365:	6a 3b                	push   $0x3b
  jmp alltraps
  101367:	e9 a6 fc ff ff       	jmp    101012 <alltraps>

0010136c <vector60>:
.globl vector60
vector60:
  pushl $0
  10136c:	6a 00                	push   $0x0
  pushl $60
  10136e:	6a 3c                	push   $0x3c
  jmp alltraps
  101370:	e9 9d fc ff ff       	jmp    101012 <alltraps>

00101375 <vector61>:
.globl vector61
vector61:
  pushl $0
  101375:	6a 00                	push   $0x0
  pushl $61
  101377:	6a 3d                	push   $0x3d
  jmp alltraps
  101379:	e9 94 fc ff ff       	jmp    101012 <alltraps>

0010137e <vector62>:
.globl vector62
vector62:
  pushl $0
  10137e:	6a 00                	push   $0x0
  pushl $62
  101380:	6a 3e                	push   $0x3e
  jmp alltraps
  101382:	e9 8b fc ff ff       	jmp    101012 <alltraps>

00101387 <vector63>:
.globl vector63
vector63:
  pushl $0
  101387:	6a 00                	push   $0x0
  pushl $63
  101389:	6a 3f                	push   $0x3f
  jmp alltraps
  10138b:	e9 82 fc ff ff       	jmp    101012 <alltraps>

00101390 <vector64>:
.globl vector64
vector64:
  pushl $0
  101390:	6a 00                	push   $0x0
  pushl $64
  101392:	6a 40                	push   $0x40
  jmp alltraps
  101394:	e9 79 fc ff ff       	jmp    101012 <alltraps>

00101399 <vector65>:
.globl vector65
vector65:
  pushl $0
  101399:	6a 00                	push   $0x0
  pushl $65
  10139b:	6a 41                	push   $0x41
  jmp alltraps
  10139d:	e9 70 fc ff ff       	jmp    101012 <alltraps>

001013a2 <vector66>:
.globl vector66
vector66:
  pushl $0
  1013a2:	6a 00                	push   $0x0
  pushl $66
  1013a4:	6a 42                	push   $0x42
  jmp alltraps
  1013a6:	e9 67 fc ff ff       	jmp    101012 <alltraps>

001013ab <vector67>:
.globl vector67
vector67:
  pushl $0
  1013ab:	6a 00                	push   $0x0
  pushl $67
  1013ad:	6a 43                	push   $0x43
  jmp alltraps
  1013af:	e9 5e fc ff ff       	jmp    101012 <alltraps>

001013b4 <vector68>:
.globl vector68
vector68:
  pushl $0
  1013b4:	6a 00                	push   $0x0
  pushl $68
  1013b6:	6a 44                	push   $0x44
  jmp alltraps
  1013b8:	e9 55 fc ff ff       	jmp    101012 <alltraps>

001013bd <vector69>:
.globl vector69
vector69:
  pushl $0
  1013bd:	6a 00                	push   $0x0
  pushl $69
  1013bf:	6a 45                	push   $0x45
  jmp alltraps
  1013c1:	e9 4c fc ff ff       	jmp    101012 <alltraps>

001013c6 <vector70>:
.globl vector70
vector70:
  pushl $0
  1013c6:	6a 00                	push   $0x0
  pushl $70
  1013c8:	6a 46                	push   $0x46
  jmp alltraps
  1013ca:	e9 43 fc ff ff       	jmp    101012 <alltraps>

001013cf <vector71>:
.globl vector71
vector71:
  pushl $0
  1013cf:	6a 00                	push   $0x0
  pushl $71
  1013d1:	6a 47                	push   $0x47
  jmp alltraps
  1013d3:	e9 3a fc ff ff       	jmp    101012 <alltraps>

001013d8 <vector72>:
.globl vector72
vector72:
  pushl $0
  1013d8:	6a 00                	push   $0x0
  pushl $72
  1013da:	6a 48                	push   $0x48
  jmp alltraps
  1013dc:	e9 31 fc ff ff       	jmp    101012 <alltraps>

001013e1 <vector73>:
.globl vector73
vector73:
  pushl $0
  1013e1:	6a 00                	push   $0x0
  pushl $73
  1013e3:	6a 49                	push   $0x49
  jmp alltraps
  1013e5:	e9 28 fc ff ff       	jmp    101012 <alltraps>

001013ea <vector74>:
.globl vector74
vector74:
  pushl $0
  1013ea:	6a 00                	push   $0x0
  pushl $74
  1013ec:	6a 4a                	push   $0x4a
  jmp alltraps
  1013ee:	e9 1f fc ff ff       	jmp    101012 <alltraps>

001013f3 <vector75>:
.globl vector75
vector75:
  pushl $0
  1013f3:	6a 00                	push   $0x0
  pushl $75
  1013f5:	6a 4b                	push   $0x4b
  jmp alltraps
  1013f7:	e9 16 fc ff ff       	jmp    101012 <alltraps>

001013fc <vector76>:
.globl vector76
vector76:
  pushl $0
  1013fc:	6a 00                	push   $0x0
  pushl $76
  1013fe:	6a 4c                	push   $0x4c
  jmp alltraps
  101400:	e9 0d fc ff ff       	jmp    101012 <alltraps>

00101405 <vector77>:
.globl vector77
vector77:
  pushl $0
  101405:	6a 00                	push   $0x0
  pushl $77
  101407:	6a 4d                	push   $0x4d
  jmp alltraps
  101409:	e9 04 fc ff ff       	jmp    101012 <alltraps>

0010140e <vector78>:
.globl vector78
vector78:
  pushl $0
  10140e:	6a 00                	push   $0x0
  pushl $78
  101410:	6a 4e                	push   $0x4e
  jmp alltraps
  101412:	e9 fb fb ff ff       	jmp    101012 <alltraps>

00101417 <vector79>:
.globl vector79
vector79:
  pushl $0
  101417:	6a 00                	push   $0x0
  pushl $79
  101419:	6a 4f                	push   $0x4f
  jmp alltraps
  10141b:	e9 f2 fb ff ff       	jmp    101012 <alltraps>

00101420 <vector80>:
.globl vector80
vector80:
  pushl $0
  101420:	6a 00                	push   $0x0
  pushl $80
  101422:	6a 50                	push   $0x50
  jmp alltraps
  101424:	e9 e9 fb ff ff       	jmp    101012 <alltraps>

00101429 <vector81>:
.globl vector81
vector81:
  pushl $0
  101429:	6a 00                	push   $0x0
  pushl $81
  10142b:	6a 51                	push   $0x51
  jmp alltraps
  10142d:	e9 e0 fb ff ff       	jmp    101012 <alltraps>

00101432 <vector82>:
.globl vector82
vector82:
  pushl $0
  101432:	6a 00                	push   $0x0
  pushl $82
  101434:	6a 52                	push   $0x52
  jmp alltraps
  101436:	e9 d7 fb ff ff       	jmp    101012 <alltraps>

0010143b <vector83>:
.globl vector83
vector83:
  pushl $0
  10143b:	6a 00                	push   $0x0
  pushl $83
  10143d:	6a 53                	push   $0x53
  jmp alltraps
  10143f:	e9 ce fb ff ff       	jmp    101012 <alltraps>

00101444 <vector84>:
.globl vector84
vector84:
  pushl $0
  101444:	6a 00                	push   $0x0
  pushl $84
  101446:	6a 54                	push   $0x54
  jmp alltraps
  101448:	e9 c5 fb ff ff       	jmp    101012 <alltraps>

0010144d <vector85>:
.globl vector85
vector85:
  pushl $0
  10144d:	6a 00                	push   $0x0
  pushl $85
  10144f:	6a 55                	push   $0x55
  jmp alltraps
  101451:	e9 bc fb ff ff       	jmp    101012 <alltraps>

00101456 <vector86>:
.globl vector86
vector86:
  pushl $0
  101456:	6a 00                	push   $0x0
  pushl $86
  101458:	6a 56                	push   $0x56
  jmp alltraps
  10145a:	e9 b3 fb ff ff       	jmp    101012 <alltraps>

0010145f <vector87>:
.globl vector87
vector87:
  pushl $0
  10145f:	6a 00                	push   $0x0
  pushl $87
  101461:	6a 57                	push   $0x57
  jmp alltraps
  101463:	e9 aa fb ff ff       	jmp    101012 <alltraps>

00101468 <vector88>:
.globl vector88
vector88:
  pushl $0
  101468:	6a 00                	push   $0x0
  pushl $88
  10146a:	6a 58                	push   $0x58
  jmp alltraps
  10146c:	e9 a1 fb ff ff       	jmp    101012 <alltraps>

00101471 <vector89>:
.globl vector89
vector89:
  pushl $0
  101471:	6a 00                	push   $0x0
  pushl $89
  101473:	6a 59                	push   $0x59
  jmp alltraps
  101475:	e9 98 fb ff ff       	jmp    101012 <alltraps>

0010147a <vector90>:
.globl vector90
vector90:
  pushl $0
  10147a:	6a 00                	push   $0x0
  pushl $90
  10147c:	6a 5a                	push   $0x5a
  jmp alltraps
  10147e:	e9 8f fb ff ff       	jmp    101012 <alltraps>

00101483 <vector91>:
.globl vector91
vector91:
  pushl $0
  101483:	6a 00                	push   $0x0
  pushl $91
  101485:	6a 5b                	push   $0x5b
  jmp alltraps
  101487:	e9 86 fb ff ff       	jmp    101012 <alltraps>

0010148c <vector92>:
.globl vector92
vector92:
  pushl $0
  10148c:	6a 00                	push   $0x0
  pushl $92
  10148e:	6a 5c                	push   $0x5c
  jmp alltraps
  101490:	e9 7d fb ff ff       	jmp    101012 <alltraps>

00101495 <vector93>:
.globl vector93
vector93:
  pushl $0
  101495:	6a 00                	push   $0x0
  pushl $93
  101497:	6a 5d                	push   $0x5d
  jmp alltraps
  101499:	e9 74 fb ff ff       	jmp    101012 <alltraps>

0010149e <vector94>:
.globl vector94
vector94:
  pushl $0
  10149e:	6a 00                	push   $0x0
  pushl $94
  1014a0:	6a 5e                	push   $0x5e
  jmp alltraps
  1014a2:	e9 6b fb ff ff       	jmp    101012 <alltraps>

001014a7 <vector95>:
.globl vector95
vector95:
  pushl $0
  1014a7:	6a 00                	push   $0x0
  pushl $95
  1014a9:	6a 5f                	push   $0x5f
  jmp alltraps
  1014ab:	e9 62 fb ff ff       	jmp    101012 <alltraps>

001014b0 <vector96>:
.globl vector96
vector96:
  pushl $0
  1014b0:	6a 00                	push   $0x0
  pushl $96
  1014b2:	6a 60                	push   $0x60
  jmp alltraps
  1014b4:	e9 59 fb ff ff       	jmp    101012 <alltraps>

001014b9 <vector97>:
.globl vector97
vector97:
  pushl $0
  1014b9:	6a 00                	push   $0x0
  pushl $97
  1014bb:	6a 61                	push   $0x61
  jmp alltraps
  1014bd:	e9 50 fb ff ff       	jmp    101012 <alltraps>

001014c2 <vector98>:
.globl vector98
vector98:
  pushl $0
  1014c2:	6a 00                	push   $0x0
  pushl $98
  1014c4:	6a 62                	push   $0x62
  jmp alltraps
  1014c6:	e9 47 fb ff ff       	jmp    101012 <alltraps>

001014cb <vector99>:
.globl vector99
vector99:
  pushl $0
  1014cb:	6a 00                	push   $0x0
  pushl $99
  1014cd:	6a 63                	push   $0x63
  jmp alltraps
  1014cf:	e9 3e fb ff ff       	jmp    101012 <alltraps>

001014d4 <vector100>:
.globl vector100
vector100:
  pushl $0
  1014d4:	6a 00                	push   $0x0
  pushl $100
  1014d6:	6a 64                	push   $0x64
  jmp alltraps
  1014d8:	e9 35 fb ff ff       	jmp    101012 <alltraps>

001014dd <vector101>:
.globl vector101
vector101:
  pushl $0
  1014dd:	6a 00                	push   $0x0
  pushl $101
  1014df:	6a 65                	push   $0x65
  jmp alltraps
  1014e1:	e9 2c fb ff ff       	jmp    101012 <alltraps>

001014e6 <vector102>:
.globl vector102
vector102:
  pushl $0
  1014e6:	6a 00                	push   $0x0
  pushl $102
  1014e8:	6a 66                	push   $0x66
  jmp alltraps
  1014ea:	e9 23 fb ff ff       	jmp    101012 <alltraps>

001014ef <vector103>:
.globl vector103
vector103:
  pushl $0
  1014ef:	6a 00                	push   $0x0
  pushl $103
  1014f1:	6a 67                	push   $0x67
  jmp alltraps
  1014f3:	e9 1a fb ff ff       	jmp    101012 <alltraps>

001014f8 <vector104>:
.globl vector104
vector104:
  pushl $0
  1014f8:	6a 00                	push   $0x0
  pushl $104
  1014fa:	6a 68                	push   $0x68
  jmp alltraps
  1014fc:	e9 11 fb ff ff       	jmp    101012 <alltraps>

00101501 <vector105>:
.globl vector105
vector105:
  pushl $0
  101501:	6a 00                	push   $0x0
  pushl $105
  101503:	6a 69                	push   $0x69
  jmp alltraps
  101505:	e9 08 fb ff ff       	jmp    101012 <alltraps>

0010150a <vector106>:
.globl vector106
vector106:
  pushl $0
  10150a:	6a 00                	push   $0x0
  pushl $106
  10150c:	6a 6a                	push   $0x6a
  jmp alltraps
  10150e:	e9 ff fa ff ff       	jmp    101012 <alltraps>

00101513 <vector107>:
.globl vector107
vector107:
  pushl $0
  101513:	6a 00                	push   $0x0
  pushl $107
  101515:	6a 6b                	push   $0x6b
  jmp alltraps
  101517:	e9 f6 fa ff ff       	jmp    101012 <alltraps>

0010151c <vector108>:
.globl vector108
vector108:
  pushl $0
  10151c:	6a 00                	push   $0x0
  pushl $108
  10151e:	6a 6c                	push   $0x6c
  jmp alltraps
  101520:	e9 ed fa ff ff       	jmp    101012 <alltraps>

00101525 <vector109>:
.globl vector109
vector109:
  pushl $0
  101525:	6a 00                	push   $0x0
  pushl $109
  101527:	6a 6d                	push   $0x6d
  jmp alltraps
  101529:	e9 e4 fa ff ff       	jmp    101012 <alltraps>

0010152e <vector110>:
.globl vector110
vector110:
  pushl $0
  10152e:	6a 00                	push   $0x0
  pushl $110
  101530:	6a 6e                	push   $0x6e
  jmp alltraps
  101532:	e9 db fa ff ff       	jmp    101012 <alltraps>

00101537 <vector111>:
.globl vector111
vector111:
  pushl $0
  101537:	6a 00                	push   $0x0
  pushl $111
  101539:	6a 6f                	push   $0x6f
  jmp alltraps
  10153b:	e9 d2 fa ff ff       	jmp    101012 <alltraps>

00101540 <vector112>:
.globl vector112
vector112:
  pushl $0
  101540:	6a 00                	push   $0x0
  pushl $112
  101542:	6a 70                	push   $0x70
  jmp alltraps
  101544:	e9 c9 fa ff ff       	jmp    101012 <alltraps>

00101549 <vector113>:
.globl vector113
vector113:
  pushl $0
  101549:	6a 00                	push   $0x0
  pushl $113
  10154b:	6a 71                	push   $0x71
  jmp alltraps
  10154d:	e9 c0 fa ff ff       	jmp    101012 <alltraps>

00101552 <vector114>:
.globl vector114
vector114:
  pushl $0
  101552:	6a 00                	push   $0x0
  pushl $114
  101554:	6a 72                	push   $0x72
  jmp alltraps
  101556:	e9 b7 fa ff ff       	jmp    101012 <alltraps>

0010155b <vector115>:
.globl vector115
vector115:
  pushl $0
  10155b:	6a 00                	push   $0x0
  pushl $115
  10155d:	6a 73                	push   $0x73
  jmp alltraps
  10155f:	e9 ae fa ff ff       	jmp    101012 <alltraps>

00101564 <vector116>:
.globl vector116
vector116:
  pushl $0
  101564:	6a 00                	push   $0x0
  pushl $116
  101566:	6a 74                	push   $0x74
  jmp alltraps
  101568:	e9 a5 fa ff ff       	jmp    101012 <alltraps>

0010156d <vector117>:
.globl vector117
vector117:
  pushl $0
  10156d:	6a 00                	push   $0x0
  pushl $117
  10156f:	6a 75                	push   $0x75
  jmp alltraps
  101571:	e9 9c fa ff ff       	jmp    101012 <alltraps>

00101576 <vector118>:
.globl vector118
vector118:
  pushl $0
  101576:	6a 00                	push   $0x0
  pushl $118
  101578:	6a 76                	push   $0x76
  jmp alltraps
  10157a:	e9 93 fa ff ff       	jmp    101012 <alltraps>

0010157f <vector119>:
.globl vector119
vector119:
  pushl $0
  10157f:	6a 00                	push   $0x0
  pushl $119
  101581:	6a 77                	push   $0x77
  jmp alltraps
  101583:	e9 8a fa ff ff       	jmp    101012 <alltraps>

00101588 <vector120>:
.globl vector120
vector120:
  pushl $0
  101588:	6a 00                	push   $0x0
  pushl $120
  10158a:	6a 78                	push   $0x78
  jmp alltraps
  10158c:	e9 81 fa ff ff       	jmp    101012 <alltraps>

00101591 <vector121>:
.globl vector121
vector121:
  pushl $0
  101591:	6a 00                	push   $0x0
  pushl $121
  101593:	6a 79                	push   $0x79
  jmp alltraps
  101595:	e9 78 fa ff ff       	jmp    101012 <alltraps>

0010159a <vector122>:
.globl vector122
vector122:
  pushl $0
  10159a:	6a 00                	push   $0x0
  pushl $122
  10159c:	6a 7a                	push   $0x7a
  jmp alltraps
  10159e:	e9 6f fa ff ff       	jmp    101012 <alltraps>

001015a3 <vector123>:
.globl vector123
vector123:
  pushl $0
  1015a3:	6a 00                	push   $0x0
  pushl $123
  1015a5:	6a 7b                	push   $0x7b
  jmp alltraps
  1015a7:	e9 66 fa ff ff       	jmp    101012 <alltraps>

001015ac <vector124>:
.globl vector124
vector124:
  pushl $0
  1015ac:	6a 00                	push   $0x0
  pushl $124
  1015ae:	6a 7c                	push   $0x7c
  jmp alltraps
  1015b0:	e9 5d fa ff ff       	jmp    101012 <alltraps>

001015b5 <vector125>:
.globl vector125
vector125:
  pushl $0
  1015b5:	6a 00                	push   $0x0
  pushl $125
  1015b7:	6a 7d                	push   $0x7d
  jmp alltraps
  1015b9:	e9 54 fa ff ff       	jmp    101012 <alltraps>

001015be <vector126>:
.globl vector126
vector126:
  pushl $0
  1015be:	6a 00                	push   $0x0
  pushl $126
  1015c0:	6a 7e                	push   $0x7e
  jmp alltraps
  1015c2:	e9 4b fa ff ff       	jmp    101012 <alltraps>

001015c7 <vector127>:
.globl vector127
vector127:
  pushl $0
  1015c7:	6a 00                	push   $0x0
  pushl $127
  1015c9:	6a 7f                	push   $0x7f
  jmp alltraps
  1015cb:	e9 42 fa ff ff       	jmp    101012 <alltraps>

001015d0 <vector128>:
.globl vector128
vector128:
  pushl $0
  1015d0:	6a 00                	push   $0x0
  pushl $128
  1015d2:	68 80 00 00 00       	push   $0x80
  jmp alltraps
  1015d7:	e9 36 fa ff ff       	jmp    101012 <alltraps>

001015dc <vector129>:
.globl vector129
vector129:
  pushl $0
  1015dc:	6a 00                	push   $0x0
  pushl $129
  1015de:	68 81 00 00 00       	push   $0x81
  jmp alltraps
  1015e3:	e9 2a fa ff ff       	jmp    101012 <alltraps>

001015e8 <vector130>:
.globl vector130
vector130:
  pushl $0
  1015e8:	6a 00                	push   $0x0
  pushl $130
  1015ea:	68 82 00 00 00       	push   $0x82
  jmp alltraps
  1015ef:	e9 1e fa ff ff       	jmp    101012 <alltraps>

001015f4 <vector131>:
.globl vector131
vector131:
  pushl $0
  1015f4:	6a 00                	push   $0x0
  pushl $131
  1015f6:	68 83 00 00 00       	push   $0x83
  jmp alltraps
  1015fb:	e9 12 fa ff ff       	jmp    101012 <alltraps>

00101600 <vector132>:
.globl vector132
vector132:
  pushl $0
  101600:	6a 00                	push   $0x0
  pushl $132
  101602:	68 84 00 00 00       	push   $0x84
  jmp alltraps
  101607:	e9 06 fa ff ff       	jmp    101012 <alltraps>

0010160c <vector133>:
.globl vector133
vector133:
  pushl $0
  10160c:	6a 00                	push   $0x0
  pushl $133
  10160e:	68 85 00 00 00       	push   $0x85
  jmp alltraps
  101613:	e9 fa f9 ff ff       	jmp    101012 <alltraps>

00101618 <vector134>:
.globl vector134
vector134:
  pushl $0
  101618:	6a 00                	push   $0x0
  pushl $134
  10161a:	68 86 00 00 00       	push   $0x86
  jmp alltraps
  10161f:	e9 ee f9 ff ff       	jmp    101012 <alltraps>

00101624 <vector135>:
.globl vector135
vector135:
  pushl $0
  101624:	6a 00                	push   $0x0
  pushl $135
  101626:	68 87 00 00 00       	push   $0x87
  jmp alltraps
  10162b:	e9 e2 f9 ff ff       	jmp    101012 <alltraps>

00101630 <vector136>:
.globl vector136
vector136:
  pushl $0
  101630:	6a 00                	push   $0x0
  pushl $136
  101632:	68 88 00 00 00       	push   $0x88
  jmp alltraps
  101637:	e9 d6 f9 ff ff       	jmp    101012 <alltraps>

0010163c <vector137>:
.globl vector137
vector137:
  pushl $0
  10163c:	6a 00                	push   $0x0
  pushl $137
  10163e:	68 89 00 00 00       	push   $0x89
  jmp alltraps
  101643:	e9 ca f9 ff ff       	jmp    101012 <alltraps>

00101648 <vector138>:
.globl vector138
vector138:
  pushl $0
  101648:	6a 00                	push   $0x0
  pushl $138
  10164a:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
  10164f:	e9 be f9 ff ff       	jmp    101012 <alltraps>

00101654 <vector139>:
.globl vector139
vector139:
  pushl $0
  101654:	6a 00                	push   $0x0
  pushl $139
  101656:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
  10165b:	e9 b2 f9 ff ff       	jmp    101012 <alltraps>

00101660 <vector140>:
.globl vector140
vector140:
  pushl $0
  101660:	6a 00                	push   $0x0
  pushl $140
  101662:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
  101667:	e9 a6 f9 ff ff       	jmp    101012 <alltraps>

0010166c <vector141>:
.globl vector141
vector141:
  pushl $0
  10166c:	6a 00                	push   $0x0
  pushl $141
  10166e:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
  101673:	e9 9a f9 ff ff       	jmp    101012 <alltraps>

00101678 <vector142>:
.globl vector142
vector142:
  pushl $0
  101678:	6a 00                	push   $0x0
  pushl $142
  10167a:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
  10167f:	e9 8e f9 ff ff       	jmp    101012 <alltraps>

00101684 <vector143>:
.globl vector143
vector143:
  pushl $0
  101684:	6a 00                	push   $0x0
  pushl $143
  101686:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
  10168b:	e9 82 f9 ff ff       	jmp    101012 <alltraps>

00101690 <vector144>:
.globl vector144
vector144:
  pushl $0
  101690:	6a 00                	push   $0x0
  pushl $144
  101692:	68 90 00 00 00       	push   $0x90
  jmp alltraps
  101697:	e9 76 f9 ff ff       	jmp    101012 <alltraps>

0010169c <vector145>:
.globl vector145
vector145:
  pushl $0
  10169c:	6a 00                	push   $0x0
  pushl $145
  10169e:	68 91 00 00 00       	push   $0x91
  jmp alltraps
  1016a3:	e9 6a f9 ff ff       	jmp    101012 <alltraps>

001016a8 <vector146>:
.globl vector146
vector146:
  pushl $0
  1016a8:	6a 00                	push   $0x0
  pushl $146
  1016aa:	68 92 00 00 00       	push   $0x92
  jmp alltraps
  1016af:	e9 5e f9 ff ff       	jmp    101012 <alltraps>

001016b4 <vector147>:
.globl vector147
vector147:
  pushl $0
  1016b4:	6a 00                	push   $0x0
  pushl $147
  1016b6:	68 93 00 00 00       	push   $0x93
  jmp alltraps
  1016bb:	e9 52 f9 ff ff       	jmp    101012 <alltraps>

001016c0 <vector148>:
.globl vector148
vector148:
  pushl $0
  1016c0:	6a 00                	push   $0x0
  pushl $148
  1016c2:	68 94 00 00 00       	push   $0x94
  jmp alltraps
  1016c7:	e9 46 f9 ff ff       	jmp    101012 <alltraps>

001016cc <vector149>:
.globl vector149
vector149:
  pushl $0
  1016cc:	6a 00                	push   $0x0
  pushl $149
  1016ce:	68 95 00 00 00       	push   $0x95
  jmp alltraps
  1016d3:	e9 3a f9 ff ff       	jmp    101012 <alltraps>

001016d8 <vector150>:
.globl vector150
vector150:
  pushl $0
  1016d8:	6a 00                	push   $0x0
  pushl $150
  1016da:	68 96 00 00 00       	push   $0x96
  jmp alltraps
  1016df:	e9 2e f9 ff ff       	jmp    101012 <alltraps>

001016e4 <vector151>:
.globl vector151
vector151:
  pushl $0
  1016e4:	6a 00                	push   $0x0
  pushl $151
  1016e6:	68 97 00 00 00       	push   $0x97
  jmp alltraps
  1016eb:	e9 22 f9 ff ff       	jmp    101012 <alltraps>

001016f0 <vector152>:
.globl vector152
vector152:
  pushl $0
  1016f0:	6a 00                	push   $0x0
  pushl $152
  1016f2:	68 98 00 00 00       	push   $0x98
  jmp alltraps
  1016f7:	e9 16 f9 ff ff       	jmp    101012 <alltraps>

001016fc <vector153>:
.globl vector153
vector153:
  pushl $0
  1016fc:	6a 00                	push   $0x0
  pushl $153
  1016fe:	68 99 00 00 00       	push   $0x99
  jmp alltraps
  101703:	e9 0a f9 ff ff       	jmp    101012 <alltraps>

00101708 <vector154>:
.globl vector154
vector154:
  pushl $0
  101708:	6a 00                	push   $0x0
  pushl $154
  10170a:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
  10170f:	e9 fe f8 ff ff       	jmp    101012 <alltraps>

00101714 <vector155>:
.globl vector155
vector155:
  pushl $0
  101714:	6a 00                	push   $0x0
  pushl $155
  101716:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
  10171b:	e9 f2 f8 ff ff       	jmp    101012 <alltraps>

00101720 <vector156>:
.globl vector156
vector156:
  pushl $0
  101720:	6a 00                	push   $0x0
  pushl $156
  101722:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
  101727:	e9 e6 f8 ff ff       	jmp    101012 <alltraps>

0010172c <vector157>:
.globl vector157
vector157:
  pushl $0
  10172c:	6a 00                	push   $0x0
  pushl $157
  10172e:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
  101733:	e9 da f8 ff ff       	jmp    101012 <alltraps>

00101738 <vector158>:
.globl vector158
vector158:
  pushl $0
  101738:	6a 00                	push   $0x0
  pushl $158
  10173a:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
  10173f:	e9 ce f8 ff ff       	jmp    101012 <alltraps>

00101744 <vector159>:
.globl vector159
vector159:
  pushl $0
  101744:	6a 00                	push   $0x0
  pushl $159
  101746:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
  10174b:	e9 c2 f8 ff ff       	jmp    101012 <alltraps>

00101750 <vector160>:
.globl vector160
vector160:
  pushl $0
  101750:	6a 00                	push   $0x0
  pushl $160
  101752:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
  101757:	e9 b6 f8 ff ff       	jmp    101012 <alltraps>

0010175c <vector161>:
.globl vector161
vector161:
  pushl $0
  10175c:	6a 00                	push   $0x0
  pushl $161
  10175e:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
  101763:	e9 aa f8 ff ff       	jmp    101012 <alltraps>

00101768 <vector162>:
.globl vector162
vector162:
  pushl $0
  101768:	6a 00                	push   $0x0
  pushl $162
  10176a:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
  10176f:	e9 9e f8 ff ff       	jmp    101012 <alltraps>

00101774 <vector163>:
.globl vector163
vector163:
  pushl $0
  101774:	6a 00                	push   $0x0
  pushl $163
  101776:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
  10177b:	e9 92 f8 ff ff       	jmp    101012 <alltraps>

00101780 <vector164>:
.globl vector164
vector164:
  pushl $0
  101780:	6a 00                	push   $0x0
  pushl $164
  101782:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
  101787:	e9 86 f8 ff ff       	jmp    101012 <alltraps>

0010178c <vector165>:
.globl vector165
vector165:
  pushl $0
  10178c:	6a 00                	push   $0x0
  pushl $165
  10178e:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
  101793:	e9 7a f8 ff ff       	jmp    101012 <alltraps>

00101798 <vector166>:
.globl vector166
vector166:
  pushl $0
  101798:	6a 00                	push   $0x0
  pushl $166
  10179a:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
  10179f:	e9 6e f8 ff ff       	jmp    101012 <alltraps>

001017a4 <vector167>:
.globl vector167
vector167:
  pushl $0
  1017a4:	6a 00                	push   $0x0
  pushl $167
  1017a6:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
  1017ab:	e9 62 f8 ff ff       	jmp    101012 <alltraps>

001017b0 <vector168>:
.globl vector168
vector168:
  pushl $0
  1017b0:	6a 00                	push   $0x0
  pushl $168
  1017b2:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
  1017b7:	e9 56 f8 ff ff       	jmp    101012 <alltraps>

001017bc <vector169>:
.globl vector169
vector169:
  pushl $0
  1017bc:	6a 00                	push   $0x0
  pushl $169
  1017be:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
  1017c3:	e9 4a f8 ff ff       	jmp    101012 <alltraps>

001017c8 <vector170>:
.globl vector170
vector170:
  pushl $0
  1017c8:	6a 00                	push   $0x0
  pushl $170
  1017ca:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
  1017cf:	e9 3e f8 ff ff       	jmp    101012 <alltraps>

001017d4 <vector171>:
.globl vector171
vector171:
  pushl $0
  1017d4:	6a 00                	push   $0x0
  pushl $171
  1017d6:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
  1017db:	e9 32 f8 ff ff       	jmp    101012 <alltraps>

001017e0 <vector172>:
.globl vector172
vector172:
  pushl $0
  1017e0:	6a 00                	push   $0x0
  pushl $172
  1017e2:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
  1017e7:	e9 26 f8 ff ff       	jmp    101012 <alltraps>

001017ec <vector173>:
.globl vector173
vector173:
  pushl $0
  1017ec:	6a 00                	push   $0x0
  pushl $173
  1017ee:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
  1017f3:	e9 1a f8 ff ff       	jmp    101012 <alltraps>

001017f8 <vector174>:
.globl vector174
vector174:
  pushl $0
  1017f8:	6a 00                	push   $0x0
  pushl $174
  1017fa:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
  1017ff:	e9 0e f8 ff ff       	jmp    101012 <alltraps>

00101804 <vector175>:
.globl vector175
vector175:
  pushl $0
  101804:	6a 00                	push   $0x0
  pushl $175
  101806:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
  10180b:	e9 02 f8 ff ff       	jmp    101012 <alltraps>

00101810 <vector176>:
.globl vector176
vector176:
  pushl $0
  101810:	6a 00                	push   $0x0
  pushl $176
  101812:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
  101817:	e9 f6 f7 ff ff       	jmp    101012 <alltraps>

0010181c <vector177>:
.globl vector177
vector177:
  pushl $0
  10181c:	6a 00                	push   $0x0
  pushl $177
  10181e:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
  101823:	e9 ea f7 ff ff       	jmp    101012 <alltraps>

00101828 <vector178>:
.globl vector178
vector178:
  pushl $0
  101828:	6a 00                	push   $0x0
  pushl $178
  10182a:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
  10182f:	e9 de f7 ff ff       	jmp    101012 <alltraps>

00101834 <vector179>:
.globl vector179
vector179:
  pushl $0
  101834:	6a 00                	push   $0x0
  pushl $179
  101836:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
  10183b:	e9 d2 f7 ff ff       	jmp    101012 <alltraps>

00101840 <vector180>:
.globl vector180
vector180:
  pushl $0
  101840:	6a 00                	push   $0x0
  pushl $180
  101842:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
  101847:	e9 c6 f7 ff ff       	jmp    101012 <alltraps>

0010184c <vector181>:
.globl vector181
vector181:
  pushl $0
  10184c:	6a 00                	push   $0x0
  pushl $181
  10184e:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
  101853:	e9 ba f7 ff ff       	jmp    101012 <alltraps>

00101858 <vector182>:
.globl vector182
vector182:
  pushl $0
  101858:	6a 00                	push   $0x0
  pushl $182
  10185a:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
  10185f:	e9 ae f7 ff ff       	jmp    101012 <alltraps>

00101864 <vector183>:
.globl vector183
vector183:
  pushl $0
  101864:	6a 00                	push   $0x0
  pushl $183
  101866:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
  10186b:	e9 a2 f7 ff ff       	jmp    101012 <alltraps>

00101870 <vector184>:
.globl vector184
vector184:
  pushl $0
  101870:	6a 00                	push   $0x0
  pushl $184
  101872:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
  101877:	e9 96 f7 ff ff       	jmp    101012 <alltraps>

0010187c <vector185>:
.globl vector185
vector185:
  pushl $0
  10187c:	6a 00                	push   $0x0
  pushl $185
  10187e:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
  101883:	e9 8a f7 ff ff       	jmp    101012 <alltraps>

00101888 <vector186>:
.globl vector186
vector186:
  pushl $0
  101888:	6a 00                	push   $0x0
  pushl $186
  10188a:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
  10188f:	e9 7e f7 ff ff       	jmp    101012 <alltraps>

00101894 <vector187>:
.globl vector187
vector187:
  pushl $0
  101894:	6a 00                	push   $0x0
  pushl $187
  101896:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
  10189b:	e9 72 f7 ff ff       	jmp    101012 <alltraps>

001018a0 <vector188>:
.globl vector188
vector188:
  pushl $0
  1018a0:	6a 00                	push   $0x0
  pushl $188
  1018a2:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
  1018a7:	e9 66 f7 ff ff       	jmp    101012 <alltraps>

001018ac <vector189>:
.globl vector189
vector189:
  pushl $0
  1018ac:	6a 00                	push   $0x0
  pushl $189
  1018ae:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
  1018b3:	e9 5a f7 ff ff       	jmp    101012 <alltraps>

001018b8 <vector190>:
.globl vector190
vector190:
  pushl $0
  1018b8:	6a 00                	push   $0x0
  pushl $190
  1018ba:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
  1018bf:	e9 4e f7 ff ff       	jmp    101012 <alltraps>

001018c4 <vector191>:
.globl vector191
vector191:
  pushl $0
  1018c4:	6a 00                	push   $0x0
  pushl $191
  1018c6:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
  1018cb:	e9 42 f7 ff ff       	jmp    101012 <alltraps>

001018d0 <vector192>:
.globl vector192
vector192:
  pushl $0
  1018d0:	6a 00                	push   $0x0
  pushl $192
  1018d2:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
  1018d7:	e9 36 f7 ff ff       	jmp    101012 <alltraps>

001018dc <vector193>:
.globl vector193
vector193:
  pushl $0
  1018dc:	6a 00                	push   $0x0
  pushl $193
  1018de:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
  1018e3:	e9 2a f7 ff ff       	jmp    101012 <alltraps>

001018e8 <vector194>:
.globl vector194
vector194:
  pushl $0
  1018e8:	6a 00                	push   $0x0
  pushl $194
  1018ea:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
  1018ef:	e9 1e f7 ff ff       	jmp    101012 <alltraps>

001018f4 <vector195>:
.globl vector195
vector195:
  pushl $0
  1018f4:	6a 00                	push   $0x0
  pushl $195
  1018f6:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
  1018fb:	e9 12 f7 ff ff       	jmp    101012 <alltraps>

00101900 <vector196>:
.globl vector196
vector196:
  pushl $0
  101900:	6a 00                	push   $0x0
  pushl $196
  101902:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
  101907:	e9 06 f7 ff ff       	jmp    101012 <alltraps>

0010190c <vector197>:
.globl vector197
vector197:
  pushl $0
  10190c:	6a 00                	push   $0x0
  pushl $197
  10190e:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
  101913:	e9 fa f6 ff ff       	jmp    101012 <alltraps>

00101918 <vector198>:
.globl vector198
vector198:
  pushl $0
  101918:	6a 00                	push   $0x0
  pushl $198
  10191a:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
  10191f:	e9 ee f6 ff ff       	jmp    101012 <alltraps>

00101924 <vector199>:
.globl vector199
vector199:
  pushl $0
  101924:	6a 00                	push   $0x0
  pushl $199
  101926:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
  10192b:	e9 e2 f6 ff ff       	jmp    101012 <alltraps>

00101930 <vector200>:
.globl vector200
vector200:
  pushl $0
  101930:	6a 00                	push   $0x0
  pushl $200
  101932:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
  101937:	e9 d6 f6 ff ff       	jmp    101012 <alltraps>

0010193c <vector201>:
.globl vector201
vector201:
  pushl $0
  10193c:	6a 00                	push   $0x0
  pushl $201
  10193e:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
  101943:	e9 ca f6 ff ff       	jmp    101012 <alltraps>

00101948 <vector202>:
.globl vector202
vector202:
  pushl $0
  101948:	6a 00                	push   $0x0
  pushl $202
  10194a:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
  10194f:	e9 be f6 ff ff       	jmp    101012 <alltraps>

00101954 <vector203>:
.globl vector203
vector203:
  pushl $0
  101954:	6a 00                	push   $0x0
  pushl $203
  101956:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
  10195b:	e9 b2 f6 ff ff       	jmp    101012 <alltraps>

00101960 <vector204>:
.globl vector204
vector204:
  pushl $0
  101960:	6a 00                	push   $0x0
  pushl $204
  101962:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
  101967:	e9 a6 f6 ff ff       	jmp    101012 <alltraps>

0010196c <vector205>:
.globl vector205
vector205:
  pushl $0
  10196c:	6a 00                	push   $0x0
  pushl $205
  10196e:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
  101973:	e9 9a f6 ff ff       	jmp    101012 <alltraps>

00101978 <vector206>:
.globl vector206
vector206:
  pushl $0
  101978:	6a 00                	push   $0x0
  pushl $206
  10197a:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
  10197f:	e9 8e f6 ff ff       	jmp    101012 <alltraps>

00101984 <vector207>:
.globl vector207
vector207:
  pushl $0
  101984:	6a 00                	push   $0x0
  pushl $207
  101986:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
  10198b:	e9 82 f6 ff ff       	jmp    101012 <alltraps>

00101990 <vector208>:
.globl vector208
vector208:
  pushl $0
  101990:	6a 00                	push   $0x0
  pushl $208
  101992:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
  101997:	e9 76 f6 ff ff       	jmp    101012 <alltraps>

0010199c <vector209>:
.globl vector209
vector209:
  pushl $0
  10199c:	6a 00                	push   $0x0
  pushl $209
  10199e:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
  1019a3:	e9 6a f6 ff ff       	jmp    101012 <alltraps>

001019a8 <vector210>:
.globl vector210
vector210:
  pushl $0
  1019a8:	6a 00                	push   $0x0
  pushl $210
  1019aa:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
  1019af:	e9 5e f6 ff ff       	jmp    101012 <alltraps>

001019b4 <vector211>:
.globl vector211
vector211:
  pushl $0
  1019b4:	6a 00                	push   $0x0
  pushl $211
  1019b6:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
  1019bb:	e9 52 f6 ff ff       	jmp    101012 <alltraps>

001019c0 <vector212>:
.globl vector212
vector212:
  pushl $0
  1019c0:	6a 00                	push   $0x0
  pushl $212
  1019c2:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
  1019c7:	e9 46 f6 ff ff       	jmp    101012 <alltraps>

001019cc <vector213>:
.globl vector213
vector213:
  pushl $0
  1019cc:	6a 00                	push   $0x0
  pushl $213
  1019ce:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
  1019d3:	e9 3a f6 ff ff       	jmp    101012 <alltraps>

001019d8 <vector214>:
.globl vector214
vector214:
  pushl $0
  1019d8:	6a 00                	push   $0x0
  pushl $214
  1019da:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
  1019df:	e9 2e f6 ff ff       	jmp    101012 <alltraps>

001019e4 <vector215>:
.globl vector215
vector215:
  pushl $0
  1019e4:	6a 00                	push   $0x0
  pushl $215
  1019e6:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
  1019eb:	e9 22 f6 ff ff       	jmp    101012 <alltraps>

001019f0 <vector216>:
.globl vector216
vector216:
  pushl $0
  1019f0:	6a 00                	push   $0x0
  pushl $216
  1019f2:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
  1019f7:	e9 16 f6 ff ff       	jmp    101012 <alltraps>

001019fc <vector217>:
.globl vector217
vector217:
  pushl $0
  1019fc:	6a 00                	push   $0x0
  pushl $217
  1019fe:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
  101a03:	e9 0a f6 ff ff       	jmp    101012 <alltraps>

00101a08 <vector218>:
.globl vector218
vector218:
  pushl $0
  101a08:	6a 00                	push   $0x0
  pushl $218
  101a0a:	68 da 00 00 00       	push   $0xda
  jmp alltraps
  101a0f:	e9 fe f5 ff ff       	jmp    101012 <alltraps>

00101a14 <vector219>:
.globl vector219
vector219:
  pushl $0
  101a14:	6a 00                	push   $0x0
  pushl $219
  101a16:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
  101a1b:	e9 f2 f5 ff ff       	jmp    101012 <alltraps>

00101a20 <vector220>:
.globl vector220
vector220:
  pushl $0
  101a20:	6a 00                	push   $0x0
  pushl $220
  101a22:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
  101a27:	e9 e6 f5 ff ff       	jmp    101012 <alltraps>

00101a2c <vector221>:
.globl vector221
vector221:
  pushl $0
  101a2c:	6a 00                	push   $0x0
  pushl $221
  101a2e:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
  101a33:	e9 da f5 ff ff       	jmp    101012 <alltraps>

00101a38 <vector222>:
.globl vector222
vector222:
  pushl $0
  101a38:	6a 00                	push   $0x0
  pushl $222
  101a3a:	68 de 00 00 00       	push   $0xde
  jmp alltraps
  101a3f:	e9 ce f5 ff ff       	jmp    101012 <alltraps>

00101a44 <vector223>:
.globl vector223
vector223:
  pushl $0
  101a44:	6a 00                	push   $0x0
  pushl $223
  101a46:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
  101a4b:	e9 c2 f5 ff ff       	jmp    101012 <alltraps>

00101a50 <vector224>:
.globl vector224
vector224:
  pushl $0
  101a50:	6a 00                	push   $0x0
  pushl $224
  101a52:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
  101a57:	e9 b6 f5 ff ff       	jmp    101012 <alltraps>

00101a5c <vector225>:
.globl vector225
vector225:
  pushl $0
  101a5c:	6a 00                	push   $0x0
  pushl $225
  101a5e:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
  101a63:	e9 aa f5 ff ff       	jmp    101012 <alltraps>

00101a68 <vector226>:
.globl vector226
vector226:
  pushl $0
  101a68:	6a 00                	push   $0x0
  pushl $226
  101a6a:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
  101a6f:	e9 9e f5 ff ff       	jmp    101012 <alltraps>

00101a74 <vector227>:
.globl vector227
vector227:
  pushl $0
  101a74:	6a 00                	push   $0x0
  pushl $227
  101a76:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
  101a7b:	e9 92 f5 ff ff       	jmp    101012 <alltraps>

00101a80 <vector228>:
.globl vector228
vector228:
  pushl $0
  101a80:	6a 00                	push   $0x0
  pushl $228
  101a82:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
  101a87:	e9 86 f5 ff ff       	jmp    101012 <alltraps>

00101a8c <vector229>:
.globl vector229
vector229:
  pushl $0
  101a8c:	6a 00                	push   $0x0
  pushl $229
  101a8e:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
  101a93:	e9 7a f5 ff ff       	jmp    101012 <alltraps>

00101a98 <vector230>:
.globl vector230
vector230:
  pushl $0
  101a98:	6a 00                	push   $0x0
  pushl $230
  101a9a:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
  101a9f:	e9 6e f5 ff ff       	jmp    101012 <alltraps>

00101aa4 <vector231>:
.globl vector231
vector231:
  pushl $0
  101aa4:	6a 00                	push   $0x0
  pushl $231
  101aa6:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
  101aab:	e9 62 f5 ff ff       	jmp    101012 <alltraps>

00101ab0 <vector232>:
.globl vector232
vector232:
  pushl $0
  101ab0:	6a 00                	push   $0x0
  pushl $232
  101ab2:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
  101ab7:	e9 56 f5 ff ff       	jmp    101012 <alltraps>

00101abc <vector233>:
.globl vector233
vector233:
  pushl $0
  101abc:	6a 00                	push   $0x0
  pushl $233
  101abe:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
  101ac3:	e9 4a f5 ff ff       	jmp    101012 <alltraps>

00101ac8 <vector234>:
.globl vector234
vector234:
  pushl $0
  101ac8:	6a 00                	push   $0x0
  pushl $234
  101aca:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
  101acf:	e9 3e f5 ff ff       	jmp    101012 <alltraps>

00101ad4 <vector235>:
.globl vector235
vector235:
  pushl $0
  101ad4:	6a 00                	push   $0x0
  pushl $235
  101ad6:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
  101adb:	e9 32 f5 ff ff       	jmp    101012 <alltraps>

00101ae0 <vector236>:
.globl vector236
vector236:
  pushl $0
  101ae0:	6a 00                	push   $0x0
  pushl $236
  101ae2:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
  101ae7:	e9 26 f5 ff ff       	jmp    101012 <alltraps>

00101aec <vector237>:
.globl vector237
vector237:
  pushl $0
  101aec:	6a 00                	push   $0x0
  pushl $237
  101aee:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
  101af3:	e9 1a f5 ff ff       	jmp    101012 <alltraps>

00101af8 <vector238>:
.globl vector238
vector238:
  pushl $0
  101af8:	6a 00                	push   $0x0
  pushl $238
  101afa:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
  101aff:	e9 0e f5 ff ff       	jmp    101012 <alltraps>

00101b04 <vector239>:
.globl vector239
vector239:
  pushl $0
  101b04:	6a 00                	push   $0x0
  pushl $239
  101b06:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
  101b0b:	e9 02 f5 ff ff       	jmp    101012 <alltraps>

00101b10 <vector240>:
.globl vector240
vector240:
  pushl $0
  101b10:	6a 00                	push   $0x0
  pushl $240
  101b12:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
  101b17:	e9 f6 f4 ff ff       	jmp    101012 <alltraps>

00101b1c <vector241>:
.globl vector241
vector241:
  pushl $0
  101b1c:	6a 00                	push   $0x0
  pushl $241
  101b1e:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
  101b23:	e9 ea f4 ff ff       	jmp    101012 <alltraps>

00101b28 <vector242>:
.globl vector242
vector242:
  pushl $0
  101b28:	6a 00                	push   $0x0
  pushl $242
  101b2a:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
  101b2f:	e9 de f4 ff ff       	jmp    101012 <alltraps>

00101b34 <vector243>:
.globl vector243
vector243:
  pushl $0
  101b34:	6a 00                	push   $0x0
  pushl $243
  101b36:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
  101b3b:	e9 d2 f4 ff ff       	jmp    101012 <alltraps>

00101b40 <vector244>:
.globl vector244
vector244:
  pushl $0
  101b40:	6a 00                	push   $0x0
  pushl $244
  101b42:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
  101b47:	e9 c6 f4 ff ff       	jmp    101012 <alltraps>

00101b4c <vector245>:
.globl vector245
vector245:
  pushl $0
  101b4c:	6a 00                	push   $0x0
  pushl $245
  101b4e:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
  101b53:	e9 ba f4 ff ff       	jmp    101012 <alltraps>

00101b58 <vector246>:
.globl vector246
vector246:
  pushl $0
  101b58:	6a 00                	push   $0x0
  pushl $246
  101b5a:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
  101b5f:	e9 ae f4 ff ff       	jmp    101012 <alltraps>

00101b64 <vector247>:
.globl vector247
vector247:
  pushl $0
  101b64:	6a 00                	push   $0x0
  pushl $247
  101b66:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
  101b6b:	e9 a2 f4 ff ff       	jmp    101012 <alltraps>

00101b70 <vector248>:
.globl vector248
vector248:
  pushl $0
  101b70:	6a 00                	push   $0x0
  pushl $248
  101b72:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
  101b77:	e9 96 f4 ff ff       	jmp    101012 <alltraps>

00101b7c <vector249>:
.globl vector249
vector249:
  pushl $0
  101b7c:	6a 00                	push   $0x0
  pushl $249
  101b7e:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
  101b83:	e9 8a f4 ff ff       	jmp    101012 <alltraps>

00101b88 <vector250>:
.globl vector250
vector250:
  pushl $0
  101b88:	6a 00                	push   $0x0
  pushl $250
  101b8a:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
  101b8f:	e9 7e f4 ff ff       	jmp    101012 <alltraps>

00101b94 <vector251>:
.globl vector251
vector251:
  pushl $0
  101b94:	6a 00                	push   $0x0
  pushl $251
  101b96:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
  101b9b:	e9 72 f4 ff ff       	jmp    101012 <alltraps>

00101ba0 <vector252>:
.globl vector252
vector252:
  pushl $0
  101ba0:	6a 00                	push   $0x0
  pushl $252
  101ba2:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
  101ba7:	e9 66 f4 ff ff       	jmp    101012 <alltraps>

00101bac <vector253>:
.globl vector253
vector253:
  pushl $0
  101bac:	6a 00                	push   $0x0
  pushl $253
  101bae:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
  101bb3:	e9 5a f4 ff ff       	jmp    101012 <alltraps>

00101bb8 <vector254>:
.globl vector254
vector254:
  pushl $0
  101bb8:	6a 00                	push   $0x0
  pushl $254
  101bba:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
  101bbf:	e9 4e f4 ff ff       	jmp    101012 <alltraps>

00101bc4 <vector255>:
.globl vector255
vector255:
  pushl $0
  101bc4:	6a 00                	push   $0x0
  pushl $255
  101bc6:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
  101bcb:	e9 42 f4 ff ff       	jmp    101012 <alltraps>
