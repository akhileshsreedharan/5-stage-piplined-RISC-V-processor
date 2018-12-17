`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2018 11:38:03 AM
// Design Name: 
// Module Name: LW_SW_ADDI_imm_gen
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


module LW_SW_ADDI_imm_gen(
    input [11:0] imm1,
    input [4:0] imm2,
    input [6:0] opcode,
    output [31:0] imm_out
    );
    
    wire [11:0] imm2_sw;
    wire [11:0] imm_sel_out; 
    
    Two_input_concatenator #(7,5,12) concat_2(imm1[11:5],imm2,imm2_sw);
    Imm_select imm_sel(imm1,imm2_sw,opcode,imm_sel_out);
    Sign_extender #(12,32) sign_extend_1(imm_sel_out,imm_out);
    
    
endmodule
