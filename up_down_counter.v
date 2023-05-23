module up_down_counter(
  input CLK_50,
  input reset,
  input up_btn,
  input down_btn,
  output [6:0] seg
);

reg [3:0] count;
reg up_btn_prev;
reg down_btn_prev;

always @(posedge CLK_50) begin
  if (reset) begin
    count <= 4'b0000;
  end else begin
    if (up_btn && ~up_btn_prev) begin
      count <= count + 1;
    end else if (down_btn && ~down_btn_prev) begin
      count <= count - 1;
    end
    up_btn_prev <= up_btn;
    down_btn_prev <= down_btn;
  end
end

assign seg = get_segment_display(count);

// helper function to convert a binary value to a seven-segment display code
function [6:0] get_segment_display;
  input [3:0] value;
  case (value)
    4'b0000: get_segment_display = 7'b1000000;
    4'b0001: get_segment_display = 7'b1111001;
    4'b0010: get_segment_display = 7'b0100100;
    4'b0011: get_segment_display = 7'b0110000;
    4'b0100: get_segment_display = 7'b0011001;
    4'b0101: get_segment_display = 7'b0010010;
    4'b0110: get_segment_display = 7'b0000010;
    4'b0111: get_segment_display = 7'b1111000;
    4'b1000: get_segment_display = 7'b0000000;
    4'b1001: get_segment_display = 7'b0010000;
    4'b1010: get_segment_display = 7'b0001000;
    4'b1011: get_segment_display = 7'b0000011;
    4'b1100: get_segment_display = 7'b1000110;
    4'b1101: get_segment_display = 7'b0100001;
    4'b1110: get_segment_display = 7'b0000110;
    4'b1111: get_segment_display = 7'b0001110;
	 default : get_segment_display = 7'b0111111;
  endcase
endfunction

endmodule