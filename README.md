# msp432p4111

## used version 3.40.01.02
[https://www.ti.com/tool/download/SIMPLELINK-MSP432-SDK/3.40.01.02](https://www.ti.com/tool/download/SIMPLELINK-MSP432-SDK/3.40.01.02)

## used version 12.5.0
[https://www.ti.com/tool/CCSTUDIO#downloads](https://www.ti.com/tool/CCSTUDIO#downloads)


## formatting
linux: `./format.sh`

windows: `powershell -ExecutionPolicy Bypass -File .\format.ps1`


## install

### packages
```
sudo apt-get install build-essential gcc make gcc-arm-none-eabi openocd gconf2
sudo pacman -S base-devel gcc make arm-none-eabi-gcc openocd dconf arm-none-eabi-newlib
```

### SDK
[https://www.ti.com/tool/download/SIMPLELINK-MSP432-SDK/3.40.01.02](https://www.ti.com/tool/download/SIMPLELINK-MSP432-SDK/3.40.01.02)
Select a dir to download to, I choose `/home/brighton/Documents/SDK/msp432p4111/ti`

### Link
In your `~/.bashrc` add:
```
export MSP432P4111_HEADERS=/path/to/headers/
# for example
export MSP432P4111_HEADERS=/home/brighton/Documents/SDK/ti/msp432p4111/simplelink_msp432p4_sdk_3_40_01_02/
```
Then source: `source ~/.bashrc`

### Connect
```
screen <device> <baud rate>
screen /dev/ttyUSB0 115200
```
or use cool term
```
sudo pacman -S paru
paru coolterm
```

