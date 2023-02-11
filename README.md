# Binary Search Module

I implemented a module that would perform binary search on a sorted data. This module takes preexisting data from the ROM (Vivado's Block memory), searches for a data in that ROM and returns the address of the data. Written in Verilog, simulated and synthesized using Xilinx Vivado.

The main module can be found in the file **Binary_Search.v**.

The initializing data of the ROM can be found in the file **ROM_init.coe**.

```
memory_initialization_radix=10;
memory_initialization_vector=10,12,16,39,50,87,102,131,134,151,164,190,201,205,217,239;
```

The simulation result can be found in the file **simulation.png**.

![simulation](https://user-images.githubusercontent.com/92133811/218251058-13f5ccc7-c8e8-464b-b027-a57034046390.png)
