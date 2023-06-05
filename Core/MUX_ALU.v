`include "./Core/DEFINES.v"
module mux_alu (
    input [`ALU_SRC_WIDTH -1:0] alu_src_sel,
    input [`REG_WIDTH -1:0] pc,
    input [`REG_WIDTH -1:0] reg_r_data1,
    input [`REG_WIDTH -1:0] reg_r_data2,
    input [`REG_WIDTH -1:0] imm,
    output reg [`REG_WIDTH -1:0] alu_src1,
    output reg [`REG_WIDTH -1:0] alu_src2
);

  always @(*) begin
    case (alu_src_sel)
      `ALU_SRC_REG: begin
        alu_src1 = reg_r_data1;
        alu_src2 = reg_r_data2;
      end
      `ALU_SRC_IMM: begin
        alu_src1 = reg_r_data1;
        alu_src2 = imm;
      end
      `ALU_SRC_FOR_PC: begin
        alu_src1 = `REG_WIDTH'h4;
        alu_src2 = pc;
      end
      `ALU_SRC_IMM_PC: begin
        alu_src1 = imm;
        alu_src2 = pc;
      end 
    endcase
  end

endmodule
