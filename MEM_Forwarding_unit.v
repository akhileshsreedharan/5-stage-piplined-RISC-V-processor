`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2018 08:01:01 PM
// Design Name: 
// Module Name: MEM_Forwarding_unit
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


module MEM_Forwarding_unit(
    input WB_RegWrite,
    input WB_WBSrc,
    input [4:0] WB_rd,
    input [4:0] MEM_rs2,
    output reg MEM_Fwd_Sig
    );
    
    always @(WB_RegWrite, WB_WBSrc, WB_rd, MEM_rs2, MEM_Fwd_Sig) begin
        if(WB_RegWrite==1'b1 && WB_WBSrc == 1'b1 && WB_rd !=0 && MEM_rs2 == WB_rd)
            MEM_Fwd_Sig = 1'b1;
        else
            MEM_Fwd_Sig = 1'b0;
    end
    
endmodule
