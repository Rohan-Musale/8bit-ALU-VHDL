library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;

entity ALU_8_TB is
end ALU_8_TB;

architecture TEST of ALU_8_TB is
    
    -- Component Declaration
    component ALU_8
        Port ( A  : in  STD_LOGIC_VECTOR (7 downto 0);
               B  : in  STD_LOGIC_VECTOR (7 downto 0);
               SL : in  STD_LOGIC_VECTOR (2 downto 0);
               Y  : out STD_LOGIC_VECTOR (15 downto 0);
               C  : out STD_LOGIC);
    end component;
    
    -- Signals
    signal A  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal B  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal SL : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal Y  : STD_LOGIC_VECTOR(15 downto 0);
    signal C  : STD_LOGIC;
    
begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: ALU_8 
        port map (
            A  => A,
            B  => B,
            SL => SL,
            Y  => Y,
            C  => C
        );

    -- Stimulus Process
    STIM_PROC: process
    begin
        
        report "========================================";
        report "Starting ALU_8 Testbench";
        report "========================================";
        
        -- Wait for global reset
        wait for 10 ns;
        
        ---------------------------------------
        -- Test Case 1: AND Operation (SL=000)
        ---------------------------------------
        report "Test 1: AND Operation";
        A  <= "11110000";  -- 0xF0 = 240
        B  <= "10101010";  -- 0xAA = 170
        SL <= "000";
        wait for 20 ns;
        assert Y = X"00A0" report "AND Test Failed!" severity error;
        report "A=0xF0, B=0xAA, AND => Y=" & integer'image(to_integer(unsigned(Y)));
        
        ---------------------------------------
        -- Test Case 2: NAND Operation (SL=001)
        ---------------------------------------
        report "Test 2: NAND Operation";
        A  <= "11110000";  -- 0xF0
        B  <= "10101010";  -- 0xAA
        SL <= "001";
        wait for 20 ns;
        assert Y = X"005F" report "NAND Test Failed!" severity error;
        report "A=0xF0, B=0xAA, NAND => Y=" & integer'image(to_integer(unsigned(Y)));
        
        ---------------------------------------
        -- Test Case 3: OR Operation (SL=010)
        ---------------------------------------
        report "Test 3: OR Operation";
        A  <= "11110000";  -- 0xF0
        B  <= "00001111";  -- 0x0F
        SL <= "010";
        wait for 20 ns;
        assert Y = X"00FF" report "OR Test Failed!" severity error;
        report "A=0xF0, B=0x0F, OR => Y=" & integer'image(to_integer(unsigned(Y)));
        
        ---------------------------------------
        -- Test Case 4: NOR Operation (SL=011)
        ---------------------------------------
        report "Test 4: NOR Operation";
        A  <= "11110000";  -- 0xF0
        B  <= "00001111";  -- 0x0F
        SL <= "011";
        wait for 20 ns;
        assert Y = X"0000" report "NOR Test Failed!" severity error;
        report "A=0xF0, B=0x0F, NOR => Y=" & integer'image(to_integer(unsigned(Y)));
        
        ---------------------------------------
        -- Test Case 5: XOR Operation (SL=100)
        ---------------------------------------
        report "Test 5: XOR Operation";
        A  <= "11110000";  -- 0xF0
        B  <= "10101010";  -- 0xAA
        SL <= "100";
        wait for 20 ns;
        assert Y = X"005A" report "XOR Test Failed!" severity error;
        report "A=0xF0, B=0xAA, XOR => Y=" & integer'image(to_integer(unsigned(Y)));
        
        ---------------------------------------
        -- Test Case 6: MULTIPLICATION (SL=101)
        ---------------------------------------
        report "Test 6: Multiplication - Small Numbers";
        A  <= "00001111";  -- 15
        B  <= "00000011";  -- 3
        SL <= "101";
        wait for 20 ns;
        assert Y = X"002D" report "MUL Test 1 Failed!" severity error;
        report "A=15, B=3, MUL => Y=" & integer'image(to_integer(unsigned(Y))) & " (Expected: 45)";
        
        report "Test 7: Multiplication - Medium Numbers";
        A  <= "00010100";  -- 20
        B  <= "00001010";  -- 10
        SL <= "101";
        wait for 20 ns;
        assert Y = X"00C8" report "MUL Test 2 Failed!" severity error;
        report "A=20, B=10, MUL => Y=" & integer'image(to_integer(unsigned(Y))) & " (Expected: 200)";
        
        report "Test 8: Multiplication - Maximum Values";
        A  <= "11111111";  -- 255
        B  <= "11111111";  -- 255
        SL <= "101";
        wait for 20 ns;
        assert Y = X"FE01" report "MUL Test 3 Failed!" severity error;
        report "A=255, B=255, MUL => Y=" & integer'image(to_integer(unsigned(Y))) & " (Expected: 65025)";
        
        report "Test 9: Multiplication - By Zero";
        A  <= "11111111";  -- 255
        B  <= "00000000";  -- 0
        SL <= "101";
        wait for 20 ns;
        assert Y = X"0000" report "MUL by Zero Failed!" severity error;
        report "A=255, B=0, MUL => Y=" & integer'image(to_integer(unsigned(Y))) & " (Expected: 0)";
        
        ---------------------------------------
        -- Test Case 10: ADDITION (SL=110)
        ---------------------------------------
        report "Test 10: Addition - No Carry";
        A  <= "00001111";  -- 15
        B  <= "00000011";  -- 3
        SL <= "110";
        wait for 20 ns;
        assert Y = X"0012" and C = '0' report "ADD Test 1 Failed!" severity error;
        report "A=15, B=3, ADD => Y=" & integer'image(to_integer(unsigned(Y))) & " C=" & std_logic'image(C);
        
        report "Test 11: Addition - With Carry";
        A  <= "11111111";  -- 255
        B  <= "00000001";  -- 1
        SL <= "110";
        wait for 20 ns;
        assert Y = X"0100" and C = '1' report "ADD Test 2 Failed!" severity error;
        report "A=255, B=1, ADD => Y=" & integer'image(to_integer(unsigned(Y))) & " C=" & std_logic'image(C);
        
        report "Test 12: Addition - Maximum Carry";
        A  <= "11111111";  -- 255
        B  <= "11111111";  -- 255
        SL <= "110";
        wait for 20 ns;
        assert Y = X"01FE" and C = '1' report "ADD Test 3 Failed!" severity error;
        report "A=255, B=255, ADD => Y=" & integer'image(to_integer(unsigned(Y))) & " C=" & std_logic'image(C);
        
        ---------------------------------------
        -- Test Case 13: SUBTRACTION (SL=111)
        ---------------------------------------
        report "Test 13: Subtraction - No Borrow";
        A  <= "00001111";  -- 15
        B  <= "00000011";  -- 3
        SL <= "111";
        wait for 20 ns;
        assert Y = X"000C" and C = '0' report "SUB Test 1 Failed!" severity error;
        report "A=15, B=3, SUB => Y=" & integer'image(to_integer(unsigned(Y))) & " C=" & std_logic'image(C);
        
        report "Test 14: Subtraction - With Borrow";
        A  <= "00000011";  -- 3
        B  <= "00001111";  -- 15
        SL <= "111";
        wait for 20 ns;
        assert Y = X"000C" and C = '1' report "SUB Test 2 Failed!" severity error;
        report "A=3, B=15, SUB => Y=" & integer'image(to_integer(unsigned(Y))) & " C(borrow)=" & std_logic'image(C);
        
        report "Test 15: Subtraction - Equal Values";
        A  <= "10101010";  -- 170
        B  <= "10101010";  -- 170
        SL <= "111";
        wait for 20 ns;
        assert Y = X"0000" and C = '0' report "SUB Test 3 Failed!" severity error;
        report "A=170, B=170, SUB => Y=" & integer'image(to_integer(unsigned(Y))) & " C=" & std_logic'image(C);
        
        ---------------------------------------
        -- End of Tests
        ---------------------------------------
        wait for 20 ns;
        report "========================================";
        report "ALU_8 Testbench Completed Successfully!";
        report "========================================";
        
        wait;  -- Stop simulation
        
    end process;

end TEST;
