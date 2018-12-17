`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2018 11:54:29 AM
// Design Name: 
// Module Name: Branch_MUX_Logic_gen
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

module Branch_MUX_Logic_gen(
    input [1:0] Prediction_in,
    input [6:0] Opcode,
    output reg Prediction_out
    );
    
    always @(Prediction_in, Opcode) begin
        case(Opcode)
        
        `RV32_BRANCH :begin
            if(Prediction_in == 2'b11 || Prediction_in == 2'b10) begin
                Prediction_out = 1'b1;
            end
            else if(Prediction_in == 2'b00 || Prediction_in == 2'b01) begin
                Prediction_out = 1'b0;
            end
        end
        `RV32_JAL: Prediction_out = 1'b1;
        default: Prediction_out = 1'b0;
        
        endcase
    end
    
endmodule
