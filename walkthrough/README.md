Here is a walkthrough of all challenges solved during HackIN2020 by the WSU team.
I will try to get solutions to the problems we did not solve as well and note whether the 
solutions was obtained during the event or after.

#### Reading the rules
*Read the rules*

Yes, there was a flag in the rules.  Apparently those are important ;)
**Answer:** hackin{s4n1ty_ch3ck}

---

#### Taking Inventory
##### Part I
*Identify the chipset the keypad uses.*

Again, just need to look at it.

**Answer:** `atmega32u4`

---

#### Basic Research
##### Part I
*We need to gain more information about the microcontroller on the device. How many general purpose registers are there?*

Simply looks this up on the spec sheet for the controller.
http://ww1.microchip.com/downloads/en/devicedoc/atmel-7766-8-bit-avr-atmega16u4-32u4_datasheet.pdf

**Answer:** `32`

##### Part II
*What are the address range for the general purpose registers?*

Also in the controller spec sheet.
**Answer:** `0x0000 - 0x001F`


##### Part III
*What instruction should typically be at the reset vector?*

The first vector in an interrupt table is the "Reset Vector" and is usually a `JMP` or `RJMP` instruction which jumps to the start of the main program.
**Answer:** `JMP`

---

#### What is it Running?
##### Part I
*Dump the flash contents of the keypad in intel hex.  The flag is the MD5 hash of the file.*

This is tricky since being able to access the bootloader took some time and debugging on our end.  The hardest two parts were identifying what `avrdude` command options to use, specifically for the programmer type (`-c` option), and the interface to use (`-P` option).  As it turns out, all of the usb `/dev/tty` options were wrong, and the device is only reachable via `avrdude` for a few seconds after a reset.  Jumping the reset pin (can be identified from the datasheet) and monitoring all changes to devices in `/dev` showed us that a `/dev/ttyACM0` device is available briefly after reset.  Combining that with some internet searching that states most of these types of chips use the `-c avr109` programmer and we had the following command:

`sudo avrdude -p m32u4 -c avr109 -P /dev/ttyACM0 -U flash:r:"flash.hex":i`

To get the md5 of that file simply `md5sum ./flash.hex`

**Answer:** `10e1ebfdcaea388888757ff1b84a5579`

##### Part II
*Dump the EEPROM contents of the keypad in intel hex.  The flag is the MD5 hash of the file.*

avrdude command

**Answer:** `b99b6ae4a4b47506c5f0ada409e20b66`

---

##### What are the Pins?
*To better understand the keypad device, we need to know which pins the key matrices connect to.  Pins will be in AVR format (omit the P) and will need to be entered as comma separated values (CSV).  Example Flag: pin1, pin2, pin3, pin4, pin5*

This can be traced back via a continuity tester on the board.
**Answer:** 

 
##### What's in the Dumped File?
*Reverse engineer the file and find the flag.*

**Answer:** `flag{d4ta_3xf1l_r3v3rs3_3ng1n33r1ng}`

##### Where was the Flag Found?
*The initialization routine copies a block of memory from the program memory (flash) to SRAM. Where is the hex location of the flag that the routine copies from the flash?\r\n\r\nThe flag is not the address of the flag itself, but rather the data block that's being copied.\r\n\r\nThe flag is the hex location, ex. (0xdeadbeef)*

**Answer:** 

##### Find the Kernel Module
*Identify the kernel module handling the keypad in the .ova image.*

**Answer:** `HackIN_HID`

---

#### Find the Kernel of Truth

##### Part I
*Reverse engineer the kernel module handling the keypad and find out what it executes.*

**Answer:** /bin/explorer.exe

##### Part II
*We need to find out if any other kernel modules are loaded. Find out if another kernel module is loaded by the HackIN_HID module; if so, what is it?*

**Answer:** `netfilter_lkm`

---

#### netfilter

##### Remote Access
*We noticed that the system reacts on its own sometimes. Find out if there is remote access and if so what is its address?*

**Answer:** `175.129.12.94`


##### Control Flow
*Now that we know there's remote access, we need to understand how the kernel module recognizes it. Reverse engineer the mechanics of the remote access and outline the control flow.*

**Answer:** 


##### USB
*There is something weird with the USB behavior on the machine and we think it's coming from a kernel module. Reverse engineer any USB related functionality from the previously identified kernel modules.*

**Answer:** 


##### Structs in the Kernel
*We need all the information from the struct that sets up the netfilter functionality. Identify and reconstruct the struct for netfilter.*

**Answer:** 

---

#### Userland

##### What is Running on the System?
*Is there a file that autoexecutes when a device is plugged in? Is there a device manager or rules that provides this functionality? Provide the absolute path, including filename.*

**Answer:** `/etc/udev/rules.d/99-maypad.rules`

##### What is Being Executed?
*Find the executable of the file that executes the user program. Provide the absolute path, including filename.*

**Answer:** 



##### What are the Artifacts?
*The program must leave behind clues that it's running. Provide the absolute path, including filename.*

**Answer:** `/tmp/maypad.pid`



##### Code? Secret Activation Keys? Backdoor?
*Figure out the correct sequence of keys in order to execute the program's hidden modes.Submit the sequence as the answer.*

**Answer:** Konami Code: `Up, Up, Down, Down, Left, Right, Left, Right, B, A`

##### Emergency Meeting!
*Figure out the correct sequence of keys in order to trigger the \"kill switch\".*

**Answer:** `A, A, A`



##### Outbound Communication?
*How does the keypad communicate with the python server? The flag is the domain.*

**Answer:** `evil.ru.site`

---

### Py
##### HTTP Where?
*Identify the executable/binary that runs the HTTP server. A flag marks the spot!*

**Answer:** `HackIN{using_Strings_FTW!}`

##### We're Gonna Need a Bigger (Data) Boat
*There appears to be a lot of data in the binary. We should examine it closely and see what we find.*

**Answer:** `HackIN{cann0t_5ee_+he_f0res+f0r+he_+ree5}`

##### Whoah, That was a Lot of Snakes! 
*We need to find out what this script does. There is probably some hidden data (flag) somewhere in here. Get to it!*

**Answer:** `HackIN{|\\/|a+ry05hka}`

---

#### Server
##### HTTP Dir Busting
*We need to determine some of the functionality of the server. A co-worker started writing an application to test server endpoints/directories, but quickly noticed some server \"funny business\" and went home early. Please finish writing the script and report back with a list of valid server endpoints (URLs).\r\n\r\nPlease see the included python file and wordlist in the challenges folder.*

**Answer:** 

##### HTTP Traffic Exploration
*Explore server traffic for any lazy programming.*

**Answer:** `HackIN{GE0RG3_B00LE_would_be_very_upset}`



##### They're My Logs and I Want Them Now!
*Explore the server and see if any data can be extracted. We know logs are hiding somewhere...*

**Answer:** `HackIN{it'5_ju5t_Vigenere_c1ph3r_w1+h_3xtra_5t3ps}`

---

#### RISC-V
##### Down the Rabbit Hole...
*The RISC-V executable has a hidden passphrase that a very clever and persistent reverse engineer may be able to uncover. Find and provide the passphrase.*

**Answer:** `Lucky7h1r733n`

##### ...and through the Looking Glass!
*The test team couldn't get anything to happen with the executable beyond getting a usage function printout. It says two command line arguments are required, but nothing happens. How many arguments are required?*

**Answer:** `3`

##### What's the Password?
*Get to know your Game Mentors! Hit up Slack and ask a game mentor for the password to the zip file!*

**Answer:** `HackIN2020_HwuRrCtF%En2!eKT`

