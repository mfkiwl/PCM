transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/steven/Desktop/ECE\ 385/fp2/SLC3-M {C:/Users/steven/Desktop/ECE 385/fp2/SLC3-M/TSB.sv}
vlog -sv -work work +incdir+C:/Users/steven/Desktop/ECE\ 385/fp2/SLC3-M {C:/Users/steven/Desktop/ECE 385/fp2/SLC3-M/SLC3_2.sv}
vlog -sv -work work +incdir+C:/Users/steven/Desktop/ECE\ 385/fp2/SLC3-M {C:/Users/steven/Desktop/ECE 385/fp2/SLC3-M/SEXT11.sv}
vlog -sv -work work +incdir+C:/Users/steven/Desktop/ECE\ 385/fp2/SLC3-M {C:/Users/steven/Desktop/ECE 385/fp2/SLC3-M/SEXT9.sv}
vlog -sv -work work +incdir+C:/Users/steven/Desktop/ECE\ 385/fp2/SLC3-M {C:/Users/steven/Desktop/ECE 385/fp2/SLC3-M/SEXT6.sv}
vlog -sv -work work +incdir+C:/Users/steven/Desktop/ECE\ 385/fp2/SLC3-M {C:/Users/steven/Desktop/ECE 385/fp2/SLC3-M/SEXT5.sv}
vlog -sv -work work +incdir+C:/Users/steven/Desktop/ECE\ 385/fp2/SLC3-M {C:/Users/steven/Desktop/ECE 385/fp2/SLC3-M/RegAddrMux.sv}
vlog -sv -work work +incdir+C:/Users/steven/Desktop/ECE\ 385/fp2/SLC3-M {C:/Users/steven/Desktop/ECE 385/fp2/SLC3-M/Reg16.sv}
vlog -sv -work work +incdir+C:/Users/steven/Desktop/ECE\ 385/fp2/SLC3-M {C:/Users/steven/Desktop/ECE 385/fp2/SLC3-M/NZPreg.sv}
vlog -sv -work work +incdir+C:/Users/steven/Desktop/ECE\ 385/fp2/SLC3-M {C:/Users/steven/Desktop/ECE 385/fp2/SLC3-M/Mux4.sv}
vlog -sv -work work +incdir+C:/Users/steven/Desktop/ECE\ 385/fp2/SLC3-M {C:/Users/steven/Desktop/ECE 385/fp2/SLC3-M/Mux2.sv}
vlog -sv -work work +incdir+C:/Users/steven/Desktop/ECE\ 385/fp2/SLC3-M {C:/Users/steven/Desktop/ECE 385/fp2/SLC3-M/ISDU.sv}
vlog -sv -work work +incdir+C:/Users/steven/Desktop/ECE\ 385/fp2/SLC3-M {C:/Users/steven/Desktop/ECE 385/fp2/SLC3-M/ALU.sv}
vlog -sv -work work +incdir+C:/Users/steven/Desktop/ECE\ 385/fp2/SLC3-M {C:/Users/steven/Desktop/ECE 385/fp2/SLC3-M/test_memory.sv}
vlog -sv -work work +incdir+C:/Users/steven/Desktop/ECE\ 385/fp2/SLC3-M {C:/Users/steven/Desktop/ECE 385/fp2/SLC3-M/RegFile.sv}
vlog -sv -work work +incdir+C:/Users/steven/Desktop/ECE\ 385/fp2/SLC3-M {C:/Users/steven/Desktop/ECE 385/fp2/SLC3-M/CPU.sv}
vlib nois_system
vmap nois_system nois_system

vlog -sv -work work +incdir+C:/Users/steven/Desktop/ECE\ 385/fp2 {C:/Users/steven/Desktop/ECE 385/fp2/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L nois_system -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 2000 ns
