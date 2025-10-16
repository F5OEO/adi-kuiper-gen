# Zukaneoper
[![Zukaneoper](https://github.com/F5OEO/adi-kuiper-gen/actions/workflows/kuiper2_0-build.yml/badge.svg?branch=main)](https://github.com/F5OEO/adi-kuiper-gen/actions/workflows/kuiper2_0-build.yml)

Latest binary Release : [![GitHub Release](https://img.shields.io/github/release/F5OEO/adi-kuiper-gen.svg)](https://github.com/F5OEO/adi-kuiper-gen/releases/latest)  [![Github Releases](https://img.shields.io/github/downloads/F5OEO/adi-kuiper-gen/total.svg)](https://github.com/F5OEO/adi-kuiper-gen/releases/latest)

This is a fork of https://github.com/analogdevicesinc/adi-kuiper-gen which use https://github.com/F5OEO/tezuka_fw firmware based.

## Introduction

This distribution is intended to run on a pluto-clone with SD card adapter (plutoplus,antsdre200,libresdr,fishball).

For now, only ethernet connection has been tested (no usb).

It turns your SDR running like a Raspberry with all softwares installed and running inside . No need to install softwares on your PC.

Graphical interface through your browser.

## Installation

### Download release

### Flash on SD card

- Use 16 Gbytes minimum SD card
- Use a sd flasher program, for example https://etcher.balena.io/


### Customize for your board
 - copy files of your folder board to /boot
![novnc](/doc/cpyboot.png)

### Choose Zukaneoper or Tezuka
- Edit uEnv.txt and add line mode_rootfs=kuiper

## Using it

### Get your IP

### Spectrum with maia-sdr : port 8000
![Maia](/doc/maiaspectrum.png)

### Connect to desktop : port 6080/vnc.html
![novnc](/doc/novnc.png)

Password is analog 

![novnc](/doc/novnc-pass.png)

![novnc](/doc/novnc-desktop.png)

## Softwares onboard

### gnu-radio with boken-gui

### rtl433

### adsb

### python3 and maia

### gqrx

### luaradio

## Compatible boards
### Hardware

|      |   Pluto Revb |   Pluto Revc |Pluto Revc clone|   Pluto+ |   Pluto+ (3.3v) | Antsdr e200 | LibreSdr/ZynqSdr |PynqSDR|Signal SDR Pro|Fishball|
|---   |:-:|:-: |:-:|:-:|:-: |:-:|:-:|:-:|:-:|:-:|
|Manufacturer       |Analog Device             |Analog Device     |  PIAASDR  |Justin Peng/Howard Su| clone            |AntSDR            |? |regymm| signalens |hamgeek|
|Common price       |Replaced by Rev C             |280Euros     |170Euros |replaced by 3.3v ?    |234Euros            |430Euros           |190Euros |239Euros |900 Euros|150 Euros|
|RF Chipset       |AD9363             |AD9363     |AD9363 |AD9363    |AD9363            |AD9363            |AD9363 |AD9363 |AD9361|AD9363 |
|USB OTG      |Yes             |Yes     |Yes |Yes    |Yes            |No            |yes |yes |yes/USB3 |yes |
|USB debug      |No             |Yes|Yes     |No    |No            |Yes            |yes |yes |yes |yes |
|FPGA      |7010             |7010  |7010     |7010    |7010            |7020            |7020 |7020 |7020 |7010/20 |
|GigaEthernet  |no             |no|no     |yes    |yes            |yes            |yes |yes |yes |yes |
|RX/TX Channels   |1             |2 (pigtail->sma) |2 (pigtail->sma)    |2    |2(pigtail->sma)         |2(pigtail->sma)            |2 |1 |2 |2 |
|Ref Clock   |TCXO 40MHZ 20ppm   |TCXO 40MHZ 20ppm |TCXO 40MHZ 20ppm ?   |TCXO 40MHZ 0.5ppm    |VCTCXO 40MHZ 0.5ppm         |  VCTCXO 40MHZ 2ppm          |VCTCXO 40MHZ 2ppm          |TXCO 1ppm|TXCO 1ppm|
|Ext Clock   | No : soldering needed    |Yes |Yes but BUG    |Yes by jumper   |Yes         |  Yes          | Yes |Yes |yes and gpsdo| Yes 
|Max Transmit Power|6dbm   |6dbm |6dbm    |    |        |10dbm          |? |? |10dbm|10dbm|
|Flash protection|yes   |yes |yes    |no    |no        |no          |? |? |?|no|
|SD Boot|no   |no |no    |yes    |yes       |yes          |yes |yes |yes |yes |
|Max Rx Bandwidth USB |8Mhz  |8Mhz|8Mhz    | 8Mhz |  8Mhz      |x          | | | | |
|Max Rx Bandwidth IP/USB rndis |7.5Mhz/6.25   |7.5Mhz/6.257.5Mhz/6.25    | 7.25Mhz   | 7.25Mhz        |   x       | | | | |
|Max Rx Bandwidth IP/USB ncm |4.25Mhz   |4.25Mhz|4.25Mhz    |  NA  |  NA      |   x       | | |||
|Max Rx Bandwidth IP/USB ecm | 7.5Mhz  |7.5Mhz  |7.5Mhz   |  NA  |   NA     |   x       | | |||
|Max Rx Bandwidth IP (otg adapter) |3.25Mhz   |3.25Mhz|3.25Mhz    | NA   | NA       | x         | | |||
|Max Rx Bandwidth IP Gbe CS16 |x   |x|x    | 15Mhz   | 15Mhz       |          | |||
|Max Rx Bandwidth IP Gbe CS8 |x   |x|x    | 30Mhz   | 30Mhz       |          | |||


# Software

|      |   Pluto Revb |   Pluto Revc |Pluto Revc clone|   Pluto+ |   Pluto+ Rev2 | Antsdr e200 | LibreSdr/ZynqSdr |PynqSDR|Signal SDR Pro|Fishball|
|---       |:-:           |:-:           |:-:   |:-:       |:-:            |:-:          |:-:|:-:|:-:|:-:|
|Official Firmware base   |0.39           |0.39|0.37           |0.33       |0.33            |0.37          |||||
|Latest Firmware date   |Oct 15, 2024            |Sep 20, 2023           |Jun 18, 2021       |           |          |||||
|Linux Kernel version   |6.1           |6.1          |5.10  |5.4       |5.4            |          |||||
|[Tezuka Firmware support](https://github.com/F5OEO/tezuka_fw)  |yes           |yes          |yes  |yes      |yes            |yes          |yes|No|In progress|Yes|






