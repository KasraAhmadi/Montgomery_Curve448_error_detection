`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/02/2024 11:03:13 AM
// Design Name: 
// Module Name: speed_mult_red
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


module speed_mult_red(
input   logic   [447:0]    iX,
input   logic   [447:0]    iY,
input   logic   clk,
input   logic   enable,
input   logic   reset,
output   logic   ready,
output  logic   [447:0]    oO

    );

logic   [223:0] a_0, a_1,b_0,b_1,v,op_1,op_2;
logic   [447:0] z_0,z_1, z_2, z_3,res,mod;
logic [449:0] t,z_4;
logic [225:0] t_1,u;
logic [450:0] g;


logic [2:0] counter;

assign  a_0 = iX[223:0];
assign  a_1 = iX[447:224];
assign  b_0 = iY[223:0];
assign  b_1 = iY[447:224];
always  @(posedge clk)
    if(!enable || reset)begin
        ready    <= 1'b0;
        oO <= 448'b0;
        counter <= 0;
        mod <= 448'd726838724295606890549323807888004534353641360687318060281490199180612328166730772686396383698676545930088884461843637361053498018365439;
    end
    else begin
        if(counter == 0)begin  
            op_1 = a_0;
            op_2 = b_1;
        end
        else if(counter == 1)begin  
            op_1 = a_1;
            op_2 = b_0;
        end
        else if(counter == 2)begin  
            op_1 = a_1;
            op_2 = b_1;
        end
        else if(counter == 3)begin  
            op_1 = a_0;
            op_2 = b_0;
        end
        res = op_1 * op_2;
        counter = counter + 1;
        
        if(counter == 1) z_1 = res;
        else if(counter == 2) z_2 = res;
        else if(counter == 3) z_3 = res;
        else if(counter == 4) begin 
            z_0 = res; 
            t = z_1 + z_2 + z_3;
            t_1 = t[449:224];
            z_4 = {(t[223:0]+t[449:224]+t[449:448]),t_1[223:0]};
            g = z_3 + z_0 + z_4;
            u = g[223:0] + g[450:448];
            v = g[447:224] + g[450:448];
            res = {v+u[224],u[223:0]};
            if(res >= mod) res = res - mod; 
            oO = res;
            ready = 1;
        end
    end
endmodule
