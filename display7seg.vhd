LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY display7seg IS
	PORT(	SAIDA	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		q0,q1,q2,q3	: IN STD_LOGIC);
END display7Seg;

ARCHITECTURE Comportamental OF display7Seg IS
	SIGNAL CONTA : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
  PROCESS(q0,q1,q2,q3) 
  BEGIN
  conta(0) <= q0;
  conta(1) <= q1;
  conta(2) <= q2;
  conta(3) <= q3;
  end process;
  
PROCESS(CONTA) 
  BEGIN
    CASE CONTA is           -- abcdefg
      WHEN "0000" => SAIDA <= "1111110";
      WHEN "0001" => SAIDA <= "0110000";
      WHEN "0010" => SAIDA <= "1101101";
      WHEN "0011" => SAIDA <= "1111001";
      WHEN "0100" => SAIDA <= "0110011";
      WHEN "0101" => SAIDA <= "1011011";
      WHEN "0110" => SAIDA <= "1011111";
      WHEN "0111" => SAIDA <= "1110000";
      WHEN "1000" => SAIDA <= "1111111";
      WHEN "1001" => SAIDA <= "1110111";
      WHEN OTHERS => SAIDA <= "0000000";
    END CASE;
  END PROCESS;

END Comportamental;