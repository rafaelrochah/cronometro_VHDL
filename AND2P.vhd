LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity AND2P is
port(
    A		: in	std_logic;
    B		: IN	 std_logic;
    C		: OUT	STD_LOGIC
    );
    
end AND2P;

architecture FLUXO of AND2P is
begin

	C <= A AND B;
END FLUXO;