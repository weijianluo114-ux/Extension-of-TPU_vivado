-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun Jul 13 05:14:56 2025
-- Host        : Simple running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               E:/electronic2/IC_bisai_jichuangsai/zhon_ke_xin_bei/fensaiqu_chusai/project/RAM_BRIDGE/RAM_BRIDGE_1.4/RAM_BRIDGE_1.4/RAM_BRIDGE_1.4.srcs/sources_1/ip/RAM_A/RAM_A_stub.vhdl
-- Design      : RAM_A
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcvu9p-flga2104-2L-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RAM_A is
  Port ( 
    clka : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 4 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 511 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 511 downto 0 )
  );

end RAM_A;

architecture stub of RAM_A is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,ena,wea[0:0],addra[4:0],dina[511:0],douta[511:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_4_2,Vivado 2018.3";
begin
end;
