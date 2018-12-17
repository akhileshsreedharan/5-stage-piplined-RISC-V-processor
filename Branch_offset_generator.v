`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2018 09:52:19 AM
// Design Name: 
// Module Name: Branch_offset_generator
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


module Branch_offset_generator(
    input [24:0] Inst_in,
    input [6:0] Opcode,
    output [31:0] Branch_offset
    );
    
    wire [11:0] Branch_add_out;
    wire [19:0] JAL_add_out;
    wire [31:0] Branch_add_sign_extend;
    wire [31:0] JAL_add_sign_extend;

    Four_input_concatenator #(1,1,6,4) concat4_1(Inst_in[24], Inst_in[0], Inst_in[23:18],Inst_in[4:1],Branch_add_out);
    Four_input_concatenator #(1,1,8,10) concat4_2(Inst_in[24], Inst_in[13], Inst_in[12:5],Inst_in[23:14],JAL_add_out);
    
    Sign_extender #(12,32) sign_extend1(Branch_add_out,Branch_add_sign_extend);
    Sign_extender #(20,32) sign_extend2(JAL_add_out,JAL_add_sign_extend);
    
    Jump_add_selector jump_add_selector(Branch_add_sign_extend,JAL_add_sign_extend,Opcode,Branch_offset);
    
endmodule
