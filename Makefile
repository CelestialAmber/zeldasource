

ifeq ($(wildcard zelda_base.nes),)
  $(error An original Legend of Zelda ROM is required to build this. Rename the file to zelda_base.nes and place it in this directory.)
endif

CA65 := tools/cc65/bin/ca65
LD65 := tools/cc65/bin/ld65

ROM := zelda.nes
OBJECTS := zelda.o songs.o bank0.o bank1.o bank2.o bank3.o bank4.o bank5.o bank6.o bank7.o

all: $(ROM) verify

verify: $(ROM) checksum.md5
	@md5sum -c checksum.md5

clean:
	rm -rf $(ROM) $(OBJECTS) memmap.txt
	
%.o: %.asm
	$(CA65) $^ -o $@

$(ROM): $(OBJECTS)
	$(LD65) -C zelda.cfg -m memmap.txt $^ -o $@
