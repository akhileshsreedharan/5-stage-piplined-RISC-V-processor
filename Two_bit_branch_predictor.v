`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2018 11:19:47 AM
// Design Name: 
// Module Name: Two_bit_branch_predictor
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


module Two_bit_branch_predictor(
    input reset,
    input clk,
    input [1:0] Outcome,
    output reg [1:0] Prediction
    );
    
    parameter SNT = 2'b00, WNT = 2'b01, WT = 2'b10, ST = 2'b11;
    
    reg [1:0] present_state;
    
    always @( posedge clk, negedge reset) begin
           if(!reset) begin 
                present_state <= WT; 
                Prediction<= WT; 
           end
           else begin
              case(present_state)
                ST: begin
                    if(Outcome == 2'b00) begin
                        present_state <= WT;
                        Prediction <= WT;
                     end
                    else /*if(Outcome == 2'b11 || Outcome == 2'b10 || Outcome==2'b01)*/begin
                        present_state <= ST;
                        Prediction <= ST;
                    end
                end
                
                WT: begin
                    if(Outcome == 2'b00) begin
                        present_state <= WNT;
                        Prediction <= WNT;
                     end
                    else if(Outcome == 2'b11)begin
                        present_state <= ST;
                        Prediction <= ST;
                    end
                    else /*if(Outcome == 2'b10 || Outcome==2'b01)*/ begin
                        present_state <= WT;
                        Prediction <= WT;
                    end
                end

                WNT: begin
                    if(Outcome == 2'b00) begin
                        present_state <= WT;
                        Prediction <= WT;
                     end
                    else if(Outcome == 2'b11)begin
                        present_state <= SNT;
                        Prediction <= SNT;
                    end
                    else /*if(Outcome == 2'b10 || Outcome==2'b01)*/ begin
                        present_state <= WNT;
                        Prediction <= WNT;
                    end
                end

                SNT: begin
                    if(Outcome == 2'b00) begin
                        present_state <= WNT;
                        Prediction <= WNT;
                     end
                    else /*if(Outcome == 2'b11 || Outcome == 2'b10 || Outcome==2'b01)*/begin
                        present_state <= SNT;
                        Prediction <= SNT;
                    end
                end

                
              endcase 
           end
    end
        
endmodule
