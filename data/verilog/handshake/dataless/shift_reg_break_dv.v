`timescale 1ns/1ps

module shift_reg_break_dv_dataless #(
  parameter integer NUM_SLOTS = 4
)(
  input  clk,
  input  rst,
  // Inputs
  input  ins_valid,
  input  outs_ready,
  // Outputs
  output outs_valid,
  output ins_ready
);

  // Internal signals
  reg  [NUM_SLOTS-1:0] valid_reg;
  wire             regEn;
  integer i;

  // See 'docs/Specs/Buffering/Buffering.md'
  // All the slots share a single handshake control and thus 
  // accept or stall inputs together.
  always @(posedge clk) begin
    if (rst) begin
      valid_reg <= {NUM_SLOTS{1'b0}};
    end else begin
      if (regEn) begin
        // a loop rather than a part-select, which is out of range for 1 slot
        for (i = NUM_SLOTS - 1; i > 0; i = i - 1)
          valid_reg[i] <= valid_reg[i - 1];
        valid_reg[0] <= ins_valid;
      end
    end
  end

  assign outs_valid = valid_reg[NUM_SLOTS-1];
  assign regEn      = ~outs_valid | outs_ready;
  assign ins_ready  = regEn;

endmodule