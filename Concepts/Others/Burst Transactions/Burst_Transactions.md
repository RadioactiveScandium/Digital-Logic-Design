# Burst Transactions

## Introduction
Assume there is a memory with a certain depth and some driver writes into and reads from it. Now, during the conventional write operation, the address and data to be written are required inputs to the memory. Similarly, for read operation, the memory requires the address as input from which the data is supposed to be read. 

Now, what if during the write operation, there was some way to give only the data and a starting address and rely on some logic to take care of the subsequent addresses, while only giving the data to be written as input ? For read operations, this approach would become even simpler as only a starting address is necessary. 

This is where the concept of burst transactions comes into the picture. It refers to the fact that multiple back-to-back transactions can be carried out in a single go without providing all the inputs which would be otherwise deemed necessary.

## Explanation using waveforms 

To understand this better, let’s break this down into a number of combinations, considering the same example of memory as above : 

  * **Write with no burst**
  * **Write with burst**
  * **Read with no burst**
  * **Read with burst**

### 1. Write with no burst : 
This is the most conventional way of writing the data into any memory. On each clock cycle, a new data arrives with a new address and the write operation is carried out accordingly. The signal `burst_en` always being 0 signifies that this is a non-burst write.

![Write with no burst](https://github.com/RadioactiveScandium/Digital-Logic-Design/blob/main/Concepts/Others/Burst%20Transactions/Images/WR_with_no_burst.png)

### 2. Write with burst : 
This is where things change a bit. The last address encountered when `burst_en == 0` is A4. Now, on the next clock edge, when this signal goes to a logic 1, the system no longer requires an updated input address. Rather, it records A4 as a “pseudo start address” and increments the address autonomously as long as the signal `burst_en` is held to logic high.



### 3. Read with no burst : 
Conventional way of reading the data from any memory. On each clock cycle, a new address arrives and the read operation is carried out accordingly. The signal `burst_en` always being 0 signifies that this is a non-burst read.

### 4. Read with burst : 
Same as write burst, the last address encountered when `burst_en == 0` is A4. Now, on the next clock edge, when this signal goes to a logic 1, the system no longer requires an updated input address. It starts incrementing the last input address automatically and keeps doing so as long as the signal `burst_en` is held to logic high. On each clock cycle, a fresh data read from the memory is driven onto the `data_out` bus. 