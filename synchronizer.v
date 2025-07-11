module synchronizer(input[3:0] row, input clk, input reset, output reg s_row);
    reg a_row ; 
    always@(negedge clk or posedge reset)
        begin
          if(reset)
          begin
            a_row <= 0;
            s_row <= 0;
          end

          else 
          begin
            a_row <= (row[0] || row[1] || row[2] || row[3]);
            s_row <= a_row;
          end
        end
endmodule