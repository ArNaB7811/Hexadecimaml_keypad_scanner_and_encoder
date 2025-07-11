// `timescale 1ns/1ps
`include "hex_keypad.v" 
`include "row_signal.v" 
`include "synchronizer.v"
module testbench_hex_keypad;
wire [3:0]code;
wire valid, s_row;
wire [3:0] col;
wire [3:0] row;
reg clk, reset;
reg [15:0] key;
reg [39:0] pressed;
parameter [39:0] key_0 = "key_0";
parameter [39:0] key_1 = "key_1";
parameter [39:0] key_2 = "key_2";
parameter [39:0] key_3 = "key_3";
parameter [39:0] key_4 = "key_4";
parameter [39:0] key_5 = "key_5";
parameter [39:0] key_6 = "key_6";
parameter [39:0] key_7 = "key_7";
parameter [39:0] key_8 = "key_8";
parameter [39:0] key_9 = "key_9";
parameter [39:0] key_A = "key_A";
parameter [39:0] key_B = "key_B";
parameter [39:0] key_C = "key_C";
parameter [39:0] key_D = "key_D";
parameter [39:0] key_E = "key_E";
parameter [39:0] key_F = "key_F";
parameter [39:0] None = "None";

integer j, k;

always@(key)
begin
  case(key)
  16'h0000: pressed = None;
  16'h0001: pressed = key_0;
  16'h0002: pressed = key_1;
  16'h0004: pressed = key_2;
  16'h0008: pressed = key_3;
  16'h0010: pressed = key_4;
  16'h0020: pressed = key_5;
  16'h0040: pressed = key_6;
  16'h0080: pressed = key_7;
  16'h0100: pressed = key_8;
  16'h0200: pressed = key_9;
  16'h0400: pressed = key_A;
  16'h0800: pressed = key_B;
  16'h1000: pressed = key_C;
  16'h2000: pressed = key_D;
  16'h4000: pressed = key_E;
  16'h8000: pressed = key_F;
  default: pressed = None;
endcase
end 

  hex_keypad m1(row, s_row, clk, reset, code,valid,col);
  Row_signal m2(key,col,row);
  synchronizer m3(row,clk,reset,s_row);


initial #5000 $finish;
initial
begin
  clk = 0; 
  forever #5 clk = ~clk;
end
initial 
begin
  reset = 1; 
  #10 reset = 0;
end
initial 
begin
  for(k = 0; k<=1;k = k+1)
  begin
    key = 0;
    #20
    for(j = 0; j<=16; j = j+1)
    begin
      #20 key[j] = 1;
      #60 key = 0;
    end
  end
end

initial
    begin
        $dumpfile("testbench_hex_keypad.vcd");
        $dumpvars(-1,testbench_hex_keypad);
        $display("%b", clk);
    end
endmodule


