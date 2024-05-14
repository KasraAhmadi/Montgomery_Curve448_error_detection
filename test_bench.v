`timescale 1ns / 1ps

module test_bench(
    );
    reg clk;
    reg enable;
    reg reset;
    reg [55:0] bus_input;
    reg [8:0] bit_number_initial_value;
    wire [55:0] bus_output;
    wire done;
    wire error;

    iterator Iterator_module (clk,reset,enable,bus_input,bit_number_initial_value,bus_output,done,error);
    initial 
    begin
        clk = 1'b0;
        bit_number_initial_value = 8'd448;
        reset = 1'b1;      
        enable = 1'b0;
        // #5;
        // bus_input = 56'd3;
        // #10;
        // bus_input = 56'd0;
        #10;
        reset = 1'b0;
        enable = 1'b1;
        bus_input = 56'hFFFFFFFFFFFFFF;
//        #20;
//        bus_input = 56'd0;


    end
    
always #5 clk = ~clk;
    
// initial 
//     begin
//         #10 p_x = 2'b11;
//             p_z = 2'b11;
//             scalar= 10;
//             bit_numbers = 4;
//             start = 1;
//     end


endmodule
