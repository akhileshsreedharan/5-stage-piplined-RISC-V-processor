`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2018 03:41:31 PM
// Design Name: 
// Module Name: IF_ID_Reg
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

module IF_ID_Reg(
    input clk,
    input reset,
    input IF_ID_Flush,
    input IF_ID_Write,
    input IF_Prediction,
    input [31:0] IF_PC_New,
    input [31:0] IF_Branch_Target,
    input [31:0] Inst_in,
    output reg ID_Prediction,
    output reg [31:0] ID_PC_New,
    output reg [31:0] ID_Branch_Target,
    output reg [31:0] Inst_out
    );
    
    always @(posedge clk, negedge reset) begin
    
        if (reset == 1'b0) begin
            ID_Prediction <= 1'b0;
            ID_PC_New <= `ZERO_VECTOR_32;
            ID_Branch_Target <= `ZERO_VECTOR_32;
            Inst_out <= `INVALID_INSTRUCTION;
        end
    
        else begin        
            if(clk == 1'b1) begin        
                if(IF_ID_Write == 1'b1) begin
            
                    if(IF_ID_Flush == 1'b1) begin
                        ID_Prediction <= 1'b0;
                        ID_PC_New <= `ZERO_VECTOR_32;
                        ID_Branch_Target <= `ZERO_VECTOR_32;
                        Inst_out <= `INVALID_INSTRUCTION;
                    end               
                    else begin
                        ID_Prediction <= IF_Prediction;
                        ID_PC_New <= IF_PC_New;
                        ID_Branch_Target <= IF_Branch_Target;
                        Inst_out <= Inst_in;                
                    end
                           
                end        
            end   
        end
     
    end
   
endmodule
