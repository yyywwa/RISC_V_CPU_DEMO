`include "./Core/DEFINES.v"
module inst_mem (
    input [`REG_WIDTH -1:0] pc,
    output reg [`INST_WIDTH -1:0] ir
);

  reg [`REG_WIDTH -1:0] all_inst[`INST_MEM_ADDR_DEPTH - 1:0];
  always @(*) begin
    ir = all_inst[pc[`INST_MEM_ADDR_WIDTH+2-1:2]];
  end

endmodule
