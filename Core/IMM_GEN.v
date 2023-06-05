`include "./Core/DEFINES.v"

module imm_gen(
  input [`IMM_GEN_OP_WIDTH -1:0] imm_gen_op,
  input [`REG_WIDTH -1:0] ir,
  output reg [`REG_WIDTH -1:0] imm
);

always @(*) begin
  imm = `REG_WIDTH'b0;
  case(imm_gen_op)
    `IMM_GEN_I:begin
      imm = {{20{ir[31]}}, ir[31:20]};
    end
    `IMM_GEN_B: begin
      imm = {{20{ir[31]}}, ir[7], ir[30:25], ir[11:8], 1'b0};
    end
    `IMM_GEN_J: begin
      imm = {{12{ir[31]}}, ir[19:12], ir[20], ir[30:21], 1'b0};
    end
    `IMM_GEN_U: begin
      imm = {ir[31:12], 12'b0};
    end
    `IMM_GEN_S: begin
      imm = {{20{ir[31]}}, ir[30:25], ir[11:7]};
    end 
  endcase
end

endmodule