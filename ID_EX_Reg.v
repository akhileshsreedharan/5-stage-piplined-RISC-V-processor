`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2018 04:31:49 PM
// Design Name: 
// Module Name: ID_EX_Reg
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
`include "RV32_Opcodes.vh"

module ID_EX_Reg(
    input clk,
    input reset,
    input ID_WBSrc,
    input ID_RegWrite,
    input ID_MemWrite,
    input ID_MemRead,
    input [2:0] ID_ALUOp,
    input [1:0] ID_ALUSrc,
    input [31:0] MUX_ID_Read_data_1,
    input [31:0] MUX_ID_Read_data_2,
    input [4:0] ID_rs2_shamnt,
    input [6:0] ID_Funct7_R,
    input [3:0] ID_Funct3_R,
    input [4:0] ID_rs1,
    input [4:0] ID_rd,
    input [31:0] ID_Imm_out,
    input [31:0] ID_PC_new,
    output reg EX_WBSrc,
    output reg EX_RegWrite,
    output reg EX_MemWrite,
    output reg EX_MemRead,
    output reg [2:0] EX_ALUOp,
    output reg [1:0] EX_ALUSrc,
    output reg [31:0] EX_Read_data_1,
    output reg [31:0] EX_Read_data_2,
    output reg [4:0] EX_rs2,
    output reg [4:0] EX_shamnt_in,
    output reg [6:0] EX_Funct7_R,
    output reg [3:0] EX_Funct3_R,
    output reg [4:0] EX_rs1,
    output reg [4:0] EX_rd,
    output reg [31:0] EX_Imm_out,
    output reg [31:0] EX_PC_New
    );
    
    always @(posedge clk, negedge reset) begin
        
        if(reset == 1'b0) begin
            EX_WBSrc <= 1'b0;
            EX_RegWrite <= 1'b0;
            EX_MemWrite <= 1'b0;
            EX_MemRead <= 1'b0;
            EX_ALUOp <= `ALU_OP_7;
            EX_ALUSrc <= 2'b00;
            EX_Read_data_1 <= `ZERO_VECTOR_32;
            EX_Read_data_2 <= `ZERO_VECTOR_32;
            EX_rs2 <= `ZERO_VECTOR_5;
            EX_shamnt_in <= `ZERO_VECTOR_5;
            EX_Funct7_R <= `RV32_FUNCT7_RTYPE_INVALID;
            EX_Funct3_R <= `RV32_FUNCT3_RTYPE_INVALID;
            EX_rs1 <= `ZERO_VECTOR_5;
            EX_rd <= `ZERO_VECTOR_5;
            EX_Imm_out <= `ZERO_VECTOR_32;
            EX_PC_New <= `ZERO_VECTOR_32;      
        end
        
        else begin
        
            if(clk == 1'b1) begin
            
                EX_WBSrc <= ID_WBSrc;
                EX_RegWrite <= ID_RegWrite;
                EX_MemWrite <= ID_MemWrite;
                EX_MemRead <= ID_MemRead;
                EX_ALUOp <= ID_ALUOp;
                EX_ALUSrc <= ID_ALUSrc;
                EX_Read_data_1 <= MUX_ID_Read_data_1;
                EX_Read_data_2 <= MUX_ID_Read_data_2;
                EX_rs2 <= ID_rs2_shamnt;
                EX_shamnt_in <= ID_rs2_shamnt;
                EX_Funct7_R <= ID_Funct7_R;
                EX_Funct3_R <= ID_Funct3_R;
                EX_rs1 <= ID_rs1;
                EX_rd <= ID_rd;
                EX_Imm_out <= ID_Imm_out;
                EX_PC_New <= ID_PC_new; 
                                
            end
            
        end
    
    end
    
endmodule
