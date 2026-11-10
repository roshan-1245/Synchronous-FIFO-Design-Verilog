`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.11.2026 19:47:55
// Design Name: 
// Module Name: fifo_top
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

////// FIFO




module fifo_top (

    input rst, clk, en,
    input push_in, pop_in,

    input [7:0] din,

    output [7:0] dout,

    output empty, full,
    output reg overrun,
    output reg underrun,

    input [3:0] threshold,
    output thre_trigger

);

reg [7:0] mem [0:15];

reg [4:0] count;

wire push;
wire pop;

integer i;

// FIFO status flags
assign empty = (count == 0);
assign full  = (count == 16);

// Push and pop control
assign push = en && push_in && !full;
assign pop  = en && pop_in && !empty;

// FIFO output
assign dout = mem[0];

// Memory and count update
always @(posedge clk or posedge rst) begin

    if (rst) begin

        count <= 0;

        for (i = 0; i < 16; i = i + 1)
            mem[i] <= 8'h00;

    end

    else begin

        case ({push, pop})

            // No operation
            2'b00: begin
                count <= count;
            end

            // Push
            2'b10: begin

                mem[count[3:0]] <= din;
                count <= count + 1'b1;

            end

            // Pop
            2'b01: begin

                for (i = 0; i < 15; i = i + 1)
                    mem[i] <= mem[i+1];

                mem[15] <= 8'h00;

                count <= count - 1'b1;

            end

            // Simultaneous push and pop
            2'b11: begin

                for (i = 0; i < 15; i = i + 1)
                    mem[i] <= mem[i+1];

                mem[count[3:0]-1'b1] <= din;

                count <= count;

            end

        endcase

    end

end

// Overrun detection
always @(posedge clk or posedge rst) begin

    if (rst)
        overrun <= 1'b0;

    else
        overrun <= en && push_in && full;

end

// Underrun detection
always @(posedge clk or posedge rst) begin

    if (rst)
        underrun <= 1'b0;

    else
        underrun <= en && pop_in && empty;

end

// Threshold detection
assign thre_trigger = (count >= {1'b0, threshold});

endmodule
