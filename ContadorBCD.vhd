LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ContadorBCD IS
	PORT(	SAIDA		:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
			CLK, RST	:	IN	STD_LOGIC;
			CARRY		:	OUT	STD_LOGIC
			);
END ContadorBCD;

ARCHITECTURE Comportamental OF ContadorBCD IS
	SIGNAL CONTA : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
	SAIDA <= CONTA;
	PROCESS(CLK, RST) 
	BEGIN
		IF RST = '1' THEN
			CONTA <= "0000";
		ELSIF RISING_EDGE(CLK) THEN
			CARRY <= ( CONTA(3)AND NOT CONTA(2) AND NOT CONTA (1) AND CONTA(0));
			IF CONTA = "1001" THEN
				CONTA <= "0000";
				
			ELSE
				CONTA <= CONTA + 1;
			END IF;
		END IF;
  	END PROCESS;
END Comportamental;

