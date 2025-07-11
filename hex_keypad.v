module hex_keypad(
    input [3:0] row,
    input s_row,
    input clk,
    input reset,
    output reg [3:0] code,
    output valid,
    output reg [3:0] col
);

    reg [5:0] state, next_state;

    parameter s0 = 6'b000001, 
              s1 = 6'b000010, 
              s2 = 6'b000100, 
              s3 = 6'b001000, 
              s4 = 6'b010000, 
              s5 = 6'b100000;

    assign valid = ((state == s1) || (state == s2) || (state == s3) || (state == s4)) && (|row);

    always @(*) begin
        case ({row, col})
            8'b0001_0001: code = 4'd0;
            8'b0001_0010: code = 4'd1;
            8'b0001_0100: code = 4'd2;
            8'b0001_1000: code = 4'd3;
            8'b0010_0001: code = 4'd4;
            8'b0010_0010: code = 4'd5;
            8'b0010_0100: code = 4'd6;
            8'b0010_1000: code = 4'd7;
            8'b0100_0001: code = 4'd8;
            8'b0100_0010: code = 4'd9;
            8'b0100_0100: code = 4'd10;
            8'b0100_1000: code = 4'd11;
            8'b1000_0001: code = 4'd12;
            8'b1000_0010: code = 4'd13;
            8'b1000_0100: code = 4'd14;
            8'b1000_1000: code = 4'd15;
            default: code = 4'd0;
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= s0;
        else
            state <= next_state;
    end
  
    always @(*) begin
        next_state = state;
        col = 4'b0000;

        case (state)
            s0: begin
                col = 4'b0001;
                next_state = s1;
            end
            s1: begin
                col = 4'b0010;
                if (s_row)
                    next_state = s5;
                else
                    next_state = s2;
            end
            s2: begin
                col = 4'b0100;
                if (s_row)
                    next_state = s5;
                else
                    next_state = s3;
            end
            s3: begin
                col = 4'b1000;
                if (s_row)
                    next_state = s5;
                else
                    next_state = s4;
            end
            s4: begin
                if (s_row)
                    next_state = s5;
                else
                    next_state = s0;
            end
            s5: begin
                next_state = s0;
            end
            default: begin
                next_state = s0;
            end
        endcase
    end

endmodule
