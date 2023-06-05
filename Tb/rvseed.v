// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : rvseed.v
// Author        : Rongye
// Created On    : 2022-03-25 03:42
// Last Modified : 2022-04-12 19:57
// ---------------------------------------------------------------------------------
// Description   : rvseed cpu top module.
//                 
//
// -FHDR----------------------------------------------------------------------------
`include "Core\\ALL.v"

module rvseed (
    input clk,
    input rst_n
);

  wire                         ena;
  wire [       `CPU_WIDTH-1:0] curr_pc;  // current pc addr
  wire [       `CPU_WIDTH-1:0] next_pc;  // next pc addr

  wire [    `FUNCT3_WIDTH-1:0] branch;  // branch flag
  wire                         zero;  // alu result is zero
  wire                         jump;  // jump flag

  wire [       `CPU_WIDTH-1:0] inst;  // instruction

  wire                         reg_wen;  // register write enable
  wire [  `REG_ADDR_WIDTH-1:0] reg_waddr;  // register write address
  wire [       `CPU_WIDTH-1:0] reg_wdata;  // register write data
  wire [  `REG_ADDR_WIDTH-1:0] reg1_raddr;  // register 1 read address
  wire [  `REG_ADDR_WIDTH-1:0] reg2_raddr;  // register 2 read address
  wire [       `CPU_WIDTH-1:0] reg1_rdata;  // register 1 read data
  wire [       `CPU_WIDTH-1:0] reg2_rdata;  // register 2 read data

  wire [`IMM_GEN_OP_WIDTH-1:0] imm_gen_op;  // immediate extend opcode
  wire [       `CPU_WIDTH-1:0] imm;  // immediate

  wire [    `ALU_OP_WIDTH-1:0] alu_op;  // alu opcode
  wire [   `ALU_SRC_WIDTH-1:0] alu_src_sel;  // alu source select flag
  wire [       `CPU_WIDTH-1:0] alu_src1;  // alu source 1
  wire [       `CPU_WIDTH-1:0] alu_src2;  // alu source 2
  wire [       `CPU_WIDTH-1:0] alu_res;  // alu result

  assign reg_wdata = alu_res;

  pc_reg u_pc_reg_0 (
      .clk    (clk),
      .rst_n  (rst_n),
      .next_pc(next_pc),
      .pc     (curr_pc)
  );

  mux_pc u_mux_pc_0 (
      .branch_op(branch),
      .zero     (zero),
      .jump     (jump),
      .imm      (imm),
      .pc       (curr_pc),
      .next_pc  (next_pc)
  );

  inst_mem u_inst_mem_0 (
      .pc(curr_pc),
      .ir(inst)
  );

  ctrl u_ctrl_0 (
      .ir         (inst),
      .branch_op  (branch),
      .jump       (jump),
      .reg_wen    (reg_wen),
      .reg_r_addr1(reg1_raddr),
      .reg_r_addr2(reg2_raddr),
      .reg_w_addr (reg_waddr),
      .imm_gen_op (imm_gen_op),
      .alu_op     (alu_op),
      .alu_src_sel(alu_src_sel)
  );

  reg_file u_reg_file_0 (
      .clk        (clk),
      .reg_wen    (reg_wen),
      .reg_w_addr (reg_waddr),
      .reg_w_data (reg_wdata),
      .reg_r_addr1(reg1_raddr),
      .reg_r_addr2(reg2_raddr),
      .reg_r_data1(reg1_rdata),
      .reg_r_data2(reg2_rdata)
  );

  imm_gen u_imm_gen_0 (
      .ir        (inst),
      .imm_gen_op(imm_gen_op),
      .imm       (imm)
  );

  mux_alu u_mux_alu_0 (
      .alu_src_sel(alu_src_sel),
      .reg_r_data1 (reg1_rdata),
      .reg_r_data2 (reg2_rdata),
      .imm        (imm),
      .pc         (curr_pc),
      .alu_src1   (alu_src1),
      .alu_src2   (alu_src2)
  );

  alu u_alu_0 (
      .alu_op  (alu_op),
      .alu_src1(alu_src1),
      .alu_src2(alu_src2),
      .zero    (zero),
      .alu_res (alu_res)
  );


endmodule
