import os

out_file_name = "a.out"

vcd_file_name = "wtf.vcd"

for dirpath, _, fname in os.walk("./", topdown=False):
    if out_file_name in fname:
        os.remove(os.path.join(dirpath, out_file_name))
    if vcd_file_name in fname:
        os.remove(vcd_file_name)

ctrl_and_d = chr(4)
os.system("iverilog -o ./Build/a.out ./Tb/tb.v & vvp -n ./Build/a.out & gtkwave ./sim_out.vcd")

