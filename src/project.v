`default_nettype none

module tt_um_Drexeng2015_blinky (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);
  // A 26-bit counter. At a 10 MHz clock, bit 23 flips about every 0.84 s.
  reg [25:0] count;

  always @(posedge clk) begin
    if (!rst_n) count <= 26'd0;
    else        count <= count + 26'd1;
  end

  // The top 8 bits drive the display: low segments shimmer, high ones crawl.
  assign uo_out  = count[25:18];
  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0;   // all bidirectional pins are inputs

  // Tell the linter that unused inputs are unused on purpose.
  wire _unused = &{ena, ui_in, uio_in, 1'b0};
endmodule
