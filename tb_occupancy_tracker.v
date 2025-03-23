`timescale 1ns/1ps

module tb_occupancy_tracker;

  reg clk;
  reg rst;
  reg entry_sensor;
  reg exit_sensor;
  reg [7:0] max_occupancy;
  wire max_capacity;

  // Instantiate the DUT
  occupancy_tracker dut (
    .clk(clk),
    .rst(rst),
    .entry_sensor(entry_sensor),
    .exit_sensor(exit_sensor),
    .max_occupancy(max_occupancy),
    .max_capacity(max_capacity)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    // Initialize signals
    clk = 0;
    rst = 1;
    entry_sensor = 0;
    exit_sensor = 0;
    max_occupancy = 8'd10;

    // Reset the system
    #20;
    rst = 0;

    // Test case 1: Normal operation
    repeat(5) begin
      #10 entry_sensor = 1;
      #10 entry_sensor = 0;
    end

    // Test case 2: Exit operation
    repeat(3) begin
      #10 exit_sensor = 1;
      #10 exit_sensor = 0;
    end

    // Test case 3: Max capacity
    repeat(10) begin
      #10 entry_sensor = 1;
      #10 entry_sensor = 0;
    end

    // Test case 4: Reset
    #20;
    rst = 1;
    #20;
    rst = 0;

    // Finish simulation
    #100;
    $finish;
  end

endmodule
