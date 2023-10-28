library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tt_um_vhdl_seven_segment_seconds is
    generic (MAX_COUNT : natural := 10_000_000);
    port (
        ui_in   : in  std_logic_vector(7 downto 0);
        uo_out  : out std_logic_vector(7 downto 0);
        uio_in  : in  std_logic_vector(7 downto 0);
        uio_out : out std_logic_vector(7 downto 0);
        uio_oe  : out std_logic_vector(7 downto 0);
        ena     : in  std_logic;
        clk     : in  std_logic;
        rst_n   : in  std_logic
    );
end tt_um_vhdl_seven_segment_seconds;

architecture Behavioral of tt_um_vhdl_seven_segment_seconds is
    signal reset          : std_logic;
    signal led_out        : std_logic_vector(6 downto 0);
    signal second_counter : std_logic_vector(23 downto 0) := (others => '0');
    signal digit          : std_logic_vector(3 downto 0) := (others => '0');
    signal compare        : std_logic_vector(23 downto 0);
begin

    reset <= not rst_n;
    uo_out(6 downto 0) <= led_out;
    uo_out(7) <= '0';
    uio_oe <= (others => '1');
    uio_out <= std_logic_vector(second_counter(7 downto 0));

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                second_counter <= (others => '0');
                digit <= (others => '0');
            else
                if second_counter = compare then
                    second_counter <= (others => '0');
                    if digit = "1001" then
                        digit <= (others => '0');
                    else
                        digit <= std_logic_vector(unsigned(digit) + 1);
                    end if;
                else
                    second_counter <= std_logic_vector(unsigned(second_counter) + 1);
                end if;
            end if;
        end if;
    end process;

    compare <= "000000" & ui_in & "0000000000" when ui_in /= "00000000" else std_logic_vector(to_unsigned(MAX_COUNT, 24));

    seg7_inst : entity work.seg7 port map(counter => digit, segments => led_out);

end Behavioral;