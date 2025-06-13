# HXLink 2.0
<img src="https://raw.githubusercontent.com/nerdprojects/hxlink/main/screenshot.png"/>

An old german DOS software that emulates the external screen and floppy adapters for the Epson HX-20.

Basically a limited version of what these modern tools do:

- https://norbertkehrer.github.io/flashx20.html
- https://www.mh-aerotools.de/hp/hx-20/

## Files
- floppy.dd -> Disk image of the original floppy disk
- floppy.jpg -> Photo of the original floppy disk
- patch.sh -> Shell script that patches the original software and creates HXLINKP.COM
- HXLINK.COM -> Original version of the software
- HXLINK.SYS -> Config file for HXLink
- HXLINKP.COM -> Patched version of the software

## Run
I used DOSBox to run the software. I mapped my host serial port into the DOSBox with following setting:

    serial1=directserial realport:ttyS0

You need to connect the HX-20 to your PC over the 5-pin serial cable, not the 8-pin RS-232 cable.

### Screen
Enter BASIC on the HX-20 and use `SCREEN1,0` to switch the text screen to external.

Now you can type on the HX-20 and see the characters appear on the DOS software.

Unfortunately, it seems as the graphic modes are not supported, only text mode.

### Floppy
Set the DIP switch 4 on the HX-20 to on.

The HX-20 will then try to load a modified version of BASIC over the serial port, when you enter BASIC on the HX-20.
Instead of `EPSON BASIC` it will read `DISK BASIC`.

You also need to configure `HXLINK.SYS` correctly, so you have a valid "A:" drive. For example create a folder named "HX20" in "C:" and configure `HXLINK.SYS` accordingly:

    DriveA = C:\HX20

When everything is fine, you can use `FILES`, `SAVE`, `LOAD` in HX-20 BASIC and it should save and load over the serial port instead to tape.

## Patching
The original software requires a dongle to be installed, which I don't have.
Therefore I created a patch for the software, that disables these dongle checks.

The application seems to be compiled with Turbo Pascal 3.0. Together with the COM format, the binary results in having a rather *unique* structure.

