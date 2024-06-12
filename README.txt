# Logic-Design
Digital logic implementation and verification through Verilog/SV

This repository is meant for logic design and verification, starting from the simplest of blocks such as a half adder, all the way to FSMs.

The repository has been divided into two main directories : 
    * RTL codes -> Contains the functional codes for all the blocks
    * Verification -> Contains the test suite for simulating the behaviour of each of the blocks in the RTL codes directory

Both the above folders have uniform structure. System verilog has been used in all the cases for coding. 2012 SV Manual has been uploaded as well for quick lookup.


OPENS :

13th April 2023 - Solve the DCD issue and introduce bypass feature in Parametric Clock Divider. Also, explore how the param can be converted to an interface input (to support dynamic divide by value change without design resynth).