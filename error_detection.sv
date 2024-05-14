`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2024 07:59:49 PM
// Design Name: 
// Module Name: error_detection
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


module error_detection(
    input [447:0] operand1,
    input [447:0] operand2,
    output reg error
    );
    reg [446:0] xor_result;

    always @* begin
        for (int i = 0; i < 447; i = i + 1) begin
            xor_result[i] = operand1[i] ^ operand2[i];
        end
    end
  
    assign error = (xor_result == 0) ? 0:1;

endmodule
