# Optimal Page Replacement Implementation Using VHDL
An implementation of the Optimal Page Replacement algorithm, used for page replacement to decide which page needs to be replaced when new page comes in.

### Theory
[Source][1]

When a program starts execution, one or more pages are brought to the main memory and the page table is responsible to indicate their positions. When the CPU needs a particular page for execution and that page is not in main (physical) memory (still in the secondary memory), this situation is called _page fault_. When the page fault occurs, the execution of the present program is suspended until the required page is brought into main memory from secondary memory. The required page replaces an existing page in the main memory, when it is brought into main memory. Thus, when a page fault occurs,  a page replacement is needed to select one of the existing pages to make room for the required page. There are several page replacement algorithms such as _FIFO (First-in First-out)_, _LRU (Least Recently Used)_ and _optimal page replacement_ algorithm available.

The _optimal algorithm_ generally gives the lowest page faults of all algorithms and its criterion is “replace a page that will not be used for the longest period of time.” This algorithm is also *difficult to implement*, because it requires future knowledge about page references.

An algorithm is evaluated by running it on a particular string of memory references and computing the number of page faults. The string of memory references is called a _reference string_. We can generate reference strings randomly or we can trace a given system and record the address of each memory reference. For example, if we trace a particular executing program and obtain the following address sequence:

0202, 0103, 0232, 0324, 0123, 0344, 0106, 0287, 0344, 0106, 0287, 0345, 0654, 0102, 0203, 0234, 0205, 0104, 0134, 0123, 0145, 0156, 0167

If size of each page is 100 bytes, the above address sequence is reduced to the reference string:
2, 1, 2, 3, 1, 3, 1, 2, 3, 6, 1, 2, 1


### The Code

The VHDL program uses optimal page replacement technique. The size of the page frame is set to 3, and the reference string has 14 inputs (addresses), which are preset to:
0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 3, 2, 4, 1

A custom input for the reference string can also be provided through the simulation.

The result of the OPR implementation requires the entire string to be made available. In this program, each step of the algorithm is saved to a file called `opr.dat` as an output.

The algorithm for the given sample is explained through the following table:
    
|    REFERENCE STRING →| 0 | 1 | 2 | 3 | 0 | 1 | 2 | 3 | 0 | 1 | 3 | 2 | 4 | 1 |
|----------------------|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|           **FRAME ↓**|   |   |   |   |   |   |   |   |   |   |   |   |   |   |
|                    0 | 0 | 0 | 0 | 0 |   |   | 0 |   |   | 1 |   |   | 1 |   |
|                    1 |   | 1 | 1 | 1 |   |   | 2 |   |   | 2 |   |   | 2 |   |
|                    2 |   |   | 2 | 3 |   |   | 3 |   |   | 3 |   |   | 4 |   |
|           Page Fault | y | y | y | y | n | n | y | n | n | y | n | n | y | n | 

From this table, we observe that 7 page faults occur, out of 14 references. Thus, the page fault rate is = 7/14 = 50%.

### Instructions

The project was tested on ModelSim - Intel FGPA Starter Edition 10.5b, and the instructions are for the same.
1. Run `ModelSim - Intel FPGA Starter Edition 10.5b (Quartus Prime 17.1)`
2. Go to `File` -> `Open` and open `VHDLLabProject.vhdl`.
3. In the project tab, right click `VHDLLabProject.vhdl` and click on `Edit`, or alternatively, just double click on it, to inspect the code.
4. Right click `VHDLLabProject.vhdl` and click on `Compile` -> `Compile Selected` to compile. (Ignore the warnings.)
5. Under the library tab, locate `opr`, right click on it and select `Simulate`.
6. In the simulation (`Wave` tab), right click on `opr` and select `Add to` -> `Wave` -> `All items in region`.
7. Add your own values, or just use the pre-defined values for `referenceString`. From the toolbar, click on `Run`.
8. Result is stored in `opr.dat` in the same directory.

### Page Replacement Algorithms
https://www.geeksforgeeks.org/page-replacement-algorithms-in-operating-systems/


[1]: <https://books.google.co.in/books/about/COMP_ORG_ARCHITECTURE_WBUT_JUNE_2011.html?id=pMua2g1YDm8C> "COMP ORG & ARCHITECTURE - WBUT JUNE 2011"
