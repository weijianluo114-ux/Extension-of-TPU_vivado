`define MATRIXSIZE 16    // 矩阵维度 16x16

`define INPUTWIDTH 8    // 输入数据位宽（16位有符号数）int8
`define INADDRWIDTH 4    // 输入矩阵地址位宽（可寻址16个元素）

`define OUTPUTWIDTH 32   // 输出数据位宽（32位有符号数）int32
`define OUTADDRWIDTH 8   // 输出矩阵地址位宽（可寻址256个元素）

`define EXECYCLE 262     // 完整矩阵乘法所需的时钟周期数