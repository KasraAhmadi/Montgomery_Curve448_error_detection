`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2024 10:32:40 PM
// Design Name: 
// Module Name: wrapper
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


module core(
    input clk,
    input reset,
    input enable_add,
    input enable_mul,
    input [447:0] addition_operand_a,
    input [447:0] addition_operand_b,
    input [447:0] mul_operand_a,
    input [447:0] mul_operand_b,
    input addition_mode,

    output done,
    output [447:0] product_mul,
    output [447:0] product_add
    );

    wire add_done;
    wire mul_done;
    adder modular_addition(addition_operand_a,addition_operand_b,addition_mode,clk,enable_add,reset,add_done,product_add);
    speed_mult_red modular_multiplication(mul_operand_a,mul_operand_b,clk,enable_mul,reset,mul_done,product_mul);
    assign done = !reset & (add_done | !enable_add) & (mul_done | !enable_mul);


endmodule
