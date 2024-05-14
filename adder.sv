`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2024 06:21:55 PM
// Design Name: 
// Module Name: adder
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


module adder #(
    parameter wI = 448
)
(
input   logic   [wI-1:0]    iX,
input   logic   [wI-1:0]    iY,
input logic mode,
input   logic   clk,
input   logic   enable,
input   logic   reset,
output  logic   ready,
output  logic   [wI-1:0]    oO

);
localparam wI_pt = wI / 4;

logic   [wI_pt-1:0] X_3, X_2, X_1, X_0;
logic   [wI_pt-1:0] Y_3, Y_2, Y_1, Y_0;
logic   [wI-1:0]    iY_mode;



logic   [wI_pt-1:0]  operand_1,operand_2,result,r_0,r_1,r_2,r_3;
logic carry;
logic [2:0] counter;
logic [wI-1:0] temp_result,mod;

// assign {C_S_1,S_1} = X_1 + Y_1 + C_S_0;
// assign {C_S_2,S_2} = X_2 + Y_2 + C_S_1;
// assign {C_S_3,S_3} = X_3 + Y_3 + C_S_2;
// assign oO = {C_S_3,S_3,S_2,S_1,S_0} % MOD;
// assign oO = {carry,r_3,r_2,r_1,r_0};

always  @(posedge clk)
    if(!enable || reset)begin
        ready  <= 1'b0;
        counter <= 1'b0;
        carry <= 1'b0;
        mod <= 448'd726838724295606890549323807888004534353641360687318060281490199180612328166730772686396383698676545930088884461843637361053498018365439;
    end
    else begin
        if(counter == 0)begin
            iY_mode = iY;
            if(mode == 1) iY_mode = ~iY_mode + 1; //0 addition, 1 subtraction
            {X_3, X_2, X_1, X_0} = iX;
            {Y_3, Y_2, Y_1, Y_0} = iY_mode;
            operand_1 = X_0;
            operand_2 = Y_0;
        end
        else if(counter == 1)begin
            operand_1 = X_1;
            operand_2 = Y_1;
        end
        else if(counter == 2)begin
            operand_1 = X_2;
            operand_2 = Y_2;
        end
        else if(counter == 3)begin
            operand_1 = X_3;
            operand_2 = Y_3;
        end
        {carry,result} = operand_1 + operand_2 + carry;
        counter = counter + 1;
        if(counter == 1)begin
            r_0 = result;
        end
        else if(counter == 2)begin
            r_1 = result;
        end
        else if(counter == 3)begin
            r_2 = result;
        end
        else if(counter == 4)begin
            r_3 = result;
            temp_result = {carry,r_3,r_2,r_1,r_0};
            if(temp_result >= mod) temp_result = temp_result - mod; 
            else if(temp_result < 0) temp_result = temp_result + mod; 
            oO = temp_result;
            ready = 1;
        end
        
    end



endmodule
