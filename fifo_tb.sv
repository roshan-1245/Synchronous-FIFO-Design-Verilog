`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.11.2026 19:52:30
// Design Name: 
// Module Name: fifo_tb
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





module fifo_tb;

reg rst, clk, en, push_in, pop_in;
reg [7:0] din;

wire [7:0] dout;
wire empty, full, overrun, underrun;

reg [3:0] threshold;
wire thre_trigger;

integer i;

// DUT instantiation using named connections
fifo_top dut_fifo (

    .rst(rst),
    .clk(clk),
    .en(en),
    .push_in(push_in),
    .pop_in(pop_in),
    .din(din),

    .dout(dout),

    .empty(empty),
    .full(full),
    .overrun(overrun),
    .underrun(underrun),

    .threshold(threshold),
    .thre_trigger(thre_trigger)

);

// Clock generation
always #5 clk = ~clk;

// Test sequence
initial begin

    // Initialization
    rst = 1;
    clk = 0;
    en = 0;
    push_in = 0;
    pop_in = 0;
    din = 0;
    threshold = 4'ha;

    // Reset
    repeat(2) @(negedge clk);
    rst = 0;

    // PUSH 20 DATA
    for(i = 0; i < 20; i = i + 1) begin

        @(negedge clk);

        en = 1;
        push_in = 1;
        pop_in = 0;
        din = $urandom();

    end

    @(negedge clk);
    push_in = 0;
    en = 0;

    // READ 20 DATA
    for(i = 0; i < 20; i = i + 1) begin

        @(negedge clk);

        en = 1;
        push_in = 0;
        pop_in = 1;
        din = 0;

    end

    @(negedge clk);

    pop_in = 0;
    en = 0;

    #20;

    $finish;

end

endmodule

