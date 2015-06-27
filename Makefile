BOARD_TAG    = uno
ARDUINO_LIBS = Wire MPL3115A2 HTU21D

.PHONY: up
up:
	scp build-uno/Weather_Station.hex $(ARDUINO_HOST):
	-ssh $(ARDUINO_HOST) screen -X -S weather quit
	ssh $(ARDUINO_HOST) avrdude -F -V -c arduino -p ATMEGA328P -P /dev/ttyACM0 -b 115200 -U flash:w:Weather_Station.hex
	ssh $(ARDUINO_HOST) screen -S weather -d -m /dev/ttyACM0 115200

include Arduino-Makefile/Arduino.mk
