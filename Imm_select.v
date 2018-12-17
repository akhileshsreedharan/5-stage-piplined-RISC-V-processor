`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2018 11:58:37 AM
// Design Name: 
// Module Name: Imm_select
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

module Imm_select(
    input [11:0] LW_ADDI_Imm_in,
    input [11:0] SW_Imm_in,
    input [6:0] Select,
    output reg [11:0] Imm_select_out
    );
    
    always @(LW_ADDI_Imm_in, SW_Imm_in, Select) begin
    
    case(Select)
        `RV32_LOAD: Imm_select_out <= LW_ADDI_Imm_in;
        `RV32_OP_IMM: Imm_select_out <= LW_ADDI_Imm_in;
        `RV32_STORE:Imm_select_out <= SW_Imm_in;
    endcase
        
    end
    
endmodule
