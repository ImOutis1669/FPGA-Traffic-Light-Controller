# some common required settings for Basys 3 boards
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
set_property IOSTANDARD LVCMOS33 [get_ports -regexp { .* }]

## Clock signal - not needed for unclocked logic
set_property PACKAGE_PIN W5 [get_ports clk]							
create_clock -add -name sys_clk_pin -period 10.0 -waveform {0 5} [get_ports clk]
 
## LEDs
set_property PACKAGE_PIN U16 [get_ports {LED0}]					
set_property PACKAGE_PIN E19 [get_ports {LED1}]					
set_property PACKAGE_PIN U19 [get_ports {LED2}]					
set_property PACKAGE_PIN V19 [get_ports {LED3}]					
set_property PACKAGE_PIN W18 [get_ports {LED4}]					
set_property PACKAGE_PIN U15 [get_ports {LED5}]					
set_property PACKAGE_PIN U14 [get_ports {LED6}]					
set_property PACKAGE_PIN V14 [get_ports {LED7}]					
set_property PACKAGE_PIN V13 [get_ports {LED8}]					
set_property PACKAGE_PIN V3 [get_ports {LED9}]
set_property PACKAGE_PIN W3 [get_ports {LED10}]						
set_property PACKAGE_PIN U3 [get_ports {LED11}]					
set_property PACKAGE_PIN P3 [get_ports {LED12}]					
set_property PACKAGE_PIN N3 [get_ports {LED13}]					
set_property PACKAGE_PIN P1 [get_ports {LED14}]					
set_property PACKAGE_PIN L1 [get_ports {LED15}]					

###Buttons
set_property PACKAGE_PIN U18 [get_ports btn]						
set_property PACKAGE_PIN T18 [get_ports RESET]						
					
	
				


