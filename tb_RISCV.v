`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2018 09:42:41 AM
// Design Name: 
// Module Name: tb_RISCV
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "RV32_Opcodes.vh"

module tb_RISCV();
     reg clk, reset;
     
     RISC_V_Datapath rv_uut(clk, reset);
     
     initial begin
        reset = 1'b0;
        #5 reset = 1'b1;
     end
     
     initial begin
        clk = 1'b0;
        repeat(150) #1 clk = ~clk;
        $finish; 
     end

 endmodule