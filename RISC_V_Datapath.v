`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2018 07:48:12 PM
// Design Name: 
// Module Name: RISC_V_Datapath
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


module RISC_V_Datapath(
    input clk,
    input reset
    );
        
    /*IF- STAGE NETS*/
    wire [31:0]IF_PC_new_Branch_Target;
    wire [31:0] IF_PC_current,IF_PC_new;
    wire [31:0] Inst;
    wire [31:0] IF_Branch_Target;
    wire IF_Prediction;
    
    /*ID- STAGE NETS*/
    wire [31:0] ID_PC_new,ID_Branch_Target,PC_in;
    wire [1:0] MUX_ID_PCSrc;
    wire PC_Write;
    wire branch_predictor_enable;
    wire [1:0] MUX_ID_Branch_outcome;
    wire IF_ID_Flush,IF_ID_Write;
    wire ID_Prediction;
    wire [31:0] Inst_out;
    wire [1:0] ID_Branch_outcome;
    wire [1:0] ID_PCSrc;
    wire ID_WBSrc;
    wire ID_RegWrite;
    wire ID_MemWrite;
    wire ID_MemRead;
    wire [2:0] ID_ALUOp;
    wire [1:0] ID_ALUSrc;
    wire Ctrl_0_sig;
    wire MUX_ID_WBSrc;
    wire MUX_ID_RegWrite;
    wire MUX_ID_MemWrite;
    wire MUX_ID_MemRead;
    wire [2:0] MUX_ID_ALUOp;
    wire [1:0] MUX_ID_ALUSrc;
    wire Greater_equal,Lesser,Equal,signed_greater_equal,signed_less;
    wire [31:0] ID_read_data_1,ID_read_data_2;
    wire [1:0] ID_fwd_rs1, ID_fwd_rs2;
    wire [31:0] MUX_ID_read_data_1, MUX_ID_read_data_2;
    wire [31:0] ID_imm_out;

    /*EX- STAGE NETS*/
    wire EX_MemRead,EX_RegWrite,EX_WBSrc;
    wire [4:0] EX_rd;
    wire EX_MemWrite;
    wire [2:0] EX_ALUOp;
    wire [1:0] EX_ALUSrc;
    wire [31:0] EX_Read_data_1, EX_Read_data_2;
    wire [4:0] EX_rs2,EX_shamnt_in;
    wire [6:0] EX_Funct7_R;
    wire [3:0] EX_Funct3_R;
    wire [4:0] EX_rs1;
    wire [31:0] EX_Imm_out,EX_PC_New;
    wire [1:0] EX_fwd_A,EX_fwd_B,EX_fwd_C;
    wire [31:0] Fwd_A_out, Fwd_B_out,Fwd_C_out;
    wire [31:0] EX_MUX2_out;
    wire [31:0] EX_shamnt_out;
    wire [4:0] ALU_ctrl;
    wire [31:0] EX_ALU_result;
    wire ALU_zero;
    
    /*MEM- STAGE NETS*/
    wire MEM_MemRead;
    wire [4:0]MEM_rd;
    wire [31:0] MEM_ALU_Result;
    wire MEM_WBSrc, MEM_RegWrite;
    wire [31:0] MEM_Read_data_2;
    wire [31:0] MEM_LW_ReadData;
    wire [4:0] MEM_rs2;
    wire MEM_Fwd_Sig;
    wire [31:0] MEM_Fwd_WriteData;
    
    
    /*WB- STAGE NETS*/
    wire [4:0] WB_rd;
    wire [31:0] WB_result;
    wire WB_RegWrite;
    wire WB_WBSrc;
    wire [31:0] WB_LW_ReadData;
    wire [31:0] WB_ALU_Result;

    
    /**************************IF- STAGE BLOCKS*****************************************/
    MUX_N_3to_1 #(32) MUX1(ID_PC_new,IF_PC_new_Branch_Target,ID_Branch_Target,MUX_ID_PCSrc,PC_in);
    Instruction_Fetch_Unit IFU(clk, reset, PC_Write,PC_in, IF_PC_current, IF_PC_new, Inst);
    Branch_address_generator BAG(Inst[6:0],Inst[31:7],IF_PC_current,IF_Branch_Target);
    Branch_Predictor BP(reset,clk,branch_predictor_enable,MUX_ID_Branch_outcome,Inst[6:0],IF_Prediction);
    MUX_N_2to1 #(32) MUX4(IF_PC_new,IF_Branch_Target,IF_Prediction,IF_PC_new_Branch_Target);
    /************************************************************************************/
    
    /*****************************IF/ID REGISTER***************************************/    
    IF_ID_Reg if_id_register(
                             clk,
                             reset,
                             IF_ID_Flush,
                             IF_ID_Write,
                             IF_Prediction,
                             IF_PC_new,
                             IF_Branch_Target,
                             Inst,
                             ID_Prediction,
                             ID_PC_new,
                             ID_Branch_Target,
                             Inst_out
                             ); 
    /************************************************************************************/

    
    /**************************ID- STAGE BLOCKS*****************************************/
    MUX_Ctrl_0 mux_ctrl_0(ID_Branch_outcome,ID_PCSrc,ID_WBSrc,ID_RegWrite,ID_MemWrite,ID_MemRead,ID_ALUOp,ID_ALUSrc,Ctrl_0_sig,MUX_ID_Branch_outcome,MUX_ID_PCSrc,MUX_ID_WBSrc,MUX_ID_RegWrite,MUX_ID_MemWrite,MUX_ID_MemRead,MUX_ID_ALUOp,MUX_ID_ALUSrc);
    Main_control_unit MCU(Inst_out[6:0],Inst_out[14:12],ID_Prediction,Greater_equal,Lesser,Equal,signed_less,signed_greater_equal,ID_PCSrc,IF_ID_Flush,ID_Branch_outcome,ID_WBSrc,ID_RegWrite,ID_MemWrite,ID_MemRead,ID_ALUOp,ID_ALUSrc);
    ID_Stalling_Unit IDSU(EX_MemRead,EX_RegWrite,EX_WBSrc,MEM_MemRead,Inst_out[6:0],EX_rd,MEM_rd,Inst_out[19:15],Inst_out[24:20],PC_Write,IF_ID_Write,Ctrl_0_sig,branch_predictor_enable);
    Register_file reg_file(reset,Inst_out[19:15],Inst_out[24:20],WB_rd,WB_result,WB_RegWrite,ID_read_data_1,ID_read_data_2);
    MUX_N_3to_1 #(32) Mux_rs1(ID_read_data_1,MEM_ALU_Result,WB_result,ID_fwd_rs1,MUX_ID_read_data_1);
    MUX_N_3to_1 #(32) Mux_rs2(ID_read_data_2,MEM_ALU_Result,WB_result,ID_fwd_rs2,MUX_ID_read_data_2);
    Comparator compare(MUX_ID_read_data_1,MUX_ID_read_data_2,Lesser,Greater_equal,Equal,signed_greater_equal,signed_less);
    LW_SW_ADDI_imm_gen LSAIG(Inst_out[31:20],Inst_out[11:7],Inst_out[6:0],ID_imm_out);
    ID_Forwarding_Unit IDFU(MEM_WBSrc,MEM_RegWrite,WB_RegWrite,Inst_out[6:0],MEM_rd,WB_rd,Inst_out[19:15], Inst_out[24:20],ID_fwd_rs1, ID_fwd_rs2);
    /************************************************************************************/

    /*****************************ID/EX REGISTER******************************************/ 
    
    ID_EX_Reg id_ex_reg(
                        clk,
                        reset,
                        MUX_ID_WBSrc,
                        MUX_ID_RegWrite,
                        MUX_ID_MemWrite,
                        MUX_ID_MemRead,
                        MUX_ID_ALUOp,
                        MUX_ID_ALUSrc,
                        MUX_ID_read_data_1,
                        MUX_ID_read_data_2,
                        Inst_out[24:20],
                        Inst_out[31:25],
                        Inst_out[14:12],
                        Inst_out[19:15],
                        Inst_out[11:7],
                        ID_imm_out,
                        ID_PC_new,
                        EX_WBSrc,
                        EX_RegWrite,
                        EX_MemWrite,
                        EX_MemRead,
                        EX_ALUOp,
                        EX_ALUSrc,
                        EX_Read_data_1,
                        EX_Read_data_2,
                        EX_rs2,
                        EX_shamnt_in,
                        EX_Funct7_R,
                        EX_Funct3_R,
                        EX_rs1, 
                        EX_rd,
                        EX_Imm_out,
                        EX_PC_New
                        );
       
    /************************************************************************************/


    /**************************EX- STAGE BLOCKS****************************************/
    EX_Forwarding_Unit EXFU(MEM_RegWrite,WB_RegWrite,EX_MemWrite, MEM_rd,WB_rd,EX_rs1,EX_rs2,EX_ALUOp,EX_fwd_A,EX_fwd_B,EX_fwd_C);
    MUX_N_3to_1 #(32) MUX_A(EX_Read_data_1,MEM_ALU_Result,WB_result,EX_fwd_A,Fwd_A_out);
    MUX_N_3to_1 #(32) MUX_B(EX_MUX2_out,MEM_ALU_Result,WB_result,EX_fwd_B,Fwd_B_out);
    MUX_N_4to1 #(32) MUX2(EX_Read_data_2,EX_shamnt_out,EX_Imm_out,EX_PC_New,EX_ALUSrc,EX_MUX2_out);
    Zero_extender #(5,32) zero_extend(EX_shamnt_in,EX_shamnt_out);
    ALU_control_unit alu_ctrl_unit(EX_Funct3_R,EX_Funct7_R,EX_ALUOp,ALU_ctrl);
    ALU alu(Fwd_A_out,Fwd_B_out,ALU_ctrl,EX_ALU_result,ALU_zero);
    MUX_N_3to_1 #(32) MUX_C(EX_Read_data_2,MEM_ALU_Result,WB_result,EX_fwd_C,Fwd_C_out);
   /************************************************************************************/
   
   /*****************************EX/MEM REGISTER******************************************/ 
   EX_MEM_Reg ex_mem_reg(
                         clk,
                         reset,
                         EX_WBSrc,
                         EX_RegWrite,
                         EX_MemWrite,
                         EX_MemRead,
                         EX_ALU_result,
                         Fwd_C_out,
                         EX_rd,
                         EX_rs2,
                         MEM_WBSrc,
                         MEM_RegWrite,
                         MEM_MemWrite,
                         MEM_MemRead,
                         MEM_ALU_Result,
                         MEM_Read_data_2,
                         MEM_rd,
                         MEM_rs2 
                        );
   /************************************************************************************/

   

   /*****************************MEM- STAGE BLOCKS******************************************/ 
    MEM_Forwarding_unit MFU(WB_RegWrite,WB_WBSrc,WB_rd,MEM_rs2,MEM_Fwd_Sig);
    MUX_N_2to1 #(32) MEM_Fwd_MUX(MEM_Read_data_2,WB_result,MEM_Fwd_Sig,MEM_Fwd_WriteData);
    Data_Memory dmem(reset,MEM_ALU_Result,MEM_Fwd_WriteData,MEM_MemWrite,MEM_MemRead,MEM_LW_ReadData);
   /************************************************************************************/
   
   /*****************************MEM/WB REGISTER******************************************/ 
    MEM_WB_reg mem_wb_reg(
                          clk,
                          reset,
                          MEM_WBSrc,
                          MEM_RegWrite,
                          MEM_LW_ReadData,
                          MEM_ALU_Result,
                          MEM_rd,
                          WB_WBSrc,
                          WB_RegWrite,
                          WB_LW_ReadData,
                          WB_ALU_Result,
                          WB_rd
                          );
   
   /************************************************************************************/


   /*****************************WB- STAGE BLOCKS****************************************/
     MUX_N_2to1 #(32) MUX3(WB_ALU_Result,WB_LW_ReadData,WB_WBSrc,WB_result);
   /************************************************************************************/

    
endmodule
