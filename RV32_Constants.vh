// General Definitions
`define ZERO_VECTOR_32 32'h00000000
`define ZERO_VECTOR_5  5'b00000
`define INVALID_INSTRUCTION 32'h0000007F

//invalid vector
`define INVALID_VECTOR 13'b1001000011100

// ALU_OP signal definition
`define ALU_OP_0 3'b000 // execute R-TYPE
`define ALU_OP_2 3'b010 // execute jal
`define ALU_OP_3 3'b011 // addition
`define ALU_OP_7 3'b111 // Branch - Invalid
`define ALU_OP_1 3'b001 // load store

//ALU_CTRL signal definitions
`define ALU_NOP 4'b0000 // No operation in ALU
`define ALU_ADD 4'b0001 // ALU- ADD
`define ALU_SUB 4'b0010 // ALU- SUB
`define ALU_LSHIFT 4'b0011 // ALU - LEFT SHIFT
`define ALU_RSHIFT 4'b0100 // ALU - RIGHT SHIFT
`define ALU_ARSHIFT 4'b0101 // ALU- ARITHMETIC RIGHT SHIFT
`define ALU_AND 4'b0110 // ALU - BITWISE AND
`define ALU_OR 4'b0111 // ALU - BITWISE OR
`define ALU_XOR 4'b1000 // ALU- BITWISE XOR
`define ALU_PASS_B 4'b1001 // ALU- PASS SECOND OPERAND

