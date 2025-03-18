add wave x
add wave y
add wave maxCapacity
add wave rest
add wave clk



force x 1
force y 0
force rest 0
force clk 0
run 

force clk 1
force x 1
force y 0
force rest 0
run 

force clk 0
force x 0
force y 1
force rest 0
run 

force clk 1
force x 1
force y 1
force rest 0
run 
