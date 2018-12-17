`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2018 11:08:31 AM
// Design Name: 
// Module Name: Left_Shift_1
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


module Left_Shift_1(
    input [31:0] in_bus,
    output [31:0] out_bus
    );
    
    assign out_bus = in_bus <<1;
    
endmodule
