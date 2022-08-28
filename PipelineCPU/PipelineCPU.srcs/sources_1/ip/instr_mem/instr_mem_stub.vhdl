-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Sun Aug 28 17:15:47 2022
-- Host        : DESKTOP-52COAKC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               e:/synchronization/4-1/CPU/team/PipelineCPU/PipelineCPU.srcs/sources_1/ip/instr_mem/instr_mem_stub.vhdl
-- Design      : instr_mem
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity instr_mem is
  Port ( 
    a : in STD_LOGIC_VECTOR ( 9 downto 0 );
    spo : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end instr_mem;

architecture stub of instr_mem is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "a[9:0],spo[31:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "dist_mem_gen_v8_0_13,Vivado 2019.2";
begin
end;
