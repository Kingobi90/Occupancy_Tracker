# Load the compiled design
vsim work.project

# Add signals to the waveform window
add wave x
add wave y
add wave m
add wave maxCapacity
add wave rest
add wave clk
add wave occupancyCount

# Apply initial values and run simulation
force x 0
force y 0
force rest 0
force clk 0
force m 5  # Example: Set max capacity to 5
run 10ns

# Clock cycle 1: Person enters
force clk 1
force x 1
force y 0
run 10ns

# Clock cycle 2: Person enters
force clk 0
run 10ns
force clk 1
run 10ns

# Clock cycle 3: Person exits
force clk 0
force x 0
force y 1
run 10ns
force clk 1
run 10ns

# Clock cycle 4: Room gets full
force clk 0
force x 1
force y 0
run 10ns
force clk 1
run 10ns
force clk 0
force x 1
run 10ns
force clk 1
run 10ns
force clk 0
force x 1
run 10ns
force clk 1
run 10ns
force clk 0
force x 1
run 10ns
force clk 1
run 10ns

# Room should now be full (maxCapacity = 1)
force clk 0
run 10ns

# Reset system
force rest 1
run 10ns
force clk 1
run 10ns
force clk 0
force rest 0
run 10ns

# End simulation
quit -sim
