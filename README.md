# ppc_hw
helloworld powerpc-app on powerpc 405 qemu, used for powerpc exercises

## Setup
Currently (until qemu 5.0 is released) you need to build your version of qemu due to a bug in qemu.
You also need to dwnload a powerpc cross compiler - I recommend downloading it from [musl.cc](https://musl.cc).

Change the paths in `Makefile` to match your compiler and qemu binaries.

## Useful Commands
`make` - compile stuff

`make run` - run the OS