`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2018 04:17:16 PM
// Design Name: 
// Module Name: ALU_control_unit
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
`include "RV32_Constants.vh"

module ALU_control_unit(
    input [2:0] Funct_3,
    input [6:0] Funct_7,
    input [1:0] ALUOp,
    output reg [4:0] ALU_ctrl
    );
    
    always @(Funct_3, Funct_7, ALUOp) begin
        case(ALUOp) 
            `ALU_OP_7 : ALU_ctrl <= `ALU_NOP;
            `ALU_OP_2 : ALU_ctrl <= `ALU_PASS_B;
            `ALU_OP_3 : ALU_ctrl <= `ALU_ADD;
            `ALU_OP_1 : begin
                case(Funct_3)
                    `RV32_FUNCT3_ADDI :  ALU_ctrl <= `ALU_ADD;
                    `RV32_FUNCT3_SLLI :  ALU_ctrl <= `ALU_LSHIFT;
                    `RV32_FUNCT3_SRLI :  ALU_ctrl <= `ALU_RSHIFT;
                endcase
            end
            `ALU_OP_0: begin               
                case(Funct_3)  
                    `RV32_FUNCT3_RTYPE_ADD/*_SUB*/: begin
                        if(Funct_7 == `RV32_FUNCT7_RTYPE_ADD) 
                            ALU_ctrl <= `ALU_ADD;
                        else if(Funct_7 == `RV32_FUNCT7_RTYPE_SUB)
                            ALU_ctrl <= `ALU_SUB;
                     end 
                    `RV32_FUNCT3_RTYPE_OR  : ALU_ctrl <= `ALU_OR;
                    `RV32_FUNCT3_RTYPE_AND : ALU_ctrl <= `ALU_AND;
                    `RV32_FUNCT3_RTYPE_XOR : ALU_ctrl <= `ALU_XOR;                                          
//                    `RV32_FUNCT3_RTYPE_SLL : ALU_ctrl <= `ALU_LSHIFT;
//                    `RV32_FUNCT3_RTYPE_SRL : ALU_ctrl <= `ALU_RSHIFT;
                endcase
                
            end
            default : ALU_ctrl <= `ALU_NOP;
        endcase
    end
    
endmodule
