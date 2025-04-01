LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_actor_manager IS
END tb_actor_manager;

ARCHITECTURE behavior OF tb_actor_manager IS
    CONSTANT CLK_PERIOD : time := 10 ns;

    SIGNAL clk               : std_logic := '0';
    SIGNAL sim_done          : boolean := false;
    
    -- Inputs
    SIGNAL i_print_px_x      : std_logic_vector(9 downto 0) := (others => '0');
    SIGNAL i_print_px_y      : std_logic_vector(9 downto 0) := (others => '0');
    SIGNAL i_actor_id        : std_logic_vector(2 downto 0) := "000";
    SIGNAL i_global_actor_x  : std_logic_vector(9 downto 0) := (others => '0');
    SIGNAL i_global_actor_y  : std_logic_vector(9 downto 0) := (others => '0');
    SIGNAL i_change_tile_id  : std_logic_vector(5 downto 0) := (others => '0');
    SIGNAL i_move_actor_x    : std_logic_vector(3 downto 0) := (others => '0');
    SIGNAL i_move_actor_y    : std_logic_vector(3 downto 0) := (others => '0');
    SIGNAL i_ch_tile_id_en   : std_logic := '0';
    SIGNAL i_global_actor_en : std_logic := '0';
    SIGNAL i_move_actor_en   : std_logic := '0';
    SIGNAL i_actor_update_en : std_logic := '0';
    
    -- Outputs
    SIGNAL o_tile_id         : std_logic_vector(5 downto 0);
    SIGNAL o_tile_x          : std_logic_vector(3 downto 0);
    SIGNAL o_tile_y          : std_logic_vector(3 downto 0);

    COMPONENT actor_manager
        PORT (
            i_clk             : IN  std_logic;
            i_print_px_x      : IN  std_logic_vector(9 downto 0);
            i_print_px_y      : IN  std_logic_vector(9 downto 0);
            i_actor_id        : IN  std_logic_vector(2 downto 0);
            i_global_actor_x  : IN  std_logic_vector(9 downto 0);
            i_global_actor_y  : IN  std_logic_vector(9 downto 0);
            i_change_tile_id  : IN  std_logic_vector(5 downto 0);
            i_move_actor_x    : IN  std_logic_vector(3 downto 0);
            i_move_actor_y    : IN  std_logic_vector(3 downto 0);
            i_ch_tile_id_en   : IN  std_logic;
            i_global_actor_en : IN  std_logic;
            i_move_actor_en   : IN  std_logic;
            i_actor_update_en : IN  std_logic;
            o_tile_id         : OUT std_logic_vector(5 downto 0);
            o_tile_x          : OUT std_logic_vector(3 downto 0);
            o_tile_y          : OUT std_logic_vector(3 downto 0)
        );
    END COMPONENT;

BEGIN
    -- Clock process
    clk_process : PROCESS
    BEGIN
        WHILE NOT sim_done LOOP
            clk <= '0';
            WAIT FOR CLK_PERIOD / 2;
            clk <= '1';
            WAIT FOR CLK_PERIOD / 2;
        END LOOP;
        WAIT;
    END PROCESS;

    UUT : actor_manager
        PORT MAP (
            i_clk             => clk,
            i_print_px_x      => i_print_px_x,
            i_print_px_y      => i_print_px_y,
            i_actor_id        => i_actor_id,
            i_global_actor_x  => i_global_actor_x,
            i_global_actor_y  => i_global_actor_y,
            i_change_tile_id  => i_change_tile_id,
            i_move_actor_x    => i_move_actor_x,
            i_move_actor_y    => i_move_actor_y,
            i_ch_tile_id_en   => i_ch_tile_id_en,
            i_global_actor_en => i_global_actor_en,
            i_move_actor_en   => i_move_actor_en,
            i_actor_update_en => i_actor_update_en,
            o_tile_id         => o_tile_id,
            o_tile_x          => o_tile_x,
            o_tile_y          => o_tile_y
        );

    -- Stimulus Process
    stim_proc: PROCESS
    BEGIN
        WAIT FOR 20 ns;
        
        ------------------------------------------------------------------
        -- TEST 1: Initialisation d'un seul acteur
        ------------------------------------------------------------------
        
        -- Step 1: Configurer acteur 0
        i_actor_id        <= "000";
        i_global_actor_x  <= std_logic_vector(to_unsigned(100, 10));  -- X=100
        i_global_actor_y  <= std_logic_vector(to_unsigned(50, 10));   -- Y=50
        i_change_tile_id  <= "001010";  -- Tile ID 10
        
        -- Step 2: Activation des signaux enable necessaires
        WAIT FOR CLK_PERIOD;
        i_actor_update_en <= '1';  -- Select acteur 0
        WAIT FOR CLK_PERIOD;
        i_actor_update_en <= '0';  -- Deactivate selection
        WAIT FOR CLK_PERIOD;
        i_global_actor_en <= '1';  -- Enable position update
        i_ch_tile_id_en   <= '1';  -- Enable tile ID update
        WAIT FOR CLK_PERIOD;
        i_global_actor_en <= '0';  -- Disable enables
        i_ch_tile_id_en   <= '0';
        
        -- Step 3: Set print pixel a l'interieur du 16x16 de acteur 0 (sinon ca va juste sortir 0 - voir test 4)
        i_print_px_x <= std_logic_vector(to_unsigned(105, 10));  -- X=105 (100+5)
        i_print_px_y <= std_logic_vector(to_unsigned(55, 10));   -- Y=55 (50+5)
        WAIT FOR CLK_PERIOD * 2; 
        
        -- Expected output: (tile_id=10, relative x=5, y=5)
        
        ------------------------------------------------------------------
        -- TEST 2: On ajoute un deuxieme acteur pour tester la priorité 
        ------------------------------------------------------------------
        -- Note: live 0 est devant 7 (genre les acteurs plus petits on priorité) mais ca se change dans output_select_proc
        
        -- Step 1: Configurer acteur 1 pour qu'il overlap avec acteur 0
        i_actor_id        <= "001";
        i_global_actor_x  <= std_logic_vector(to_unsigned(95, 10));
        i_global_actor_y  <= std_logic_vector(to_unsigned(45, 10));
        i_change_tile_id  <= "100001";  -- Tile ID 33
        
        -- Step 2: Enables
        WAIT FOR CLK_PERIOD;
        i_actor_update_en <= '1';
        WAIT FOR CLK_PERIOD;
        i_actor_update_en <= '0';
        WAIT FOR CLK_PERIOD;
        i_global_actor_en <= '1';
        i_ch_tile_id_en   <= '1';
        WAIT FOR CLK_PERIOD;
        i_global_actor_en <= '0';
        i_ch_tile_id_en   <= '0';
        
        -- Step 3: Set print pixel to be in overlapping area of both actors
        i_print_px_x <= std_logic_vector(to_unsigned(105, 10));  -- X=105
        i_print_px_y <= std_logic_vector(to_unsigned(55, 10));   -- Y=55
        WAIT FOR CLK_PERIOD * 2; 
        
        -- acteur 0 devrait etre visible
        
        ------------------------------------------------------------------
        -- TEST 3: Test actor move (déplacement relatif)
        ------------------------------------------------------------------
        
        -- Step 1: Configuration de l'acteur 0
        i_actor_id      <= "000"; 
        i_move_actor_x  <= std_logic_vector(to_unsigned(5, 4));   -- Move 5 pixels a drete
        i_move_actor_y  <= std_logic_vector(to_unsigned(5, 4));   -- Move 5 pixels a goch
        
        -- Step 2: Enables
        WAIT FOR CLK_PERIOD;
        i_actor_update_en <= '1';
        WAIT FOR CLK_PERIOD;
        i_actor_update_en <= '0';  
        WAIT FOR CLK_PERIOD; 
        i_move_actor_en   <= '1';  -- Enable movement
        WAIT FOR CLK_PERIOD;
        i_move_actor_en   <= '0';  -- Disable movement enable
        
        -- Step 3: Set print pixel pour qu'il soit à l'interieur de la nouvelle zone de acteur 0
        i_print_px_x <= std_logic_vector(to_unsigned(110, 10));  -- X=110 (105+5)
        i_print_px_y <= std_logic_vector(to_unsigned(60, 10));   -- Y=60 (55+5)
        WAIT FOR CLK_PERIOD * 2;
        
        -- On devrait voir actor 0's tile since it has higher priority (lower index)
        
        ------------------------------------------------------------------
        -- TEST 4: Test pixel à l'exterieur de la zone de l'acteur
        ------------------------------------------------------------------
        REPORT "TEST 4: Test pixel outside actor areas";
        
        -- Set print pixel à l'exterieur du 16x16
        i_print_px_x <= std_logic_vector(to_unsigned(200, 10));  -- X=200
        i_print_px_y <= std_logic_vector(to_unsigned(200, 10));  -- Y=200
        WAIT FOR CLK_PERIOD * 2;
        
        -- On devrait recevoir les outputs par défaut (all zeros)
       
        ------------------------------------------------------------------
        -- TEST 5: Multiple actors with proper enable sequencing
        ------------------------------------------------------------------
        
        -- Step 1: Acteur 2 setup
        i_actor_id        <= "010";  -- Select actor 2
        i_global_actor_x  <= std_logic_vector(to_unsigned(150, 10));
        i_global_actor_y  <= std_logic_vector(to_unsigned(150, 10));
        i_change_tile_id  <= "011001";  -- Tile ID 25
        
        -- Enable acteur 2 and apply settings
        WAIT FOR CLK_PERIOD;
        i_actor_update_en <= '1';
        WAIT FOR CLK_PERIOD;
        i_actor_update_en <= '0';
        WAIT FOR CLK_PERIOD;
        i_global_actor_en <= '1';
        i_ch_tile_id_en   <= '1';
        WAIT FOR CLK_PERIOD;
        i_global_actor_en <= '0';
        i_ch_tile_id_en   <= '0';
        
        -- Step 2: Acteur 3 setup
        i_actor_id        <= "011";  -- Select actor 3
        i_global_actor_x  <= std_logic_vector(to_unsigned(155, 10));
        i_global_actor_y  <= std_logic_vector(to_unsigned(155, 10));
        i_change_tile_id  <= "101010";  -- Tile ID 42
        
        -- Enable acteur 3 
        WAIT FOR CLK_PERIOD;
        i_actor_update_en <= '1';
        WAIT FOR CLK_PERIOD;
        i_actor_update_en <= '0';
        WAIT FOR CLK_PERIOD;
        i_global_actor_en <= '1';
        i_ch_tile_id_en   <= '1';
        WAIT FOR CLK_PERIOD;
        i_global_actor_en <= '0';
        i_ch_tile_id_en   <= '0';
        
        -- Check pixel in overlapping area of actors 2 and 3
        i_print_px_x <= std_logic_vector(to_unsigned(160, 10));
        i_print_px_y <= std_logic_vector(to_unsigned(160, 10));
        WAIT FOR CLK_PERIOD * 2;
        
        -- Should see actor 2's tile (lower index has higher priority)
        -- acteur 0 et 1 ne sont pas visibles car outside of actor's area
        
        -- Check pixel in actor 2's area only
        i_print_px_x <= std_logic_vector(to_unsigned(151, 10));
        i_print_px_y <= std_logic_vector(to_unsigned(151, 10));
        WAIT FOR CLK_PERIOD * 2;
        
        -- On devrait encore voir acteur 2 mais avec d'autres o_tile_x/y
        
        ------------------------------------------------------------------
        -- TEST 6: Changement de tile ID pour un acteur qui existe deja
        ------------------------------------------------------------------
        
        -- Change tile ID pour acteur 3
        i_actor_id        <= "011";  -- Select acteur 3
        i_change_tile_id  <= "111111";  -- New tile ID 63
        
        -- Enable actor 3 and apply tile ID change
        WAIT FOR CLK_PERIOD;
        i_actor_update_en <= '1';
        WAIT FOR CLK_PERIOD;
        i_actor_update_en <= '0';
        WAIT FOR CLK_PERIOD;
        i_ch_tile_id_en   <= '1';
        WAIT FOR CLK_PERIOD;
        i_ch_tile_id_en   <= '0';
        
        -- Check pixel in actor 3's area
        i_print_px_x <= std_logic_vector(to_unsigned(160, 10));
        i_print_px_y <= std_logic_vector(to_unsigned(160, 10));
        WAIT FOR CLK_PERIOD * 2;
        
        -- Should see actor 2's tile since it has higher priority (lower index)
        
        -- End simulation
        WAIT FOR 100 ns;
        sim_done <= true;
        REPORT "Simulation completed successfully";
        WAIT;
    END PROCESS;
END behavior;