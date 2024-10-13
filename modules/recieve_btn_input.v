
module recieve_btn_input(
    output was_some_btn_pressed,
    output was_right_btn_pressed,
    input [2:0] btn,
    input [1:0] current_sequence_number
);

verify_btn verify0(
    .is_right_choice(was_right_btn_pressed),
    .btn(btn),
    .current_sequence_number(current_sequence_number)
);
    assign was_some_btn_pressed = btn[0] + btn[1] + btn[2];


endmodule

