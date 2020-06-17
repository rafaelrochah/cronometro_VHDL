LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY flipflop IS
	PORT(	saida	: buffer	STD_LOGIC;
			CLK		: IN	STD_LOGIC
			);
end flipflop;
 
 ARCHITECTURE comportamental OF flipflop is

begin		
	process (CLK)
	begin
	--variable saida1 : 
	if rising_edge(CLK) then
		saida <= not (saida);
	end if; 
	end process;
end comportamental;