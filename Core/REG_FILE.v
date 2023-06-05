`include "./Core/DEFINES.v"
module reg_file (
    input clk,
    input reg_wen,
    input [`REG_ADDR_WIDTH - 1:0] reg_w_addr,
    input [`REG_WIDTH - 1:0] reg_w_data,

    input [`REG_ADDR_WIDTH - 1:0] reg_r_addr1,
    input [`REG_ADDR_WIDTH - 1:0] reg_r_addr2,

    output reg [`REG_WIDTH - 1:0] reg_r_data1,
    output reg [`REG_WIDTH - 1:0] reg_r_data2
);
  reg [`REG_WIDTH - 1:0] all_reg[`INST_MEM_ADDR_DEPTH - 1:0];

  integer idx;
  initial begin
    for (idx = 0; idx < 32; idx = idx + 1) all_reg[idx] = 0;
  end

  always @(posedge clk) begin
    if (reg_wen && reg_w_addr != `REG_ADDR_WIDTH'b0) begin
      all_reg[reg_w_addr[`REG_ADDR_WIDTH-1:0]] <= reg_w_data;
    end
  end

  always @(*) begin
      reg_r_data1 = all_reg[reg_r_addr1[`REG_ADDR_WIDTH-1:0]];
      reg_r_data2 = all_reg[reg_r_addr2[`REG_ADDR_WIDTH-1:0]];
  end
endmodule
