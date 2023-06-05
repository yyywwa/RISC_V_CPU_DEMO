`include "./Core/DEFINES.v"

module ctrl (
    input [`INST_WIDTH -1:0] ir,
    output reg reg_wen,
    jump,
    output reg [`FUNCT3_WIDTH-1:0] branch_op,
    output reg [`REG_ADDR_WIDTH -1:0] reg_w_addr,
    output reg [`REG_WIDTH -1:0] reg_w_data,

    output reg [`REG_ADDR_WIDTH - 1:0] reg_r_addr1,
    output reg [`REG_ADDR_WIDTH - 1:0] reg_r_addr2,

    output reg [`ALU_OP_WIDTH - 1:0] alu_op,
    output reg [`IMM_GEN_OP_WIDTH -1:0] imm_gen_op,
    output reg [`ALU_SRC_WIDTH -1:0] alu_src_sel
);

  wire [  `OPCODE_WIDTH -1:0] opcode = ir[`OPCODE_WIDTH+`OPCODE_BASE-1:`OPCODE_BASE];
  wire [  `FUNCT3_WIDTH -1:0] funct3 = ir[`FUNCT3_WIDTH+`FUNCT3_BASE-1:`FUNCT3_BASE];
  wire [  `FUNCT7_WIDTH -1:0] funct7 = ir[`FUNCT7_WIDTH+`FUNCT7_BASE-1:`FUNCT7_BASE];
  wire [`REG_ADDR_WIDTH -1:0] rd = ir[`REG_ADDR_WIDTH+`RD_BASE-1:`RD_BASE];
  wire [`REG_ADDR_WIDTH -1:0] rs1 = ir[`REG_ADDR_WIDTH+`RS1_BASE-1:`RS1_BASE];
  wire [`REG_ADDR_WIDTH -1:0] rs2 = ir[`REG_ADDR_WIDTH+`RS2_BASE-1:`RS2_BASE];

  always @(*) begin
    branch_op   <= 3'b0;
    jump        <= 1'b0;
    reg_wen     <= 1'b0;
    reg_r_addr1 <= `REG_ADDR_WIDTH'b0;
    reg_r_addr2 <= `REG_ADDR_WIDTH'b0;
    reg_w_addr  <= `REG_ADDR_WIDTH'b0;
    imm_gen_op  <= `IMM_GEN_I;
    alu_op      <= `ALU_AND;
    alu_src_sel <= `ALU_SRC_REG;
    case (opcode)
      `INST_JAL: begin
        jump <= 1'b1;
        reg_wen <= 1'b1;
        reg_w_addr <= rd;
        alu_op <= `ALU_ADD;
        imm_gen_op <= `IMM_GEN_J;
        alu_src_sel <= `ALU_SRC_FOR_PC;
      end
      `INST_LUI: begin
        reg_wen <= 1'b1;
        reg_w_addr <= rd;
        imm_gen_op <= `IMM_GEN_U;
        alu_op <= `ALU_ADD;
        alu_src_sel <= `ALU_SRC_IMM;
      end
      `INST_AUIPC: begin
        reg_wen <= 1'b1;
        reg_w_addr <= rd;
        alu_op <= `ALU_ADD;
        alu_src_sel <= `ALU_SRC_IMM_PC;
        imm_gen_op <= `IMM_GEN_U;
      end
      `INST_TYPE_R: begin
        reg_wen <= 1'b1;
        reg_w_addr <= rd;
        reg_r_addr1 <= rs1;
        reg_r_addr2 <= rs2;
        alu_src_sel <= `ALU_SRC_REG;
        case (funct3)
          `INST_ADD_SUB: begin
            alu_op <= (funct7 == `FUNCT7_INST_ADD) ? `ALU_ADD : `ALU_SUB;
          end
          `INST_XOR: begin
            alu_op <= `ALU_XOR;
          end
          `INST_OR: begin
            alu_op <= `ALU_OR; 
          end
          `INST_AND: begin
            alu_op <= `ALU_AND;  
          end
          `INST_SLL: begin
            alu_op <= `ALU_SLL;
          end
          `INST_SRL_SRA: begin
            alu_op <= (funct7 == `FUNCT7_INST_SRL)?`ALU_SRL:`ALU_SRA;
          end
          `INST_SLT: begin
            alu_op <= `ALU_SLT;
          end
          `INST_SLTU: begin
            alu_op <= `ALU_SLTU;
          end
        endcase
      end
    endcase
  end

endmodule
