`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2018 10:53:25 AM
// Design Name: 
// Module Name: ID_Stalling_Unit
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

module ID_Stalling_Unit(
    input EX_MemRead,
    input EX_RegWrite,
    input EX_WBSrc,
    input MEM_MemRead,
    input [6:0] ID_Opcode,
    input [4:0] EX_rd,
    input [4:0] MEM_rd,
    input [4:0] ID_rs1,
    input [4:0] ID_rs2,
    output reg PC_Write,
    output reg IF_ID_Write,
    output reg Ctrl_0_sig,
    output reg branch_predictor_enable
    );
    
    always @(EX_MemRead,EX_RegWrite,EX_WBSrc,MEM_MemRead,ID_Opcode,EX_rd,MEM_rd,ID_rs1,ID_rs2)begin
        
        if(EX_MemRead == 1'b1 && EX_rd!=0 && !(ID_Opcode==`RV32_STORE && ID_rs2==EX_rd && EX_rd!=ID_rs1) && (EX_rd==ID_rs1 ||EX_rd==ID_rs2))begin
            PC_Write <= 1'b0;
            IF_ID_Write <= 1'b0;
            Ctrl_0_sig <= 1'b0;
            branch_predictor_enable <= 1'b0;
        end
        else if(ID_Opcode==`RV32_BRANCH && EX_RegWrite== 1'b1 && EX_WBSrc==1'b0 && EX_rd!=0 && (EX_rd==ID_rs1 ||EX_rd==ID_rs2))begin // r-type,imm-type -branch
            PC_Write <= 1'b0;
            IF_ID_Write <= 1'b0;
            Ctrl_0_sig <= 1'b0; 
            branch_predictor_enable <= 1'b0;
        end
        else if(ID_Opcode==`RV32_BRANCH && MEM_MemRead==1'b1 && MEM_rd!=0 && (MEM_rd==ID_rs1 ||MEM_rd==ID_rs2))begin // load-branch Hazard
            PC_Write <= 1'b0;
            IF_ID_Write <= 1'b0;
            Ctrl_0_sig <= 1'b0;   
            branch_predictor_enable <= 1'b0;
        end
        else begin
            PC_Write <= 1'b1;
            IF_ID_Write <= 1'b1;
            Ctrl_0_sig <= 1'b1; 
            branch_predictor_enable <= 1'b1;            
        end
              
    end
    
endmodule
