module my_sequence (
    output reg [1:0] current_number,
    input [3:0] sequence_count,
    input clk,
    input start,
    input [3:0]sw
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
    if (sw[0]) begin
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
    else if (sw[1]) begin 
    sequence_0 <= two;
    sequence_1 <= one;
    sequence_2 <= zero;
    sequence_3 <= two;
    sequence_4 <= one;
    sequence_5 <= zero;
    sequence_6 <= two;
    sequence_7 <= one;
    sequence_8 <= one;
    sequence_9 <= zero;
    sequence_10 <= two;
    sequence_11 <= zero;
    sequence_12 <= one;
    sequence_13 <= two;
    sequence_14 <= zero;
    sequence_15 <= one;
    end
    else if (sw[2]) begin 
    sequence_0 <= zero;
    sequence_1 <= two;
    sequence_2 <= one;
    sequence_3 <= zero;
    sequence_4 <= two;
    sequence_5 <= one;
    sequence_6 <= one;
    sequence_7 <= two;
    sequence_8 <= zero;
    sequence_9 <= one;
    sequence_10 <= zero;
    sequence_11 <= two;
    sequence_12 <= one;
    sequence_13 <= zero;
    sequence_14 <= two;
    sequence_15 <= one;
    end
    else begin 
    sequence_0 <= two;
    sequence_1 <= one;
    sequence_2 <= zero;
    sequence_3 <= two;
    sequence_4 <= zero;
    sequence_5 <= one;
    sequence_6 <= one;
    sequence_7 <= two;
    sequence_8 <= zero;
    sequence_9 <= two;
    sequence_10 <= one;
    sequence_11 <= zero;
    sequence_12 <= zero;
    sequence_13 <= two;
    sequence_14 <= one;
    sequence_15 <= two;
    end
/*    else if (sw[4]) begin
    sequence_0 <= one;
    sequence_1 <= two;
    sequence_2 <= zero;
    sequence_3 <= one;
    sequence_4 <= two;
    sequence_5 <= zero;
    sequence_6 <= one;
    sequence_7 <= zero;
    sequence_8 <= two;
    sequence_9 <= one;
    sequence_10 <= two;
    sequence_11 <= zero;
    sequence_12 <= one;
    sequence_13 <= two;
    sequence_14 <= zero;
    sequence_15 <= one;
    end
    else begin
    sequence_0 <= two;
    sequence_1 <= zero;
    sequence_2 <= one;
    sequence_3 <= two;
    sequence_4 <= one;
    sequence_5 <= zero;
    sequence_6 <= zero;
    sequence_7 <= one;
    sequence_8 <= two;
    sequence_9 <= zero;
    sequence_10 <= one;
    sequence_11 <= two;
    sequence_12 <= zero;
    sequence_13 <= one;
    sequence_14 <= two;
    sequence_15 <= zero;
    end*/
end

always @(posedge clk) begin
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