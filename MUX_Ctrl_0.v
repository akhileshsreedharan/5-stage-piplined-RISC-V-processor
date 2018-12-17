`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2018 03:53:46 PM
// Design Name: 
// Module Name: MUX_Ctrl_0
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

module MUX_Ctrl_0(
    input [1:0] Branch_outcome_in,
    input [1:0] PCSrc_in,
    input WBSrc_in,
    input RegWrite_in,
    input MemWrite_in,
    input MemRead_in,
    input [2:0] ALUOp_in,
    input [1:0] ALUSrc_in,
    input Ctrl_0_Sig,
    output reg [1:0] Branch_outcome_out,
    output reg [1:0] PCSrc_out,
    output reg WBSrc_out,
    output reg RegWrite_out,
    output reg MemWrite_out,
    output reg MemRead_out,
    output reg [2:0] ALUOp_out,
    output reg [1:0] ALUSrc_out
    );
    
    always @(Branch_outcome_in,PCSrc_in,WBSrc_in,RegWrite_in,MemWrite_in,MemRead_in,ALUOp_in,ALUSrc_in,Ctrl_0_Sig) begin
        
        case(Ctrl_0_Sig)
            
            1'b0: begin  
                {Branch_outcome_out, PCSrc_out, WBSrc_out, RegWrite_out, MemWrite_out, MemRead_out, ALUOp_out, ALUSrc_out} <= `INVALID_VECTOR; 
            end
            
            1'b1: begin
                Branch_outcome_out <= Branch_outcome_in;
                PCSrc_out <= PCSrc_in;
                WBSrc_out <= WBSrc_in;
                RegWrite_out <= RegWrite_in;
                MemWrite_out <= MemWrite_in;
                MemRead_out <= MemRead_in;
                ALUOp_out <= ALUOp_in;
                ALUSrc_out <= ALUSrc_in;
            end
        
        endcase
    
    end
    
endmodule
