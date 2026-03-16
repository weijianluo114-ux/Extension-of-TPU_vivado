`define AXI_ADDR_WIDTH      29   //AXI地址位宽
`define AXI_DATA_WIDTH      128  //AXI数据位宽
`define AXI_STRB            16   //字节选通
`define AXI_BURST_LEN       4    //突发长度
`define AXI_BURST_SIZE_BYTE 64  //突发传输大小(字节)

`define TOTAL_DATA_NUM      1752   //总的数据量，用于测试，检测bram的数据是否全部读至ddr3中

`define INT4                4
`define INT8                8
`define FP16                16
`define FP32                32
