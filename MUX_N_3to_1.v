`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2018 04:06:08 PM
// Design Name: 
// Module Name: MUX_N_3to_1
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


module MUX_N_3to_1#(parameter N = 8)(
    input [N-1:0] A,
    input [N-1:0] B,
    input [N-1:0] C,
    input [1:0] sel,
    output reg[N-1:0] Y
    );
    
    always@(A, B, C, sel) begin
    
        case (sel)
            2'b00: Y<=A;
            2'b01: Y<=B;
            2'b10: Y<=C;
        endcase
    
    end
    
endmodule
