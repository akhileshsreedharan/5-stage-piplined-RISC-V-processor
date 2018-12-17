`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2018 10:38:40 AM
// Design Name: 
// Module Name: ID_Forwarding_Unit
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

module ID_Forwarding_Unit(
    input MEM_WBSrc,
    input MEM_RegWrite,
    input WB_RegWrite,
    input [6:0] ID_Opcode,
    input [4:0] MEM_rd,
    input [4:0] WB_rd,
    input [4:0] ID_rs1,
    input [4:0] ID_rs2,
    output reg [1:0] ID_fwd_rs1,
    output reg [1:0] ID_fwd_rs2
    );
    
    always @(MEM_WBSrc, MEM_RegWrite, WB_RegWrite, ID_Opcode, MEM_rd, WB_rd, ID_rs1, ID_rs2)begin
        
        if(MEM_WBSrc==1'b0 && MEM_RegWrite==1'b1 && ID_Opcode==`RV32_BRANCH && MEM_rd!=0 && ID_rs1==MEM_rd)
            ID_fwd_rs1 <= 2'b01;
        else if(WB_RegWrite==1'b1 && ID_Opcode==`RV32_BRANCH && WB_rd!=0 && ID_rs1==WB_rd)
            ID_fwd_rs1 <= 2'b10;
        else
            ID_fwd_rs1 <= 2'b00;
 
        if(MEM_WBSrc==1'b0 && MEM_RegWrite==1'b1 && ID_Opcode==`RV32_BRANCH && MEM_rd!=0 && ID_rs2==MEM_rd)
            ID_fwd_rs2 <= 2'b01;
        else if(WB_RegWrite==1'b1 && ID_Opcode==`RV32_BRANCH && WB_rd!=0 && ID_rs2==WB_rd)
            ID_fwd_rs2 <= 2'b10;
        else
            ID_fwd_rs2<= 2'b00;
                
    end
    
endmodule
