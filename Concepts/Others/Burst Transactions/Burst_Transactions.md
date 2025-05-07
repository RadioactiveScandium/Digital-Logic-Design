Introduction
Assume there is a memory with a certain depth and some driver writes into and reads from it. Now, during the conventional write operation, the address and data to be written are required inputs to the memory. Similarly, for read operation, the memory requires the address as input from which the data is supposed to be read. 

Now, what if during the write operation, there was some way to give only the data and a starting address and rely on some logic to take care of the subsequent addresses, while only giving the data to be written as input ? For read operations, this approach would become even simpler as only a starting address is necessary. 

This is where the concept of burst transactions comes into the picture. It refers to the fact that multiple back-to-back transactions can be carried out in a single go without providing all the inputs which would be otherwise deemed necessary.

Explanation using waveforms 

To understand this better, let’s break this down into a number of combinations, considering the same example of memory as above : 

   → Write with no burst
   → Write with burst
   → Read with no burst
   → Read with burst

Write with no burst : This is the most conventional way of writing the data into any memory. On each clock cycle, a new data arrives with a new address and the write operation is carried out accordingly. The signal burst_en always being 0 signifies that this is a non-burst write.

- ![Screenshot of a comment on a GitHub issue showing an image, added in the Markdown, of an Octocat smiling and raising a tentacle.](RadioactiveScandium/Digital-Logic-Design/Concepts/Others/Burst Transactions/Images/WR_with_no_burst.png)