`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2018 05:30:29 PM
// Design Name: 
// Module Name: MEM_WB_reg
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
`include "RV32_Constants.vh"

module MEM_WB_reg(
    input clk,
    input reset,
    input MEM_WBSrc,
    input MEM_RegWrite,
    input [31:0] MEM_LW_Read_data,
    input [31:0] MEM_ALU_result,
    input [4:0] MEM_rd,
    output reg WB_WBSrc,
    output reg WB_RegWrite,
    output reg [31:0] WB_LW_Read_data,
    output reg [31:0] WB_ALU_Result,
    output reg [4:0] WB_rd
    );
    
    always @(posedge clk, negedge reset) begin
        
        if(reset == 1'b0) begin
            WB_WBSrc <= 1'b0;
            WB_RegWrite <= 1'b0;
            WB_LW_Read_data <= `ZERO_VECTOR_32; 
            WB_ALU_Result <= `ZERO_VECTOR_32;
            WB_rd <= `ZERO_VECTOR_5;
        end
        
        else begin
            if(clk == 1'b1) begin
                WB_WBSrc <= MEM_WBSrc;
                WB_RegWrite <= MEM_RegWrite;
                WB_LW_Read_data <= MEM_LW_Read_data;
                WB_ALU_Result <= MEM_ALU_result;
               WB_rd <= MEM_rd;
            end
        end
    
    end
    
endmodule
