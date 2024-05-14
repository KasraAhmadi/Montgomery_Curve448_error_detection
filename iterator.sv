`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2024 12:36:53 PM
// Design Name: 
// Module Name: iterator
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

module iterator(
    input clk,
    input reset,
    input enable,
    input [55:0] bus_input,
    input [8:0] bit_number_initial_value,
    output [55:0] bus_output,
    output logic done,
    output logic error
    // output logic [447:0] scalar_error_detection
    );


    logic [447:0] scalar_current_value,r0_x,r0_z,r1_x,r1_z,r_double_x,r_double_z,r_add_x,r_add_z,p_x,out_x,out_z,scalar_error_detection;
    logic [8:0] bit_number_current_value;
    logic enable_step;
    logic reset_step;
    wire [447:0] r_double_x_res,r_double_z_res,r_add_x_res,r_add_z_res;
    wire done_step;
    logic bit_scalar;
    reg [2:0] counter_bus_input = 3'd0; 
    logic input_ready = 0;
    assign bus_output = out_x;

    montgomery_step montgomery_step_module(clk,enable_step,reset_step,r_double_x,r_double_z,r_add_x,r_add_z,p_x,r_double_x_res,r_double_z_res,r_add_x_res,r_add_z_res,done_step);
    error_detection error_module(scalar_current_value,scalar_error_detection,error);
   
    
// //ERROR DETECTION REG
//    reg [447:0] mod, factor;
//    reg [667:0] scalar_error_detection;
//    reg [11:0] shift;
//    assign shift = 12'h37c;
//    assign mod = 448'h3fffffffffffffffffffffffffffffffffffffffffffffffffffffff7cca23e9c44edb49aed63690216cc2728dc58f552378c292ab5844f3;
//    assign factor = 448'h400000000000000000000000000000000000000000000000000000008335dc163bb124b65129c96fde933d8d723a70aadc873d6d54a7bb0e;
//    assign scalar_error_detection = {factor,mod,shift};


always @(posedge clk) begin
    if (reset) begin
        scalar_error_detection <= 0;
        counter_bus_input <= 3'd0;
        scalar_current_value <= 448'h0;
    end
    else if(!input_ready) begin
        case (counter_bus_input)
            3'd0: scalar_current_value = {392'h0,bus_input}; // Store first 56 bits
            3'd1: scalar_current_value = {336'h0, bus_input,scalar_current_value[55:0]}; // Store next 56 bits
            3'd2: scalar_current_value = {280'h0, bus_input,scalar_current_value[111:0]}; // Store next 56 bits
            3'd3: scalar_current_value = {224'h0,bus_input,scalar_current_value[167:0]}; // Store next 56 bits
            3'd4: scalar_current_value = {168'h0,bus_input,scalar_current_value[223:0]}; // Store next 56 bits
            3'd5: scalar_current_value = {112'h0,bus_input,scalar_current_value[279:0]}; // Store next 56 bits
            3'd6: scalar_current_value = {56'h0,bus_input,scalar_current_value[335:0]}; // Store next 56 bits
            3'd7: begin 
                scalar_current_value = {bus_input,scalar_current_value[391:0]};
                bit_number_current_value = bit_number_initial_value;
                r0_x = 0;
                r0_z = 0;
                r1_x = 0;
                r1_z = 0;
                r_double_x = 0;
                r_double_z = 0;
                r_add_x = 0;
                r_add_z = 0;
                p_x = 448'h297ea0ea2692ff1b4faff46098453a6a26adf733245f065c3c59d0709cecfa96147eaaf3932d94c63d96c170033f4ba0c7f0de840aed939f;
                enable_step = 0;
                reset_step = 1;
                done = 0;
                input_ready = 1;
            end 
        endcase
        if (counter_bus_input < 3'd7) begin
            counter_bus_input <= counter_bus_input + 1;
        end
    end
    else if(enable && input_ready) begin
        if(done == 0 && done_step == 0)begin
            bit_scalar = scalar_current_value[bit_number_current_value-1];
             scalar_error_detection[bit_number_current_value-1] = bit_scalar;

        if(bit_scalar == 1)begin
                r_double_x = r0_x;
                r_double_z = r0_z;
                r_add_x = r1_x;
                r_add_z = r1_z;
                reset_step = 0;
                enable_step = 1;
            end
        else if(bit_scalar == 0)begin
            r_double_x = r1_x;
            r_double_z = r1_z;
            r_add_x = r0_x;
            r_add_z = r0_z;
            reset_step = 0;
            enable_step = 1;
            end
        end
        if(done == 0 && done_step == 1)begin
            reset_step = 1;
            enable_step = 0;
            // scalar_current_value = scalar_current_value << 1;
            bit_number_current_value = bit_number_current_value - 1;
            if(bit_scalar == 1)begin
                    r1_x = r_add_x_res;
                    r1_z = r_add_z_res;
                    r0_x = r_double_x_res;
                    r0_z = r_double_z_res;
                end
            else if(bit_scalar == 0)begin
                    r0_x = r_add_x_res;
                    r0_z = r_add_z_res;
                    r1_x = r_double_x_res;
                    r1_z = r_double_z_res;
                end
            if(bit_number_current_value == 0) begin 
                done = 1;
                out_x = r0_x;
                out_z = r0_z;
            end
        end
    end
    end


endmodule
