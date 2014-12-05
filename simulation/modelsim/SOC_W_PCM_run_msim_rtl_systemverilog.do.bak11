transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Thomas/Documents/ECE385/finalProj {C:/Users/Thomas/Documents/ECE385/finalProj/PCM_MM_reg.sv}
vlog -sv -work work +incdir+C:/Users/Thomas/Documents/ECE385/finalProj/nois_system/synthesis {C:/Users/Thomas/Documents/ECE385/finalProj/nois_system/synthesis/SOC_W_PCM.sv}
vlib nois_system
vmap nois_system nois_system

vlog -sv -work work +incdir+C:/Users/Thomas/Documents/ECE385/finalProj {C:/Users/Thomas/Documents/ECE385/finalProj/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L nois_system -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 2000 ns
