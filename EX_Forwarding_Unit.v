`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2018 10:15:24 AM
// Design Name: 
// Module Name: EX_Forwarding_Unit
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

module EX_Forwarding_Unit(
    input MEM_RegWrite,
    input WB_RegWrite,
    input EX_MemWrite,
    input [4:0] MEM_rd,
    input [4:0] WB_rd,
    input [4:0] EX_rs1,
    input [4:0] EX_rs2,
    input [2:0] EX_ALUOp,
    output reg [1:0] EX_fwd_A,
    output reg [1:0] EX_fwd_B,
    output reg [1:0] EX_fwd_C

    );
    
    always @(MEM_RegWrite, WB_RegWrite, MEM_rd, WB_rd, EX_rs1, EX_rs2) begin
    
        if(MEM_RegWrite == 1 && MEM_rd !=0 && MEM_rd == EX_rs1) /*EX-Hazard*/
            EX_fwd_A <= 2'b01;
        else if(WB_RegWrite==1 && WB_rd !=0 && WB_rd == EX_rs1) /*MEM-Hazard*/
            EX_fwd_A <= 2'b10;
        else
            EX_fwd_A <= 2'b00;

        if(MEM_RegWrite == 1 && MEM_rd !=0 && MEM_rd == EX_rs2 && EX_ALUOp == `ALU_OP_0) /*EX-Hazard*/
            EX_fwd_B <= 2'b01;
        else if(WB_RegWrite==1 && WB_rd !=0 && WB_rd == EX_rs2 && EX_ALUOp == `ALU_OP_0) /*MEM-Hazard*/
            EX_fwd_B <= 2'b10;
        else
            EX_fwd_B <= 2'b00;

        if(MEM_RegWrite == 1 && EX_MemWrite==1'b1 && MEM_rd !=0 && MEM_rd == EX_rs2) /*EX-Hazard-sw*/
            EX_fwd_C <= 2'b01;
        else if(WB_RegWrite==1 && EX_MemWrite==1'b1 && WB_rd !=0 && WB_rd == EX_rs2) /*MEM-Hazard-sw*/
            EX_fwd_C <= 2'b10;
        else
            EX_fwd_C <= 2'b00;
            
            
        
    end
   
endmodule
