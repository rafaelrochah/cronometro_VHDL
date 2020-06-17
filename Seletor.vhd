LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity Seletor is
port(
    clk		: in std_logic; 
    C0		: OUT std_logic;
	C1		: OUT std_logic;
	T1		: OUT std_logic;
	T2		: OUT std_logic;
	T3		: OUT std_logic;
	T4		: OUT std_logic
	);
    
end Seletor;

architecture Structural of Seletor is

SIGNAL     q		:  std_logic_vector(1 downto 0);

begin
	

process(clk)
	variable contagem : integer range 0 to 4;
begin

	if(rising_edge(clk))then
		contagem := contagem +1; 

	end if;
	q <= conv_std_logic_vector (contagem,2);
	C0 <=q(0);
	C1 <=q(1);
	T1 <= NOT(Q(1)) AND NOT (Q(0));
	T2 <= NOT(Q(1)) AND     (Q(0));
	T3 <=    (Q(1)) AND NOT (Q(0));
	T4 <=    (Q(1)) AND     (Q(0));
	
end process;

end Structural;