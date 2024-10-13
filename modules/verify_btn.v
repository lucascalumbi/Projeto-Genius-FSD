
module verify_btn(
    output is_right_choice,
    input [2:0] btn,
    input [1:0] current_sequence_number
);

    assign is_right_choice =    (btn[0] && (current_sequence_number == 2'b00)) || 
                                (btn[1] && (current_sequence_number == 2'b01)) || 
                                (btn[2] && (current_sequence_number == 2'b10));

endmodule