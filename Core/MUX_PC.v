`include "./Core/DEFINES.v"

module mux_pc (
    input [`REG_WIDTH - 1:0] pc,
    input [`FUNCT3_WIDTH - 1:0] branch_op,
    input jump,
    input zero,
    input [`REG_WIDTH - 1:0] imm,
    output reg [`REG_WIDTH - 1:0] next_pc
);
  always @(*) begin
    /*
    if ((branch_op == `INST_BEQ && ~zero)) begin
      next_pc = pc + imm;
    end else if (jump) begin
      next_pc = pc + imm;
    end else begin
      next_pc = pc + `REG_WIDTH'h4;  //从倒数第二位开始取地址
    end
    */
    if (jump) begin
      next_pc = pc + imm; 
    end else begin
      next_pc = pc + `REG_WIDTH'h4;
    end
  end
endmodule
