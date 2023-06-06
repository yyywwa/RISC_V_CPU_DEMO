`include "./Core/DEFINES.v"
module inst_mem (
    input mem_wen, clk,
    input [`REG_WIDTH -1:0] reg_w_data,
    input [`REG_WIDTH -1:0] pc,
    input [`REG_WIDTH -1:0] mem_r_addr,
    input [`REG_WIDTH -1:0] mem_w_addr,
    output reg [`REG_WIDTH -1:0] ir,
    output reg [`REG_WIDTH -1:0] mdr
);

  reg [`REG_WIDTH -1:0] all_inst[`INST_MEM_ADDR_DEPTH - 1:0];
  always @(posedge clk) begin
    ir <= all_inst[pc[`INST_MEM_ADDR_WIDTH+2-1:2]];
    if (mem_wen) begin
      all_inst[mem_w_addr[`REG_WIDTH -1:0]] <= reg_w_data;
    end
    mdr <= all_inst[mem_r_addr[`REG_WIDTH -1:0]]; 
  end

endmodule
