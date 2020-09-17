---
title: An Exploration of Hardware and Software Array Sorting
author:
    - Anders Mæhlum Halvorsen
    - Rahmat Mozafari
    - Ole Martin Ruud
    - Øzlem Tuzkaya
institute: University of South-Eastern Norway
date: 21.09.2020
lang: en-US
bibliography: paper.bib
header-includes: |
    \usepackage[toc,page]{appendix}
---

# Vision statement

Explore and implement three different sorting algorithms in software, hardware and as an integrated circuit (Intellectual Property (IP)), furthermore compare the different implementations with regards to efficiency, performance and flexibility (in particular hardware vs software tradeoffs).

# Abstract

TODO write abstract

# Introduction

TODO write introduction

# Methods
---------- new below ----------

Our goal for this paper was to explore and implement three different sorting algorithms in software, hardware and as an integrated circuit (Intellectual Property (IP)), furthermore compare the different implementations with regards to efficiency, performance and flexibility (in particular hardware vs software tradeoffs).

For all of our algorithms, we followed the same steps. We started by creating an FSMD architecture of the overall algorithm we were currently building; we did this to get an overview of what components and signals were needed. Based on the FSMD architecture created, we then designed the ASMD chart, this was done to easily convert the chart into code when implementing, while also having a good overview of the states the algorithm needed.

After finishing making all of the necessary charts, we then started to implement the sorting algorithm into Vivado. To make the code as reusable as possible we made a new file for each of our components. We also made the last two algorithms generic, such that the inputs and sizes could be adjusted by the user. 

To confirm that our sorting algorithms worked as expected we created a test bench for the project and analysed the outputs to see whether we achieved to create the algorithm or not.

The implementation of software in contrast to the hardware was a much more straight forward process. We used Vitis to connect our Zybo board to our computer and created a C file that would be used to implement the algorithm. For testing, we used the built-in Vitis console.

For our first algorithm, we made an effort to implement an IP implementation. Troubleshooting and implementation turned out to be an immensely time-consuming process. Seeing that the implementation of the IP would not have had a significant impact on our vision or result for our paper, we chose to exclude it.

---------- new above ----------

---------- move or delete below ----------

For our first sorting algorithm we decided to implement selection sort. The selection sort algorithm sorts an array by repeatedly finding the smallest element and swapping it with the first non-sorted element. If the first non-sorted element is the smallest, it will be “swapped” with itself. After swapping, we sort the remaining part of the array in similar fashion until the entire array is sorted. 

We implemented the algorithm in three different ways, Hardware, Software and as an Intellectual Property (IP). We challenged ourselves by starting with an ASMD chart before creating the FSMD architecture. We soon realised that this approach made the process more complex seeing that we were not sure what signals were needed; resulting in a change of strategy. Our new approach was to begin with the FSMD architecture and then creating the ASMD chart based on the FSMD architecture. After finding a satisfactory solution to the FSMD and ASMD, we implemented the hardware by taking in account the FSMD architecture. When implementing the Hardware solution, we wanted the design to be as reusable and adaptable as possible, consequently we created different design files for the multiplexers, comparator, ram, register and the control. As for the counter, we chose to create a generic counter file to be used for all of the counters. These files were then connected using a top-level file. To test our implementation we made a simulation file to verify that the waveforms behaved as expected.

After verifying that the hardware implementation worked as expected, we created a new project and started implementing the software in Vivado. Implementing the algorithm in software was quite simple as it is fairly straightforward to represent it using C. To verify that our implementation executed as expected, we used the terminal to print out an array before and after running the algorithm. 

The IP implementation, unlike the hardware and software implementation, was not as straightforward. We tried to implement it, but soon bumped into some problems with generating the IP block.

For our second algorithm we chose to implement a linear cell sorting algorithm based on the article linked below: [https://hackaday.com/2016/01/20/a-linear-time-sorting-algorithm-for-fpgas/](https://hackaday.com/2016/01/20/a-linear-time-sorting-algorithm-for-fpgas/)

The sorting algorithm uses cells / registers to sort the incoming data. It has only four rules: \




1. If a cell is empty, it will only be populated if the cell above is full.
2. If a cell is full, the cell data will be replaced if both the incoming data is less than the stored data, and the cell above is not pushing its data.
3. If the cell above the current cell is pushing out its stored data, then the current cell has to replace the current data with the cell data above.
4. If a cell is occupied and accepts new data either from the above cell or from the incoming data), it must push out the current data.

After learning from our previous mistake by starting with the ASMD chart instead of the FSMD architecture; we started by implementing the FSMD architecture for the cell first. After finding a satisfactory solution we moved on to the ASMD chart of the cell then made the top level FSMD architecture and the top level ASMD chart.

After going through our architectures / chars and verifying that it should work as expected, we started implementing the hardware implementation in Vivado. Similar to the previous sorting algorithm, the process was quite straightforward. We made sure to make the files as reusable as possible. Though, unlike the previous implementation, we made this implementation generic; meaning that we could define the length and size of the array in the top level file, instead of hard-coding the length inside the components.

---------- move or delete above ---------- 



# Results

In this section we will discuss the results we gathered throughout our research with regards to the different algorithms.


## Selection sort

The selection sort is the most straightforward sorting algorithm. Our implementation will identify the minimum element in the array and swap it with the element in the primary position. Then it will identify the second position minimum element and swap it with the element in the second location, and it will continue executing this until the entire array is sorted. It has an O(n^2) time complexity, and this is inefficient on large arrays. The input array divides into two subarrays, a sorted subarray of elements built up from top to bottom, and the remaining unsorted elements occupy the rest of the array.

See appendix \ref{} for a visual explanation of the algorithm.


### Hardware Implementation

We have created a generic counter and register in the hardware implementation, which we want to reuse as much code as possible. The comparing counter is set to 1 as a default value, and the output of the ram will be the first element in the array when we run the program. We temporarily store this index value of this element in a register and increment the index counter to compare the elements to find the smallest element in the array. Again we temporarily store the index and the value of the smallest element in registers, then we swap those elements till the array is sorted. We have removed the ram from the design file into the test bench file, which we wanted an external ram instead of an internal ram.

TODO add image of synth report

Synthesized report (Shows the power consumption) 


TODO add image of elaborated schematic

Schematic of Elaborated design



TODO add image of synthesized report

Summary of synthesized report


The picture below shows an unsorted array in the ram when the program starts. 


TODO add images of waveform diagrams


### Software Implementation

The implementation of the algorithm in software was quick to write, and certainly inspired by the hardware implementation. To keep it consistent, we decided to stick with similar names for the different components (in particular index_counter and comparing_tindex_counter). This means that it should be easy to compare the implementations. We have tested the software implementation on Zybo board and worked perfectly.

In listing \ref{} you can see the code.

TODO add code from file as listing


### IP Implementation

In the IP-implementation, we followed the “Vivado Quick Start Tutorial” and made some necessary changes in some files. We declared some output ports and port mapped those in the “selection_sort_IP_v1_0.vhd”. Next, we made a component declaration and created some signals for inputs and outputs in the “selection_sort_IP_v1_0_S00_AXI.vhd” file. The VHDL description files created for the hardware implementation of the selection sort algorithm we copied those files into the IP directory and created a new AXI4 Peripheral for IP.
 Comment
After this, we created a new block design to integrate our IP, added, and customized the “ZYNQ7 Processing System”. Our next step was that we added “selection_sort_IP_v1.0” into our design and created HDL Wrapper. Further, we added the Sort Controller and the block memory IP blocks into our design. The block memory generator is the previously explained external RAM, while the Sort Controller enables us to inspect the memory after it has been sorted (simply enabling our software running on the ZYNQ processor to read the memory through AXI). 


TODO add image of IP block diagram

The IP block diagram including the selection sort block, sort controller and memory

Finally, after putting together the different IP blocks, we generated a bitstream to see if there was any error and also we needed to export hardware design  to the Vitis IDE. In Vitis IDE we first created a project platform for the (XSA) file extension which exported from the Vivado and generated multiple domains. We built the project and created a new application project for the software application to test our IP implementation.

To communicate with the sort controller, enabling us to read the sorted memory, we need to talk through the AXI interface. This is done using some special functions provided by the platform. By reading slave register 2 of the sort controller, we can tell if the sorting is done, as the first bit represents the sort_done variable. Further by then repeatedly reading slave register 1, we will get the contents of the memory block, as the sort controller continuously updates the RAM address and reads the data into the slave register. 


```c
include "xparameters.h"
include "xuartps_hw.h"

int main(){
	xil_printf("Start selection sort\n\n\r");

	xil_printf("Sorting");
	u32 slave_reg_2;
	do {
		slave_reg_2 = Xil_In32(XPAR_SORT_CONTROLLER_0_S00_AXI_BASEADDR + 8);
		xil_printf(".");
	} while ((slave_reg_2 & 0x1) == 0);
	xil_printf("\n\r");

	xil_printf("Printing\n\r");
	u32 slave_reg_1;
	do {
		slave_reg_2 = Xil_In32(XPAR_SORT_CONTROLLER_0_S00_AXI_BASEADDR + 8);
		slave_reg_1 = Xil_In32(XPAR_SORT_CONTROLLER_0_S00_AXI_BASEADDR + 4);
		xil_printf("%lx ", slave_reg_1);
	} while ((slave_reg_2 & 0x1) == 1);

	return 0;
}
```



## Linear cell sort

Linear cell sort [@linear-cell-sort] receives data once per clock cycle and sorts the data while it is being clocked in serially; that is why this algorithm is called linear cell sort. Hence it can sort an array in O(N) time complexity. After we have clocked in our data, the array will be sorted immediately and ready to clock out. The solution provides the sorting in parallel. 

Since we decided to make the algorithm generic, it will let the user decide the array's size and length. Figure 2.1 (Top FSMD architecture), the number of cells will be the same as the array size. New incoming data will be placed to the cell from top to bottom with increasing size. So when all cells are empty, the first element will automatically take the first place. Second incoming data will be compared with the first element; if it is smaller than the first element, then the first element will be moved to the second cell, and the new data will be placed to the first cell. Third incoming data will be compared with the other cells; if the incoming data is smaller than the first cell, we have a full and pushed. The first cell's data will be pushed to the second cell, and the data in the second cell will be pushed to the third cell, and the new incoming data will be placed to the first cell. The sorting algorithm will continue like this until the whole array is sorted. 

### Hardware implementation

The implementation of linear cell sort algorithms was more complicated than Selection sort.  We needed to draw multi FSMD and ASMD charts to implement this in hardware. Since this algorithm uses cells and to implement this in hardware we needed to draw a FSMD and ASMD chart for this to control each cell. Then we draw another FSMD and ASMD chart to control all cells and plus other components. In our implementation we neither use RAM or ROM.

TODO add image of schematic

Schematic of elaborated design


TODO add image of synth report

Synthesized report of On-Chip Power


TODO add image of utilization report

Utilization synthesized report


### Software implementation

Since this algorithm is parallel by nature, there are some tradeoffs to be made when implementing it in software. As we only have a single core to work with, we have chosen to simply transform it into a sequential algorithm. This means that instead of O(N) time complexity, it will be O(N²) time complexity (as we have to iterate through every cell on every insertion). As such, we chose to handle the algorithm by having a ROM and a pointer to the “incoming” input, and Instead of using cells, we chose to use an array to be simulated as multiple cells.

The implementation was tested on the Zybo board, and it returned the expected outcome.


TODO add image of vitis serial terminal

Result from inspecting the serial monitor


TODO add code from file

## Odd-even sort



### Hardware implementation

### Software implementation

# Discussion

TODO

# Conclusion

TODO

# References {-}


::: {#refs}
:::

\clearpage
\appendix

# Links

[https://hackaday.com/2016/01/20/a-linear-time-sorting-algorithm-for-fpgas/](https://hackaday.com/2016/01/20/a-linear-time-sorting-algorithm-for-fpgas/)

[https://en.wikipedia.org/wiki/Batcher_odd%E2%80%93even_mergesort](https://en.wikipedia.org/wiki/Batcher_odd%E2%80%93even_mergesort)
