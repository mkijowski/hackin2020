### Keypad notes

Keypad appears to show up in the VM as the following devices:
* `/dev/ttyS0`
* `/dev/ttyS1`
* `/dev/ttyS2`
* `/dev/ttyS3`
* `/dev/usb/hiddev0`

To get the flash files, reset the keypad by jumping the second and third wires
from the top right (with the cable facing upward).  Upon release the bootloader
will be accessible for ~5seconds.  The bootloader is accessible on our host
system via `/dev/ttyACM0`.  Watch for it by running the following: 
* `watch -n .1 "ls /dev | grep ACM"`

When the device shows up, immediately attempt to retrieve the flash contents.
We used the following commands:

* `avrdude -p m32u4 -c avr109 -P /dev/ttyACM0 -U flash:r:flash.hex:i`
* `avrdude -p m32u4 -c avr109 -P /dev/ttyACM0 -U flash:r:flash.bin:r`

To generate the `flash.xxd` file, run `xxd flash.bin > flash.xxd`

To generate the `flash.asm`, run `avr-objdump -D flash.hex -m avr > flash.asm`

Currently trying to determine the hex location of the flag that the
initialization routine copies from the flash.  Some interesting things were
happening with ghidra and `flash.bin`.  Maybe investigate the `flash.bin` with
radare2?

We got a hint last night: `Something interesting happens in the Reset function,`

