`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2018 05:18:36 PM
// Design Name: 
// Module Name: EX_MEM_Reg
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

module EX_MEM_Reg(
    input clk,
    input reset,
    input EX_WBSrc,
    input EX_RegWrite,
    input EX_MemWrite,
    input EX_MemRead,
    input [31:0] EX_ALU_Result,
    input [31:0] EX_Read_data_2,
    input [4:0] EX_rd,
    input [4:0] EX_rs2,
    output reg MEM_WBSrc,
    output reg MEM_RegWrite,
    output reg MEM_MemWrite,
    output reg MEM_MemRead,
    output reg [31:0] MEM_ALU_Result,
    output reg [31:0] MEM_Read_data_2,
    output reg [4:0] MEM_rd,
    output reg [4:0] MEM_rs2
    );
    
    always @(posedge clk, negedge reset) begin
    
        if(reset == 1'b0) begin
            MEM_WBSrc <= 1'b0;
            MEM_RegWrite <= 1'b0;
            MEM_MemWrite <= 1'b0;
            MEM_MemRead <= 1'b0;
            MEM_ALU_Result <= `ZERO_VECTOR_32;
            MEM_Read_data_2 <= `ZERO_VECTOR_32;
            MEM_rd <= `ZERO_VECTOR_5;   
            MEM_rs2 <= `ZERO_VECTOR_5;        
        end
        
        else begin
            if(clk == 1'b1) begin
                MEM_WBSrc <= EX_WBSrc;
                MEM_RegWrite <= EX_RegWrite;
                MEM_MemWrite <= EX_MemWrite;
                MEM_MemRead <= EX_MemRead;
                MEM_ALU_Result <= EX_ALU_Result;
                MEM_Read_data_2 <= EX_Read_data_2;
                MEM_rd <= EX_rd;  
                MEM_rs2 <= EX_rs2;         
            end
        end
    
    end
    
    
    
endmodule
