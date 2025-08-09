MCU=atmega328p
F_CPU=16000000
PORT=/dev/ttyACM0
PROGRAMMER=arduino

main.hex: main.S
	avr-gcc -mmcu=$(MCU) -DF_CPU=$(F_CPU) -o main.elf main.S
	avr-objcopy -O ihex -R .eeprom main.elf main.hex

flash: main.hex
	avrdude -p $(MCU) -c $(PROGRAMMER) -P $(PORT) -b 115200 -U flash:w:main.hex:i