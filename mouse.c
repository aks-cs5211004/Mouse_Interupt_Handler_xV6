#include "types.h"
#include "defs.h"
#include "x86.h"
#include "mouse.h"
#include "traps.h"

// Wait until the mouse controller is ready for us to send a packet
void 
mousewait_send(void) 
{
    // Implement your code here
    uint time=100000;
    while(--time){
        if((inb(0x64) & 2)==0)
            return;
    }
}

// Wait until the mouse controller has data for us to receive
void 
mousewait_recv(void) 
{
    // Implement your code here
    uint time=100000;
    while(--time){
        if((inb(0x64) & 1)==1)
            return;
    }
}

// Send a one-byte command to the mouse controller, and wait for it
// to be properly acknowledged
void 
mousecmd(uchar cmd) 
{
    // Implement your code here
    mousewait_send();
    outb(0x64, 0xD4);
    mousewait_send();
    outb(0x60,cmd);
    uchar ack = inb(0x60);
    if(ack==0xFA){
        ;
    }


    return;
}

void
mouseinit(void)
{
    // Implement your code here
    mousewait_send();
    outb(0x64, 0xA8); //Enable the mouse boy
    mousewait_send(); 
    outb(0x64,0x20); //Hey I want the status byte man!
    mousewait_recv();
    uint status= (inb(0x60) | 2);
    mousewait_send(); 
    outb(0x64,0x60);
    mousewait_send();
    outb(0x60,status);


    // 4
    mousecmd(0xF6);
    // 5
    mousecmd(0xF4);

    // 6
    ioapicenable(IRQ_MOUSE, 0);


    return;
}

void
mouseintr(void)
{
    // Implement your code here
    int c=0;
    while((inb(0x64) & 1)==1){

        uchar data1 = inb(0x60);

        if(c%3==0){
            if((data1 & 1) == 1){
            cprintf("LEFT\n");
            }
            else if (((data1 & 2)>>1)==1){
                cprintf("RIGHT\n");
            }
            else if (((data1 & 4)>>2) ==1){
                cprintf("MID\n");
            }
        }
        c++;
        
        
    }



    return;
}