library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_8 is
    Port ( A  : in  STD_LOGIC_VECTOR (7 downto 0);
           B  : in  STD_LOGIC_VECTOR (7 downto 0);
           SL : in  STD_LOGIC_VECTOR (2 downto 0);
           Y  : out STD_LOGIC_VECTOR (15 downto 0);
           C  : out STD_LOGIC);
end ALU_8;

architecture ALU_ARCH of ALU_8 is
begin

    PROCESS(A, B, SL)
        variable TEMP_Y : STD_LOGIC_VECTOR(15 downto 0);
        variable TEMP_C : STD_LOGIC;
    BEGIN
        -- Default values
        TEMP_Y := (others => '0');
        TEMP_C := '0';
        
        CASE SL IS
        
            -- LOGICAL OPERATIONS (5 operations)
            WHEN "000" => 
                TEMP_Y := X"00" & (A AND B);
                
            WHEN "001" => 
                TEMP_Y := X"00" & (A NAND B);
                
            WHEN "010" => 
                TEMP_Y := X"00" & (A OR B);
                
            WHEN "011" => 
                TEMP_Y := X"00" & (A NOR B);
                
            WHEN "100" => 
                TEMP_Y := X"00" & (A XOR B);
            
            -- MULTIPLICATION (8-bit x 8-bit = 16-bit)
            WHEN "101" => 
                TEMP_Y := STD_LOGIC_VECTOR(UNSIGNED(A) * UNSIGNED(B));
                TEMP_C := '0';  -- No carry for multiplication
            
            -- ADDITION
            WHEN "110" => 
                TEMP_Y := STD_LOGIC_VECTOR(
                          ("00000000" & UNSIGNED(A)) + 
                          ("00000000" & UNSIGNED(B))
                          );
                TEMP_C := TEMP_Y(8);  -- Carry out
            
            -- SUBTRACTION
            WHEN OTHERS => 
                IF UNSIGNED(A) >= UNSIGNED(B) THEN
                    TEMP_Y := X"00" & STD_LOGIC_VECTOR(UNSIGNED(A) - UNSIGNED(B));
                    TEMP_C := '0';  -- No borrow
                ELSE
                    TEMP_Y := X"00" & STD_LOGIC_VECTOR(UNSIGNED(B) - UNSIGNED(A));
                    TEMP_C := '1';  -- Borrow indicator
                END IF;
                
        END CASE;
        
        -- Assign to outputs
        Y <= TEMP_Y;
        C <= TEMP_C;
        
    END PROCESS;

end ALU_ARCH;