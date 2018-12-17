`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2018 10:21:13 AM
// Design Name: 
// Module Name: Jump_add_selector
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

module Jump_add_selector(
    input [31:0] Branch_add_in,
    input [31:0] Jump_add_in,
    input [6:0] Opcode,
    output reg [31:0] Branch_Target
    );
    
    always @(Branch_add_in, Jump_add_in, Opcode) begin
        case(Opcode) 
            `RV32_BRANCH: Branch_Target = Branch_add_in;
            `RV32_JAL   : Branch_Target = Jump_add_in;
            default    : Branch_Target = 32'h00000000;
        endcase
    end
    
endmodule
