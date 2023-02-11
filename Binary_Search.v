`timescale 1ns / 1ps
module Binary_Search (
    input      [7:0] IN,
    input            clk,
    input            rst_n,
    input            EN,
    output reg       found,
    output reg       not_found,
    output reg [4:0] OUT
);

    localparam IDLE        = 3'd0;
    localparam LR_COMP     = 3'd1;
    localparam TDOUTA_COMP = 3'd2;
    localparam DONE        = 3'd3;
    localparam WAIT_1      = 3'd4;
    localparam WAIT_2      = 3'd5;

    reg  [4:0] addra;
    wire [7:0] douta;

    blk_mem_gen_0 ROM_INST_0 (
        .clka(clk),         // input wire clka
        .addra(addra[3:0]), // input wire [3 : 0] addra
        .douta(douta)       // output wire [7 : 0] douta
    );

    reg [2:0] current_state;
    reg [2:0] next_state;

    reg [3:0] left;
    reg [3:0] right;

    always @(*) begin
        case (current_state)
            IDLE: begin
                if (EN) next_state = LR_COMP;
                else next_state = IDLE;
            end 

            LR_COMP: begin
                if (left <= right) next_state = WAIT_1;
                else next_state = DONE;
            end

            WAIT_1: begin
                next_state = WAIT_2;
            end

            WAIT_2: begin
                next_state = TDOUTA_COMP;
            end

            TDOUTA_COMP: begin
                if (douta < IN) next_state = LR_COMP;
                else if (douta > IN) next_state = LR_COMP;
                else next_state = DONE;
            end

            DONE: begin
                if (EN) next_state = IDLE;
                else next_state = DONE;
            end

            default: next_state = IDLE;
        endcase
    end

    always @(*) begin
        case (current_state)
            IDLE: begin
                left      = 0;
                right     = 15;
                found     = 0;
                not_found = 0;
                OUT       = 5'b11111;
                addra     = 0;
            end

            LR_COMP: begin
                if (left <= right) addra = (left + right) >> 1;
                else not_found = 1;
            end

            TDOUTA_COMP: begin
                if (douta < IN) left = addra + 1;
                else if (douta > IN) right = addra - 1;
                else found = 1;
            end

            DONE: begin
                if (found) OUT = addra;
            end

            default: begin
                OUT = 5'b11111;
                found = 0;
                not_found = 0;
            end
        endcase
    end

    always @(posedge clk) begin
        if (!rst_n) current_state <= IDLE;
        else current_state <= next_state;
    end

endmodule