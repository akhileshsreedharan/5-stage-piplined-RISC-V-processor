`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2018 12:14:38 PM
// Design Name: 
// Module Name: Main_control_unit
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

module Main_control_unit(
    input [6:0] Opcode,
    input [2:0] Funct_3,
    input Prediction,
    input Greater_equal,
    input Lesser,
    input Equal,
    input signed_less,
    input signed_greater_equal,
    output reg [1:0] PCSrc,
    output reg IF_ID_Flush,
    output reg [1:0] Branch_outcome,
    output reg WBSrc,
    output reg RegWrite,
    output reg MemWrite,
    output reg MemRead,
    output reg [2:0] ALUOp,
    output reg [1:0] ALUSrc
    );
    
    always @(Opcode,Funct_3, Prediction, Greater_equal, Lesser, Equal,signed_less,signed_greater_equal) begin
        case (Opcode)
        
            `RV32_RTYPE: begin
                PCSrc <= 2'b01;
                IF_ID_Flush <= 1'b0;
                Branch_outcome <= 2'b10;
                WBSrc <= 1'b0;
                RegWrite <= 1'b1;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                ALUOp <= 3'b000;
                case(Funct_3) 
                    `RV32_FUNCT3_RTYPE_ADD:  ALUSrc <= 2'b00;  
                    `RV32_FUNCT3_RTYPE_SUB:  ALUSrc <= 2'b00;   
                    `RV32_FUNCT3_RTYPE_XOR:  ALUSrc <= 2'b00;  
                    `RV32_FUNCT3_RTYPE_OR:   ALUSrc <= 2'b00;  
                    `RV32_FUNCT3_RTYPE_AND:  ALUSrc <= 2'b00;   
                                           
//                    `RV32_FUNCT3_RTYPE_SLL:  ALUSrc <= 2'b00;  
//                    `RV32_FUNCT3_RTYPE_SRL:  ALUSrc <= 2'b00;  
//                    `RV32_FUNCT3_RTYPE_SRA:  ALUSrc <= 2'b01;  
                endcase
             end
             
             `RV32_LOAD: begin 
                PCSrc <= 2'b01;
                IF_ID_Flush <= 1'b0;
                Branch_outcome <= 2'b10;
                WBSrc <= 1'b1;
                RegWrite <= 1'b1;
                MemWrite <= 1'b0;
                MemRead <= 1'b1;
                ALUOp <= 3'b011;
                ALUSrc <= 2'b10;
             end   
            
            `RV32_STORE: begin 
                PCSrc <= 2'b11;
                IF_ID_Flush <= 1'b0;
                Branch_outcome <= 2'b10;
                WBSrc <= 1'b1;
                RegWrite <= 1'b0;
                MemWrite <= 1'b1;
                MemRead <= 1'b0;
                ALUOp <= 3'b011;
                ALUSrc <= 2'b10;
             end  
             
             `RV32_JAL: begin
                PCSrc <= 2'b01;
                IF_ID_Flush <= 1'b0;
                Branch_outcome <= 2'b10;
                WBSrc <= 1'b0;
                RegWrite <= 1'b1;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                ALUOp <= 3'b010;
                ALUSrc <= 2'b11;
                            
             end 
             
             `RV32_OP_IMM: begin
                PCSrc <= 2'b01;
                IF_ID_Flush <= 1'b0;
                Branch_outcome <= 2'b10;
                WBSrc <= 1'b0;
                RegWrite <= 1'b1;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                ALUOp <= 3'b001;
                case(Funct_3)
                    `RV32_FUNCT3_ADDI: ALUSrc <= 2'b10;
                    `RV32_FUNCT3_SLLI: ALUSrc <= 2'b01;
                    `RV32_FUNCT3_SRLI: ALUSrc <= 2'b01;
                endcase                            
             end
             
             `RV32_BRANCH: begin
                
                WBSrc <= 1'b0;
                RegWrite <= 1'b0;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                ALUOp <= 3'b111;
                ALUSrc <= 2'b00;
                
                case(Funct_3)
                    
                    `RV32_FUNCT3_BRANCH_BEQ: begin
                        if(Prediction == Equal) begin
                            PCSrc <= 2'b01;
                            IF_ID_Flush <= 1'b0;
                            Branch_outcome <= 2'b11;
                        end
                        else begin
                            Branch_outcome <= 2'b00;
                            IF_ID_Flush <= 1'b1;
                            if(Prediction == 1'b1 && Equal == 1'b0)
                                PCSrc <= 2'b00;
                            else if(Prediction == 1'b0 && Equal == 1'b1)
                                    PCSrc <= 2'b10;
                        end
                    end
                    
                    `RV32_FUNCT3_BRANCH_BNE: begin
                        if(Prediction != Equal) begin
                            PCSrc <= 2'b01;
                            IF_ID_Flush <= 1'b0;//1'b1;
                            Branch_outcome <= 2'b11; //2'b00;
                        end
                        else begin
                            Branch_outcome <= 2'b00;//2'b11;
                            IF_ID_Flush <= 1'b1; //1'b0;
                            if(Prediction == 1'b1 && Equal == 1'b1)
                                PCSrc <= 2'b00;
                            else if(Prediction == 1'b0 && Equal == 1'b0)
                                    PCSrc <= 2'b10;
                        end
                    end
                    
                    `RV32_FUNCT3_BRANCH_BLTU: begin
                        if(Prediction == Lesser) begin
                            PCSrc <= 2'b01;
                            IF_ID_Flush <= 1'b0;
                            Branch_outcome <= 2'b11;
                        end
                        else begin
                            Branch_outcome <= 2'b00;
                            IF_ID_Flush <= 1'b1;
                            if(Prediction == 1'b1 && Lesser == 1'b0)
                                PCSrc <= 2'b00;
                            else if(Prediction == 1'b0 && Lesser == 1'b1)
                                PCSrc <= 2'b10;
                        end
                    end
                    
                    `RV32_FUNCT3_BRANCH_BGEU: begin
                        if(Prediction == Greater_equal) begin
                            PCSrc <= 2'b01;
                            IF_ID_Flush <= 1'b0;
                            Branch_outcome <= 2'b11;
                        end
                        else begin
                            Branch_outcome <= 2'b00;
                            IF_ID_Flush <= 1'b1;
                            if(Prediction == 1'b1 && Greater_equal == 1'b0)
                                PCSrc <= 2'b00;
                            else if(Prediction == 1'b0 && Greater_equal == 1'b1)
                                PCSrc <= 2'b10;
                        end
                    end  
                    
                    `RV32_FUNCT3_BRANCH_BLT: begin
                        if(Prediction == signed_less) begin
                            PCSrc <= 2'b01;
                            IF_ID_Flush <= 1'b0;
                            Branch_outcome <= 2'b11;
                        end
                        else begin
                            Branch_outcome <= 2'b00;
                            IF_ID_Flush <= 1'b1;
                            if(Prediction == 1'b1 && signed_less == 1'b0)
                                PCSrc <= 2'b00;
                            else if(Prediction == 1'b0 && signed_less == 1'b1)
                                PCSrc <= 2'b10;
                        end
                    
                    end                  

                    `RV32_FUNCT3_BRANCH_BGE: begin
                        if(Prediction == signed_greater_equal) begin
                            PCSrc <= 2'b01;
                            IF_ID_Flush <= 1'b0;
                            Branch_outcome <= 2'b11;
                        end
                        else begin
                            Branch_outcome <= 2'b00;
                            IF_ID_Flush <= 1'b1;
                            if(Prediction == 1'b1 && signed_greater_equal == 1'b0)
                                PCSrc <= 2'b00;
                            else if(Prediction == 1'b0 && signed_greater_equal == 1'b1)
                                PCSrc <= 2'b10;
                        end
                    
                    end                  
                    
                
                endcase
             end 
             
            default: begin
            
                PCSrc <= 2'b01;
                IF_ID_Flush <= 1'b0;
                Branch_outcome <= 2'b10;
                WBSrc <= 1'b0;
                RegWrite <= 1'b0;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                ALUOp <= 3'b111;
                ALUSrc <= 2'b00;
            end                  
            
        endcase
    end
    
endmodule
