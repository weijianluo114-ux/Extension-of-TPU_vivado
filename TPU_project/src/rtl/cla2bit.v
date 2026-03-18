/*模块说明

该模块是一个2位超前进位加法器

*/
module cla2bit (
    input  [1:0] a,    // 加数A
    input  [1:0] b,    // 加数B
    input        cin,  // 进位输入
    output [1:0] s,    // 和
    output       cout  // 进位输出
);

  /*************************************** 信号 ********************************/
  // 生成（generate）和传播（propagate）信号
  wire [1:0] g;
  wire [1:0] p;

  // 进位计算
  wire c;

  /****************************************** 组合逻辑 ****************************************/
  assign g = a & b;
  assign p = a ^ b;

  // 第1位（最低位）产生的进位
  assign c = g[0] | (p[0] & cin);
  assign cout = g[1] | (p[1] & c);

  // 和计算
  assign s[0] = p[0] ^ cin;
  assign s[1] = p[1] ^ c;

endmodule
