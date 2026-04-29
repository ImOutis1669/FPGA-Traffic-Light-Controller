

# Required settings for Basys 3 boards
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
set_property IOSTANDARD LVCMOS33 [get_ports -regexp { .* }]


 
## Switches
set_property PACKAGE_PIN V17 [get_ports {x}] 				
set_property PACKAGE_PIN V16 [get_ports {y}]					
set_property PACKAGE_PIN W16 [get_ports {cin}]					

## LEDs
set_property PACKAGE_PIN U16 [get_ports {cout}]					
set_property PACKAGE_PIN E19 [get_ports {s}]					

					
	
					

