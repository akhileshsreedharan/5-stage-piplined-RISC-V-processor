`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2018 12:11:10 PM
// Design Name: 
// Module Name: Branch_Predictor
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


module Branch_Predictor(
    input Reset,
    input clk,
    input branch_predictor_enable,
    input [1:0] Outcome,
    input [6:0] Opcode,
    output Prediction
    );
    
    wire [1:0] state;
    wire branch_predictor_clk;
    
    and and1(branch_predictor_clk,branch_predictor_enable,clk); 
    Two_bit_branch_predictor two_bit_bp(Reset,branch_predictor_clk,Outcome,state);
    Branch_MUX_Logic_gen BMLG(state,Opcode,Prediction);
    
endmodule
