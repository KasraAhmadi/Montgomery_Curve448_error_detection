`timescale 1ns / 1ps

module montgomery_step(
    input clk,
    input enable,
    input reset,
    input [447:0] x_1,
    input [447:0] z_1,
    input [447:0] x_2,
    input [447:0] z_2,
    input [447:0] p_x,

    output reg [447:0] x_pd,
    output reg [447:0] z_pd,
    output reg [447:0] x_pa,
    output reg [447:0] z_pa,
    output reg done
    );

// //ERROR DETECTION REG
//    logic [447:0] mod, factor;
//    logic [667:0] scalar_error_detection;
//    logic [11:0] shift;
//    assign shift = 12'h37c;
//    assign mod = 448'h3fffffffffffffffffffffffffffffffffffffffffffffffffffffff7cca23e9c44edb49aed63690216cc2728dc58f552378c292ab5844f3;
//    assign factor = 448'h400000000000000000000000000000000000000000000000000000008335dc163bb124b65129c96fde933d8d723a70aadc873d6d54a7bb0e;
    
    logic [447:0] s0_a,s1_a,s1_m,s2_a,s2_m,s3_a,s3_m,s4_a,s4_m,s5_m,s6_a,s7_a,s7_m,s8_a,s9_m,
    add_op_1,add_op_2,mul_op_1,mul_op_2,add_res,mul_res;
    logic [3:0] state;
    logic enable_add,enable_mul,addition_mode,wrapper_reset;
    wire wrapper_done;
    logic [15:0] constant; 
    logic helper_done;
    core core_module (clk,wrapper_reset,enable_add,enable_mul,add_op_1,add_op_2,mul_op_1,mul_op_2,addition_mode,wrapper_done,mul_res,add_res);
    assign done = helper_done & !reset & enable;

    always  @(posedge clk)begin
        if(reset) begin
            constant <= 39081; 
            state <= 0;
            s0_a <= 0;
            s1_a <= 0;
            s1_m <= 0;
            s2_a <= 0;
            s2_m <= 0;
            s3_a <= 0;
            s3_m <= 0;
            s4_a <= 0;
            s4_m <= 0;
            s5_m <= 0;
            s6_a <= 0;
            s7_a <= 0;
            s7_m <= 0;
            s8_a <= 0;
            s9_m <= 0;
            helper_done <= 0;
            wrapper_reset <= 1;

        end
        else if(enable) begin
            if(state == 0)begin
                wrapper_reset = 0;
                enable_add = 1;
                enable_mul = 0;
                addition_mode = 0; // 0 is addition, 1 is subtract
                add_op_1 = x_1; //set the input
                add_op_2 = z_1; //set the input
            end
            else if(state == 1)begin
                wrapper_reset = 0;
                enable_add = 1;
                enable_mul = 1;
                addition_mode = 1; // subtraction
                add_op_1 = x_1; //set the input adder
                add_op_2 = z_1; //set the input adder
                mul_op_1 = s0_a; //set the input mul
                mul_op_2 = s0_a; //set the input mul
            end
            else if(state == 2)begin
                wrapper_reset = 0;
                enable_add = 1;
                enable_mul = 1;
                addition_mode = 0; // addition
                add_op_1 = x_2; //set the input adder x_2 + z_2
                add_op_2 = z_2; //set the input adder
                mul_op_1 = s1_a; //set the input mul
                mul_op_2 = s1_a; //set the input mul
            end
            else if(state == 3)begin
                wrapper_reset = 0;
                enable_add = 1;
                enable_mul = 1;
                addition_mode = 1; // subtraction
                add_op_1 = x_2; //set the input adder x_2 + z_2
                add_op_2 = z_2; //set the input adder
                mul_op_1 = s1_a; //set the input mul
                mul_op_2 = s2_a; //set the input mul
            end
            else if(state == 4)begin
                wrapper_reset = 0;
                enable_add = 1;
                enable_mul = 1;
                addition_mode = 1; // subtraction
                add_op_1 = s1_m; //set the input adder x_2 + z_2
                add_op_2 = s2_m; //set the input adder
                mul_op_1 = s3_a; //set the input mul
                mul_op_2 = s0_a; //set the input mul
            end
            else if(state == 5)begin
                wrapper_reset = 0;
                enable_add = 0;
                enable_mul = 1;
                mul_op_1 = constant; //set the input mul
                mul_op_2 = s4_a; //set the input mul
            end
            else if(state == 6)begin
                wrapper_reset = 0;
                enable_add = 1;
                enable_mul = 1;
                addition_mode = 1; // subtraction
                add_op_1 = s3_m; //set the input adder 
                add_op_2 = s4_m; //set the input adder
                mul_op_1 = s2_m; //set the input mul
                mul_op_2 = s1_m; //set the input mul
            end
            else if(state == 7)begin
                wrapper_reset = 0;
                enable_add = 1;
                enable_mul = 1;
                addition_mode = 0; // addition
                add_op_1 = s5_m; //set the input adder 
                add_op_2 = s2_m; //set the input adder
                mul_op_1 = s6_a; //set the input mul
                mul_op_2 = s6_a; //set the input mul
            end
            else if(state == 8)begin
                wrapper_reset = 0;
                enable_add = 1;
                enable_mul = 1;
                addition_mode = 0; // addition
                add_op_1 = s3_m; //set the input adder 
                add_op_2 = s4_m; //set the input adder
                mul_op_1 = s4_a; //set the input mul
                mul_op_2 = s7_a; //set the input mul
            end
            else if(state == 9)begin
                wrapper_reset = 0;
                enable_add = 0;
                enable_mul = 1;
                mul_op_1 = s8_a; //set the input mul
                mul_op_2 = s8_a; //set the input mul
            end
            else if(state == 10)begin
                wrapper_reset = 0;
                enable_add = 0;
                enable_mul = 1;
                mul_op_1 = s7_m; //set the input mul
                mul_op_2 = p_x; //set the input mul
            end
            
            if(state == 0 && wrapper_done)begin
                wrapper_reset = 1;
                s0_a = add_res; //set the output
                state = state + 1;

            end
            else if(state == 1 && wrapper_done)begin
                wrapper_reset = 1;
                s1_a = add_res; //set the output
                s1_m = mul_res; //set the output
                state = state + 1;

            end
            else if(state == 2 && wrapper_done)begin
                wrapper_reset = 1;
                s2_a = add_res; //set the output
                s2_m = mul_res; //set the output
                state = state + 1;

            end
            else if(state == 3 && wrapper_done)begin
                wrapper_reset = 1;
                s3_a = add_res; //set the output
                s3_m = mul_res; //set the output
                state = state + 1;
            end
            else if(state == 4 && wrapper_done)begin
                wrapper_reset = 1;
                s4_a = add_res; //set the output
                s4_m = mul_res; //set the output
                state = state + 1;

            end
            else if(state == 5 && wrapper_done)begin
                wrapper_reset = 1;
                s5_m = mul_res; //set the output
                state = state + 1;

            end
            else if(state == 6 && wrapper_done)begin
                wrapper_reset = 1;
                s6_a = add_res; //set the output
                x_pd = mul_res; //set the output
                state = state + 1;

            end
            else if(state == 7 && wrapper_done)begin
                wrapper_reset = 1;
                s7_a = add_res; //set the output
                s7_m = mul_res; //set the output
                state = state + 1;

            end
            else if(state == 8 && wrapper_done)begin
                wrapper_reset = 1;
                s8_a = add_res; //set the output
                z_pd = mul_res; //set the output
                state = state + 1;

            end
            else if(state == 9 && wrapper_done)begin
                wrapper_reset = 1;
                x_pa = mul_res; //set the output
                state = state + 1;

            end
            else if(state == 10 && wrapper_done)begin
                wrapper_reset = 1;
                z_pa = mul_res; //set the output
                helper_done = 1;
            end

        end
    end
endmodule
