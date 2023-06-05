`include "./Core/DEFINES.v"
module pc_reg (
    input clk,
    rst_n,
    input [`REG_WIDTH - 1: 0] next_pc,
    output reg [`REG_WIDTH - 1: 0] pc
);

  always @(posedge clk) begin
    if (~rst_n) begin
      pc = `REG_WIDTH'h0;
    end else begin
      pc = next_pc;
    end
  end

endmodule
