module occupancy_tracker(
  input clk,
  input rst,
  input entry_sensor,
  input exit_sensor,
  input [7:0] max_occupancy,
  output reg max_capacity
);

  reg [7:0] current_occupancy = 8'd0;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      current_occupancy <= 8'd0;
      max_capacity <= 1'b0;
    end else begin
      // Handle entry
      if (entry_sensor && current_occupancy < max_occupancy) begin
        current_occupancy <= current_occupancy + 8'd1;
      end

      // Handle exit
      if (exit_sensor && current_occupancy > 8'd0) begin
        current_occupancy <= current_occupancy - 8'd1;
      end

      // Update max capacity status
      max_capacity <= (current_occupancy >= max_occupancy);
    end
  end

endmodule
