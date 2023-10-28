--      -- 1 --
--     |       |
--     6       2
--     |       |
--      -- 7 --
--     |       |
--     5       3
--     |       |
--      -- 4 --

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity seg7 is
    Port (
        counter  : in  std_logic_vector(3 downto 0);
        segments : out std_logic_vector(6 downto 0)
    );
end seg7;

architecture Behavioral of seg7 is
begin
    process(counter)
    begin
        case counter is
            when "0000" => segments <= "0111111";
            when "0001" => segments <= "0000110";
            when "0010" => segments <= "1011011";
            when "0011" => segments <= "1001111";
            when "0100" => segments <= "1100110";
            when "0101" => segments <= "1101101";
            when "0110" => segments <= "1111101";
            when "0111" => segments <= "0000111";
            when "1000" => segments <= "1111111";
            when "1001" => segments <= "1100111";
            when others => segments <= "0000000";
        end case;
    end process;
end Behavioral;
