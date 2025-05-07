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

![Write with burst](https://github.com/RadioactiveScandium/Digital-Logic-Design/blob/main/Concepts/Others/Burst%20Transactions/Images/Write_with_burst.png)

### 3. Read with no burst : 
Conventional way of reading the data from any memory. On each clock cycle, a new address arrives and the read operation is carried out accordingly. The signal `burst_en` always being 0 signifies that this is a non-burst read.

![Read with no burst](https://github.com/RadioactiveScandium/Digital-Logic-Design/blob/main/Concepts/Others/Burst%20Transactions/Images/Read_with_no_burst.png)

### 4. Read with burst : 
Same as write burst, the last address encountered when `burst_en == 0` is A4. Now, on the next clock edge, when this signal goes to a logic 1, the system no longer requires an updated input address. It starts incrementing the last input address automatically and keeps doing so as long as the signal `burst_en` is held to logic high. On each clock cycle, a fresh data read from the memory is driven onto the `data_out` bus.

![Read with burst](https://github.com/RadioactiveScandium/Digital-Logic-Design/blob/main/Concepts/Others/Burst%20Transactions/Images/Read_with_burst.png)

## Burst Length
Burst length refers to the number of data transfers within a single burst transaction. It essentially specifies how many sequential pieces of data will be sent based on a single address, increasing efficiency by allowing for multiple transfers without needing to repeatedly send the address.
This number can be a parameter and can be configured accordingly based on the requirements. There is a limit on the burst length based on the interface under discussion. For example, in AXI3 the burst length is limited to 16, while for AXI4 it is 256.

## Burst Size
Burst size refers to the total amount of data transferred within a single burst transaction. So in a burst, if each transfer is worth k bytes and there are q number of transfers (i.e., burst length) , then,


                            Burst Size = k * q   (in bytes)


For AXI2, the burst size is capped at 128B, while for AXI5 it is 4KB.

## Advantages, Disadvantages and Applications

Burst mode significantly reduces the time spent on transaction setup and teardown, resulting in a higher data transfer rate. In a nutshell, this technique helps to increase the throughput by allowing a device to complete a known sequence of data transfers without multiple arbitration cycles. As an example, a memory read in burst mode doesn’t need to wait for an updated address input on each active clock edge to complete the operation - the internal logic can handle that.

For devices like DRAM with high initial access latency, the addresses may take some to arrive before the read or write operations are executed. However, if the burst mode is enabled, then with a particular known address as startpoint, multiple read/write transactions can be carried out at once. This improvement in access time makes this a favorable technique for **optimized memory access.** 

Owing to the benefits listed above, this technique is extensively used in memory accesses (especially DRAM), high speed interfaces like AXI, in encryption algorithms (such as AES), etc.

On the contrary to having its benefits, there is one big drawback of the burst mode transactions. During a burst transfer, the device initiating the burst effectively controls the bus. This can lead to contention with other devices that might also want to access the bus, potentially slowing down other operations. 

Also, when dealing with memories, the addresses can only be swept through sequentially, which can sometimes lead to performance degradation if the addresses of interest are scattered at non-uniform intervals. On top of this, extra control logic is needed, which can lead to increased area and power footprint. 

Designers need to understand all the pros and cons of this technique before bringing it into action in their production. With the right set of trade-offs, the concept of burst transactions can be a highly effective strategy.

## Case Study - accessing SRAM in burst mode

A simple example to demonstrate the concept of burst transactions can be understood as follows. Assume a simple SRAM module which is supposed to be accessed in both burst and non-burst (cycle-stealing or continuous) modes. Below is a small micro-architectural diagram for this block : 

![Case Study](https://github.com/RadioactiveScandium/Digital-Logic-Design/blob/main/Concepts/Others/Burst%20Transactions/Images/CASE_STUDY.png)

From the top interface level, the SRAM receives all the control and data signals barring the address. There is a separate module called **Address Modifier**, which, based on the nature of transactions dictated by the `burst_en` signal, generates the correct address and passes it on to the SRAM. The rest is the usual functionality of an SRAM - either write or read based on the combination of `wren` and `rden` signals.

## Implementation and Results

The entire RTL and testbench suite for the demonstration of this concept is available here : 

* [Implementation Collaterals](https://github.com/RadioactiveScandium/Digital-Logic-Design/tree/main/Implementation%20and%20Results/Burst%20Transactions)

## Appendices

1. Wavedrom source code :

```
{signal: [
  {name: 'rstn', wave: '0.1..............'},
  {name: 'clk', wave: 'p................'},
  {name: 'rd_en', wave: '0.1..............'},  
  //{name: 'burst_en', wave: '0................'},
  {name: 'burst_en', wave: '0.....1......0...'},
  {name: 'addr_in', wave: '0.3454.......5345', data: ["A1", "A2", "A3", "A4", "A12", "A13", "A14", "A15" ]},
  {name: 'data_out', wave: '0.222222222222222', data: ["D1", "D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9", "D10", "D11", "D12", "D13", "D14", "D15", "D16"]},
]}
```