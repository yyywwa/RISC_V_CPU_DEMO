`include ".\\Core\\DEFINES.v"
module alu (
    input [`ALU_OP_WIDTH -1:0] alu_op,
    input [`REG_WIDTH -1:0] alu_src1,
    input [`REG_WIDTH -1:0] alu_src2,
    output reg [`REG_WIDTH -1:0] alu_res,
    output reg zero
);

  always @(*) begin
    zero = 1'b0;
    case (alu_op)
      `ALU_ADD: begin
        alu_res = alu_src1 + alu_src2;
      end
      `ALU_SUB: begin
        alu_res = alu_src1 - alu_src2;
        zero = (alu_res == `REG_WIDTH'b0)?1'b1:1'b0;
      end
      `ALU_XOR: begin
        alu_res = alu_src1 ^ alu_src2;
      end 
      `ALU_OR: begin
        alu_res = alu_src1 | alu_src2;
      end 
      `ALU_AND: begin
        alu_res = alu_src1 & alu_src2;
      end 
      `ALU_SLL: begin
        alu_res = alu_src1 << alu_src2;
      end 
      `ALU_SRL: begin
        alu_res = alu_src1 >> alu_src2;
      end 
      `ALU_SRA: begin
        alu_res = alu_src1 >>> alu_src2;
      end
      `ALU_SLT: begin
        if (alu_src1[31] ^ alu_src2[31] == 1'b1) begin
          alu_res = (alu_src2[31] == 1'b1)?1:0;
        end else begin
          if (alu_src1[31] == 1'b0) begin
            alu_res = (alu_src1 < alu_src2)?1:0;
          end else begin
            alu_res = (alu_src1 < alu_src2)?0:1;
          end
        end
      end
      `ALU_SLTU: begin
        alu_res = (alu_src1 < alu_src2)?1:0;
      end
    endcase
  end


endmodule
