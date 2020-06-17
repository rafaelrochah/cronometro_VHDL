LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY DIV_FREQ IS
	PORT(
		CLK: 	IN STD_LOGIC;
		S320Hz:	OUT	STD_LOGIC;
		S160Hz:	OUT	STD_LOGIC;
		S10Hz:	OUT	STD_LOGIC
		);
END DIV_FREQ;

ARCHITECTURE MISTA OF DIV_FREQ IS

SIGNAL CONTA: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL CNT_BINARIO: STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL RST,CLK_640HZ: STD_LOGIC;

BEGIN

	CLK_640HZ <= CONTA(3); -- Clock de 6.400Hz dividido por 10 para gerar 640Hz
	S320Hz <= CNT_BINARIO(0); -- Saída de 320Hz
	S160Hz <= CNT_BINARIO(1); -- Saída de 160Hz
	S10Hz <= CNT_BINARIO(5); -- Saída de 10Hz

	-- Foi suposto um CLK de 6.400Hz que será dividido por 10
	DIVISOR: PROCESS(CLK,RST)
	BEGIN
		IF RST = '1' THEN
			CONTA <= "0000";
		ELSIF RISING_EDGE(CLK) THEN
			CONTA <= CONTA +1;
		END IF;
	END PROCESS;
	
	-- Gera sinal RST para o contador do divisor a cada 10 pulsos de clock
	GERA_RST: PROCESS(CONTA)
	BEGIN
		IF CONTA = "1010" THEN
			RST <= '1';
		ELSE
			RST <= '0';
		END IF;
	END PROCESS;
	
	-- Contador binário: cada bit de saída, começando do menos significativo, bit 0, possui a frequência
	-- do clock de entrada, no caso, 640Hz, dividida por uma potência de 2 crescente:
	-- Bit 0: 640Hz / 2 = 320Hz
	-- Bit 1: 640Hz / 4 = 160Hz
	-- Bit 2: 640Hz / 8 = 80Hz
	-- Bit 3: 640Hz / 16 = 40Hz
	-- Bit 4: 640Hz / 32 = 20Hz
	-- Bit 5: 640Hz / 64 = 10Hz
	GERA_CLKS: PROCESS(CLK_640HZ)
	BEGIN
		IF RISING_EDGE(CLK_640HZ) THEN
			CNT_BINARIO <= CNT_BINARIO + 1;
		END IF;
	END PROCESS;
	
END;
	