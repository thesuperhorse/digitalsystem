	component nios_system is
		port (
			clk_clk                            : in  std_logic                    := 'X'; -- clk
			lda_hw_interface_0_ledr_export     : out std_logic_vector(9 downto 0);        -- export
			lda_hw_interface_0_vgab_export     : out std_logic_vector(9 downto 0);        -- export
			lda_hw_interface_0_vgablank_export : out std_logic;                           -- export
			lda_hw_interface_0_vgaclk_export   : out std_logic;                           -- export
			lda_hw_interface_0_vgag_export     : out std_logic_vector(9 downto 0);        -- export
			lda_hw_interface_0_vgahs_export    : out std_logic;                           -- export
			lda_hw_interface_0_vgar_export     : out std_logic_vector(9 downto 0);        -- export
			lda_hw_interface_0_vgasync_export  : out std_logic;                           -- export
			lda_hw_interface_0_vgavs_export    : out std_logic;                           -- export
			reset_reset_n                      : in  std_logic                    := 'X'  -- reset_n
		);
	end component nios_system;

	u0 : component nios_system
		port map (
			clk_clk                            => CONNECTED_TO_clk_clk,                            --                         clk.clk
			lda_hw_interface_0_ledr_export     => CONNECTED_TO_lda_hw_interface_0_ledr_export,     --     lda_hw_interface_0_ledr.export
			lda_hw_interface_0_vgab_export     => CONNECTED_TO_lda_hw_interface_0_vgab_export,     --     lda_hw_interface_0_vgab.export
			lda_hw_interface_0_vgablank_export => CONNECTED_TO_lda_hw_interface_0_vgablank_export, -- lda_hw_interface_0_vgablank.export
			lda_hw_interface_0_vgaclk_export   => CONNECTED_TO_lda_hw_interface_0_vgaclk_export,   --   lda_hw_interface_0_vgaclk.export
			lda_hw_interface_0_vgag_export     => CONNECTED_TO_lda_hw_interface_0_vgag_export,     --     lda_hw_interface_0_vgag.export
			lda_hw_interface_0_vgahs_export    => CONNECTED_TO_lda_hw_interface_0_vgahs_export,    --    lda_hw_interface_0_vgahs.export
			lda_hw_interface_0_vgar_export     => CONNECTED_TO_lda_hw_interface_0_vgar_export,     --     lda_hw_interface_0_vgar.export
			lda_hw_interface_0_vgasync_export  => CONNECTED_TO_lda_hw_interface_0_vgasync_export,  --  lda_hw_interface_0_vgasync.export
			lda_hw_interface_0_vgavs_export    => CONNECTED_TO_lda_hw_interface_0_vgavs_export,    --    lda_hw_interface_0_vgavs.export
			reset_reset_n                      => CONNECTED_TO_reset_reset_n                       --                       reset.reset_n
		);

