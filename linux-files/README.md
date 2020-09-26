### Linux files 

Below are some of the more interesting files and their locations in the VM.

#### Kernel Modules

* `/lib/modules/4.18.0-193.14.2.el8_2.x86_64/HackIN_HID.ko`
  Maybe look in here for the secret key code for unlocking additional
  functionality?
* `/lib/modules/4.18.0-193.14.2.el8_2.x86_64/netfilter_lkm.ko`
  My guess is the hidden functionality does stuff here too?

#### Binary files and scripts
* `/usr/bin/connected.sh` (runs when keypad is connected)
* `/usr/bin/exfilpad` (called by `connected.sh`)

`kernel-asm` contains files presumable made by reversing the kernel files.  Talk
to Ryan for more about these.

