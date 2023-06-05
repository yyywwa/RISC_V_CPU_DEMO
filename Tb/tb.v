// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : tb_rvseed.v
// Author        : Rongye
// Created On    : 2022-03-25 04:18
// Last Modified : 2022-04-11 19:34
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// -FHDR----------------------------------------------------------------------------
`timescale 1ns / 1ps
`include "./Tb/rvseed.v"

module tb_rvseed ();

reg                  clk;
reg                  rst_n;

// register file
wire [`REG_WIDTH-1:0] zero_x0  = u_rvseed_0. u_reg_file_0. all_reg[0];
wire [`REG_WIDTH-1:0] ra_x1    = u_rvseed_0. u_reg_file_0. all_reg[1];
wire [`REG_WIDTH-1:0] sp_x2    = u_rvseed_0. u_reg_file_0. all_reg[2];
wire [`REG_WIDTH-1:0] gp_x3    = u_rvseed_0. u_reg_file_0. all_reg[3];
wire [`REG_WIDTH-1:0] tp_x4    = u_rvseed_0. u_reg_file_0. all_reg[4];
wire [`REG_WIDTH-1:0] t0_x5    = u_rvseed_0. u_reg_file_0. all_reg[5];
wire [`REG_WIDTH-1:0] t1_x6    = u_rvseed_0. u_reg_file_0. all_reg[6];
wire [`REG_WIDTH-1:0] t2_x7    = u_rvseed_0. u_reg_file_0. all_reg[7];
wire [`REG_WIDTH-1:0] s0_fp_x8 = u_rvseed_0. u_reg_file_0. all_reg[8];
wire [`REG_WIDTH-1:0] s1_x9    = u_rvseed_0. u_reg_file_0. all_reg[9];
wire [`REG_WIDTH-1:0] a0_x10   = u_rvseed_0. u_reg_file_0. all_reg[10];
wire [`REG_WIDTH-1:0] a1_x11   = u_rvseed_0. u_reg_file_0. all_reg[11];
wire [`REG_WIDTH-1:0] a2_x12   = u_rvseed_0. u_reg_file_0. all_reg[12];
wire [`REG_WIDTH-1:0] a3_x13   = u_rvseed_0. u_reg_file_0. all_reg[13];
wire [`REG_WIDTH-1:0] a4_x14   = u_rvseed_0. u_reg_file_0. all_reg[14];
wire [`REG_WIDTH-1:0] a5_x15   = u_rvseed_0. u_reg_file_0. all_reg[15];
wire [`REG_WIDTH-1:0] a6_x16   = u_rvseed_0. u_reg_file_0. all_reg[16];
wire [`REG_WIDTH-1:0] a7_x17   = u_rvseed_0. u_reg_file_0. all_reg[17];
wire [`REG_WIDTH-1:0] s2_x18   = u_rvseed_0. u_reg_file_0. all_reg[18];
wire [`REG_WIDTH-1:0] s3_x19   = u_rvseed_0. u_reg_file_0. all_reg[19];
wire [`REG_WIDTH-1:0] s4_x20   = u_rvseed_0. u_reg_file_0. all_reg[20];
wire [`REG_WIDTH-1:0] s5_x21   = u_rvseed_0. u_reg_file_0. all_reg[21];
wire [`REG_WIDTH-1:0] s6_x22   = u_rvseed_0. u_reg_file_0. all_reg[22];
wire [`REG_WIDTH-1:0] s7_x23   = u_rvseed_0. u_reg_file_0. all_reg[23];
wire [`REG_WIDTH-1:0] s8_x24   = u_rvseed_0. u_reg_file_0. all_reg[24];
wire [`REG_WIDTH-1:0] s9_x25   = u_rvseed_0. u_reg_file_0. all_reg[25];
wire [`REG_WIDTH-1:0] s10_x26  = u_rvseed_0. u_reg_file_0. all_reg[26];
wire [`REG_WIDTH-1:0] s11_x27  = u_rvseed_0. u_reg_file_0. all_reg[27];
wire [`REG_WIDTH-1:0] t3_x28   = u_rvseed_0. u_reg_file_0. all_reg[28];
wire [`REG_WIDTH-1:0] t4_x29   = u_rvseed_0. u_reg_file_0. all_reg[29];
wire [`REG_WIDTH-1:0] t5_x30   = u_rvseed_0. u_reg_file_0. all_reg[30];
wire [`REG_WIDTH-1:0] t6_x31   = u_rvseed_0. u_reg_file_0. all_reg[31];

integer r;
initial begin
    wait(s10_x26 == 32'b1)   // wait sim end, when x26 == 1
        #(`SIM_PERIOD * 1 + 1)
        if (s11_x27 == 32'b1) begin
            $display("~~~~~~~~~~~~~~~~~~~ %s PASS ~~~~~~~~~~~~~~~~~~~","CMD");
            #(`SIM_PERIOD * 1);
        end 
        else begin
            $display("~~~~~~~~~~~~~~~~~~~ %s FAIL ~~~~~~~~~~~~~~~~~~~~","CMD");
            $display("fail testnum = %2d", gp_x3);
            #(`SIM_PERIOD * 1);
            $stop;
            for (r = 0; r < 32; r = r + 1)
                $display("x%2d = 0x%x", r, u_rvseed_0. u_reg_file_0. all_reg[r]);
        end
end

initial begin
    #(`SIM_PERIOD/2);
    clk       = 1'b0;
    rst_n     = 1'b0;

    inst_load;
    
    #(`SIM_PERIOD * 1);
    rst_n = 1'b1;
    #(`SIM_PERIOD * 100);
    $stop;
end

initial begin
    #(`SIM_PERIOD * 50000);
    $display("Time Out");
    $finish;
end

always #(`SIM_PERIOD/2) clk = ~clk;

task reset;                // reset 1 clock
    begin
        rst_n = 0; 
        #(`SIM_PERIOD * 1);
        rst_n = 1;
    end
endtask

task inst_load;
    begin
        $readmemh ("./Tb/dump", u_rvseed_0. u_inst_mem_0.all_inst);
    end
endtask

rvseed u_rvseed_0(
    .clk                            ( clk                           ),
    .rst_n                          ( rst_n                         )
);

// iverilog 
initial begin
    $dumpfile("sim_out.vcd");
    $dumpvars;
end

endmodule
