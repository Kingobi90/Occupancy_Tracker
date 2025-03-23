# Room Occupancy Tracker System

## High-Level Specification

The system is designed to track and monitor room occupancy using two photocell sensors:
- **Entry Sensor**: Detects people entering the room
- **Exit Sensor**: Detects people leaving the room

Key Features:
- 8-bit programmable maximum occupancy threshold
- Real-time occupancy count
- Max capacity indicator signal
- System reset functionality

## Design Methodology

### Architecture
1. **Inputs**:
   - clk: System clock
   - rst: Asynchronous reset
   - entry_sensor: Photocell input for entry detection
   - exit_sensor: Photocell input for exit detection
   - max_occupancy[7:0]: Maximum occupancy threshold

2. **Outputs**:
   - max_capacity: Indicates when room is at maximum capacity

### Implementation Details
- **State Management**: Uses an 8-bit unsigned counter for occupancy tracking
- **Edge Detection**: Processes sensor inputs on clock rising edges
- **Safety Features**: Prevents underflow and overflow of occupancy count

## Simulation and Synthesis

### Test Cases
1. Normal operation (entries and exits)
2. Maximum capacity detection
3. System reset functionality
4. Boundary conditions (zero occupancy, max occupancy)

### Expected Results
- Correct occupancy count maintenance
- Accurate max_capacity signal assertion
- Proper reset behavior

## Documentation Structure
1. **Design Specifications**: Detailed system requirements
2. **Implementation Details**: VHDL code explanation
3. **Test Plan**: Simulation strategy and test cases
4. **Results**: Simulation waveforms and analysis
5. **Conclusion**: System performance evaluation
