cp HXLINK.COM HXLINKP.COM

# patch banner, this breaks the application and i dont know why
# the program counter ends up executing code at 0000:0000, no idea what happens here
#printf "Alles ist erlaubt !!!!!" | dd of=HXLINKP.COM bs=1 seek=$(printf "%d" 0x74b6) conv=notrunc

# patch thunk to "kein dongle"
printf "\xc3" | dd of=HXLINKP.COM bs=1 seek=$(printf "%d" 0x38dc) conv=notrunc
# patch thunk to "falscher dongle"
printf "\xc3" | dd of=HXLINKP.COM bs=1 seek=$(printf "%d" 0x38df) conv=notrunc
# patch jump into endless loop around "falscher dongle" call
printf "\x90\x90" | dd of=HXLINKP.COM bs=1 seek=$(printf "%d" 0x6795) conv=notrunc

# patch "peripherietreiber" to "bildschirmtreiber"
# this seems to disable the floppy emulation
#printf "\x90\x90\x90\x90\x90" | dd of=HXLINKP.COM bs=1 seek=$(printf "%d" 0x84ca) conv=notrunc

# patch "programm inkonsistent"
printf "\x90\x90" | dd of=HXLINKP.COM bs=1 seek=$(printf "%d" 0x840a) conv=notrunc

diff <(xxd HXLINK.COM) <(xxd HXLINKP.COM)
