# some common required settings for Basys 3 boards
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
set_property IOSTANDARD LVCMOS33 [get_ports -regexp { .* }]

## Clock signal - not needed for unclocked logic
set_property PACKAGE_PIN W5 [get_ports clk]							
create_clock -add -name sys_clk_pin -period 10.0 -waveform {0 5} [get_ports clk]
 				

## LEDs
set_property PACKAGE_PIN U16 [get_ports {Rmaj}]					
set_property PACKAGE_PIN E19 [get_ports {Amaj}]					
set_property PACKAGE_PIN U19 [get_ports {Gmaj}]									
set_property PACKAGE_PIN N3 [get_ports {Rmin}]					
set_property PACKAGE_PIN P1 [get_ports {Amin}]					
set_property PACKAGE_PIN L1 [get_ports {Gmin}]	

## Switches
set_property PACKAGE_PIN V17 [get_ports {switch_sensor}]	