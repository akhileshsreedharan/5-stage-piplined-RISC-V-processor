`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2018 09:53:41 AM
// Design Name: 
// Module Name: Four_input_concatenator
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


module Four_input_concatenator#(parameter in_bus_len1=8, in_bus_len2 =8, in_bus_len3 =8, in_bus_len4 = 8, out_bus_len =32)(
    input [in_bus_len1-1:0] in_1,
    input [in_bus_len2-1:0] in_2,
    input [in_bus_len3-1:0] in_3,
    input [in_bus_len4-1:0] in_4,
    output[out_bus_len-1:0] out
    );
    
    assign out = {in_1,in_2,in_3,in_4};
    
endmodule

