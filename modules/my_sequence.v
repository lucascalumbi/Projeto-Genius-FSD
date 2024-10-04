
module my_sequence (
    output reg [1:0] current_number,
    input [3:0] sequence_count,
    input start
);

parameter [1:0] zero = 2'b00;
parameter [1:0] one = 2'b01;
parameter [1:0] two = 2'b10;

reg [1:0] sequence_0;
reg [1:0] sequence_1;
reg [1:0] sequence_2;
reg [1:0] sequence_3;
reg [1:0] sequence_4;
reg [1:0] sequence_5;
reg [1:0] sequence_6;
reg [1:0] sequence_7;
reg [1:0] sequence_8;
reg [1:0] sequence_9;
reg [1:0] sequence_10;
reg [1:0] sequence_11;
reg [1:0] sequence_12;
reg [1:0] sequence_13;
reg [1:0] sequence_14;
reg [1:0] sequence_15;

always @(posedge start) begin 
    sequence_0 <= two;
    sequence_1 <= one;
    sequence_2 <= zero;
    sequence_3 <= one;
    sequence_4 <= zero;
    sequence_5 <= two;
    sequence_6 <= zero;
    sequence_7 <= two;
    sequence_8 <= zero;
    sequence_9 <= one;
    sequence_10 <= zero;
    sequence_11 <= two;
    sequence_12 <= zero;
    sequence_13 <= one;
    sequence_14 <= zero;
    sequence_15 <= one;
end

always @(*) begin
    case (sequence_count)
        4'h0: current_number <= sequence_0;
        4'h1: current_number <= sequence_1;
        4'h2: current_number <= sequence_2;
        4'h3: current_number <= sequence_3;
        4'h4: current_number <= sequence_4;
        4'h5: current_number <= sequence_5;
        4'h6: current_number <= sequence_6;
        4'h7: current_number <= sequence_7;
        4'h8: current_number <= sequence_8;
        4'h9: current_number <= sequence_9;
        4'hA: current_number <= sequence_10;
        4'hB: current_number <= sequence_11;
        4'hC: current_number <= sequence_12;
        4'hD: current_number <= sequence_13;
        4'hE: current_number <= sequence_14;
        4'hF: current_number <= sequence_15;
        default: current_number <= 2'b00; 
    endcase
end

endmodule