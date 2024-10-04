
module recieve_btn_input(
    output was_some_btn_pressed,
    input [2:0] btn
);

    assign was_some_btn_pressed = btn[0] || btn[1] || btn[2];

endmodule

