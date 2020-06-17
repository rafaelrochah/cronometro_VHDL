LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.std_logic_arith.all;

LIBRARY WORK;
USE WORK.ALL;

ENTITY exp6 IS
PORT
	(
	ENTRADA		: 	IN	STD_LOGIC;
	CLOCK		:	IN	STD_LOGIC;
	ZERA		:	IN	STD_LOGIC;
	SAIDA		:	OUT	STD_LOGIC_VECTOR ( 6 DOWNTO 0 );
	T1			:	OUT	STD_LOGIC;
	T2			:	OUT	STD_LOGIC;
	T3			:	OUT	STD_LOGIC;
	T4			:	OUT	STD_LOGIC
	);

END exp6;

ARCHITECTURE MISTA OF EXP6 IS 

COMPONENT DIV_FREQ is
	PORT(
		CLK: 	IN STD_LOGIC;
		S320Hz:	OUT	STD_LOGIC;
		S160Hz:	OUT	STD_LOGIC;
		S10Hz:	OUT	STD_LOGIC
		);
end component;

COMPONENT Debouncer is
	PORT(
		CLK		: in STD_LOGIC;
		CHAVE		: in STD_LOGIC;
		SAIDA		: out STD_LOGIC
		);
end COMPONENT;

COMPONENT FlipFlop is

	PORT(	saida	: buffer	STD_LOGIC;
			CLK		: IN	STD_LOGIC
			);

END COMPONENT;

COMPONENT ContadorBCD is

	PORT(	CLK, RST	:	IN	STD_LOGIC;
			SAIDA		:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
			CARRY		:	OUT	STD_LOGIC
			);
end COMPONENT;

COMPONENT ContadorBCD6 IS
	PORT(
			CLK, RST	:	IN	STD_LOGIC;
			SAIDA		:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
			CARRY		:	OUT	STD_LOGIC
			);
end COMPONENT;

COMPONENT MUX_4_1 IS
	PORT
	(
		B1 	:	IN	STD_LOGIC;
		B2 	:	IN	STD_LOGIC;
		B3	:	IN	STD_LOGIC;
		B4	:	IN	STD_LOGIC;
		C1	: 	IN	STD_LOGIC;
		C2	:	IN	STD_LOGIC;
		S	:	OUT	STD_LOGIC
	);
END COMPONENT;

component Seletor is
port(
    clk		: in std_logic; 
    C0		: OUT std_logic;
	C1		: OUT std_logic;
	T1		: OUT std_logic;
	T2		: OUT std_logic;
	T3		: OUT std_logic;
	T4		: OUT std_logic
	);
    
end component;

COMPONENT AND2P is
port(
    A		: in	std_logic;
    B		: IN	 std_logic;
    C		: OUT	STD_LOGIC
    );
    
end COMPONENT;



COMPONENT display7seg IS
	PORT(	q0,q1,q2,q3	: IN STD_LOGIC;
			SAIDA	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
		
END component;




signal centesimo: std_logic_vector ( 3 downto 0);
signal unidade	: std_logic_vector ( 3 downto 0);
signal dezena	: std_logic_vector ( 3 downto 0);
signal minuto	: std_logic_vector ( 3 downto 0);
signal saida320, saida160, saida10, saida_debounce, saida_and, carry_centesimo, carry_unidade, carry_dezena, carry, flip, saida_flipflop, q0, q1, q2, q3, c0, c1 : std_logic;

begin

	DIVISOR		:	Div_Freq		PORT MAP	(CLOCK, saida320, saida160, saida10);
	Debouncer	:	Debouncer		PORT MAP	(saida320, ENTRADA,saida_debounce);
	--and1		:	AND2P			PORT MAP	(saida10, flip, saida_and);
	cent		:	ContadorBCD 	PORT MAP	(saida_and, ZERA, centesimo (3 downto 0),carry_centesimo);
	uni		:	ContadorBCD 	PORT MAP	(carry_centesimo, ZERA, unidade (3 downto 0), carry_unidade);
	deze		:	ContadorBCD6	PORT MAP	(carry_unidade, ZERA, dezena (3 downto 0),carry_dezena);
	minu		:	ContadorBCD 	PORT MAP	(carry_dezena, ZERA, minuto (3 downto 0),carry);
	FlipFlop1	:	FlipFlop		PORT MAP	(saida_debounce, saida_flipflop);
	INT0		:	AND2P			PORT MAP	(SAIDA10, saida_flipflop, saida_and);
	MUX0		:	MUX_4_1			PORT MAP	(CENTESIMO(0), UNIDADE(0), DEZENA(0), MINUTO(0), C0,C1, Q0);
	MUX1		:	MUX_4_1			PORT MAP	(CENTESIMO(1), UNIDADE(1), DEZENA(1), MINUTO(1), C0,C1, Q1);
	MUX2		:	MUX_4_1			PORT MAP	(CENTESIMO(2), UNIDADE(2), DEZENA(2), MINUTO(2), C0,C1, Q2);
	MUX3		:	MUX_4_1			PORT MAP	(CENTESIMO(3), UNIDADE(3), DEZENA(3), MINUTO(3), C0,C1, Q3);
	SELETOR		:	Seletor			PORT MAP	(SAIDA160, C0, C1, T1, T2, T3, T4);
	DISPLAY		:	display7Seg		PORT MAP	(q0,q1,q2,q3, saida(6 downto 0));
	
	--FLIP <= conv_std_logic (saida_flipflop);
	--saida_and <= saida10 and saida_flipflop;
	
END MISTA;