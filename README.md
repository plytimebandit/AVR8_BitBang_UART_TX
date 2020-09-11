# AVR8_BitBang_UART_TX

This is a fork of [MarcelMG/AVR8_BitBang_UART_TX](https://github.com/MarcelMG/AVR8_BitBang_UART_TX).

## Introduction

Software ("bit-bang") UART Transmitter (8 data bits, 1 stop bit, no parity) for [ATtiny13A](https://www.microchip.com/wwwproducts/en/ATtiny13A).
This can easily be ported to other AVR8 µC's or might even work without changes on many of them.

The baud rate is calculated as follows:

    BAUD = F_CPU / ( TIMER0_PRESCALER * (OCR0A + 1)

So we can modify the prescaler and/or the OCR0A value to achieve a certain baud rate.

In this example I am using the internal 9.6 MHz oscillator as clock source, so F_CPU=9600000 and a baud rate of 9600.

The program can be compiled with avr-gcc and the avr-libc libraries using `make`.


## Setup

I'm using a ATtiny13A which has been initialized using the Arduino IDE and the [MicroCore](https://mcudude.github.io/MicroCore/package_MCUdude_MicroCore_index.json) board configuration.

The µC has been connected to the [Arduino UNO Rev3](https://store.arduino.cc/arduino-uno-rev3) like this:

    Arduino  |  ATtiny13A
    P13     <-> PB2 (Pin 7)
    P12     <-> PB1 (Pin 6)
    P11     <-> PB0 (Pin 5)
    P10     <-> RESET (Pin 1)
    Vcc     <-> Vcc (Pin 8)
    GND     <-> GND (Pin 4)


See [Tauno Erik](https://create.arduino.cc/projecthub/taunoerik)s project for more insights and even a [schematic](https://create.arduino.cc/projecthub/taunoerik/programming-attiny13-with-arduino-uno-07beba). Also the [Arduino web site](https://www.arduino.cc/en/Tutorial/ArduinoISP) shows schematics and information about the ArduinoISP which is necessary for the next step.

To get the code up and running upload the "ArduinoISP" sketch to the Arduino and execute these afterwards:

```shell
make        # compile
make fuse   # set fuses (just once)
make flash  # upload code
```

Since the ArduinoISP seems to interfere the UART communication I used an [FTDI/FT232RL adapter](https://www.google.com/search?q=FT232RL+FTDI+USB+to+TTL+serial+adapter) to check the results. Alternatively people advice to upload the "BareMinimum" sketch to the Arduino.

The µC is connected as following to the FT232RL:

    FT232RL  |  ATtiny13A
    RX      <-> PB0 (Pin 5)
    Vcc     <-> Vcc (Pin 8)
    GND     <-> GND (Pin 4)


For visualisation of the output I used [CuteCom](https://help.ubuntu.com/community/Cutecom) which can be installed via Unix package manager. Settings are 9600 baud rate using 8N1 bits.


## Contributions

This project has been forked from [MarcelMG/AVR8_BitBang_UART_TX](https://github.com/MarcelMG/AVR8_BitBang_UART_TX) and enriched by [lpodkalicki/attiny13-software-uart-library](https://github.com/lpodkalicki/attiny13-software-uart-library/blob/master/example/Makefile). Thanks also goes to [MCUdude/MicroCore](https://github.com/MCUdude/MicroCore).
