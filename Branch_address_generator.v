`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2018 09:49:40 AM
// Design Name: 
// Module Name: Branch_address_generator
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


module Branch_address_generator(
    input [6:0] Op_code,
    input [24:0] Inst_in,
    input [31:0] PC_current,
    output [31:0] Branch_Target
    );
    
    wire [31:0] Branch_offset,Branch_offset_shifted;
    
    Branch_offset_generator branch_offset_generator(Inst_in,Op_code,Branch_offset);
    Left_Shift_1 shifter(Branch_offset,Branch_offset_shifted);
    Adder add(Branch_offset_shifted,PC_current,Branch_Target);
    
endmodule
