TB_KEY_F1 :: (0xFFFF-0);
TB_KEY_F2 :: (0xFFFF-1);
TB_KEY_F3 :: (0xFFFF-2);
TB_KEY_F4 :: (0xFFFF-3);
TB_KEY_F5 :: (0xFFFF-4);
TB_KEY_F6 :: (0xFFFF-5);
TB_KEY_F7 :: (0xFFFF-6);
TB_KEY_F8 :: (0xFFFF-7);
TB_KEY_F9 :: (0xFFFF-8);
TB_KEY_F10 :: (0xFFFF-9);
TB_KEY_F11 :: (0xFFFF-10);
TB_KEY_F12 :: (0xFFFF-11);
TB_KEY_INSERT :: (0xFFFF-12);
TB_KEY_DELETE :: (0xFFFF-13);
TB_KEY_HOME :: (0xFFFF-14);
TB_KEY_END :: (0xFFFF-15);
TB_KEY_PGUP :: (0xFFFF-16);
TB_KEY_PGDN :: (0xFFFF-17);
TB_KEY_ARROW_UP :: (0xFFFF-18);
TB_KEY_ARROW_DOWN :: (0xFFFF-19);
TB_KEY_ARROW_LEFT :: (0xFFFF-20);
TB_KEY_ARROW_RIGHT :: (0xFFFF-21);
TB_KEY_MOUSE_LEFT :: (0xFFFF-22);
TB_KEY_MOUSE_RIGHT :: (0xFFFF-23);
TB_KEY_MOUSE_MIDDLE :: (0xFFFF-24);
TB_KEY_MOUSE_RELEASE :: (0xFFFF-25);
TB_KEY_MOUSE_WHEEL_UP :: (0xFFFF-26);
TB_KEY_MOUSE_WHEEL_DOWN :: (0xFFFF-27);

TB_KEY_CTRL_TILDE ::  0x00;
TB_KEY_CTRL_2 ::  0x00 /* clash with 'CTRL_TILDE' */;
TB_KEY_CTRL_A ::  0x01;
TB_KEY_CTRL_B ::  0x02;
TB_KEY_CTRL_C ::  0x03;
TB_KEY_CTRL_D ::  0x04;
TB_KEY_CTRL_E ::  0x05;
TB_KEY_CTRL_F ::  0x06;
TB_KEY_CTRL_G ::  0x07;
TB_KEY_BACKSPACE ::  0x08;
TB_KEY_CTRL_H ::  0x08 /* clash with 'CTRL_BACKSPACE' */;
TB_KEY_TAB ::  0x09;
TB_KEY_CTRL_I ::  0x09 /* clash with 'TAB' */;
TB_KEY_CTRL_J ::  0x0A;
TB_KEY_CTRL_K ::  0x0B;
TB_KEY_CTRL_L ::  0x0C;
TB_KEY_ENTER ::  0x0D;
TB_KEY_CTRL_M ::  0x0D /* clash with 'ENTER' */;
TB_KEY_CTRL_N ::  0x0E;
TB_KEY_CTRL_O ::  0x0F;
TB_KEY_CTRL_P ::  0x10;
TB_KEY_CTRL_Q ::  0x11;
TB_KEY_CTRL_R ::  0x12;
TB_KEY_CTRL_S ::  0x13;
TB_KEY_CTRL_T ::  0x14;
TB_KEY_CTRL_U ::  0x15;
TB_KEY_CTRL_V ::  0x16;
TB_KEY_CTRL_W ::  0x17;
TB_KEY_CTRL_X ::  0x18;
TB_KEY_CTRL_Y ::  0x19;
TB_KEY_CTRL_Z ::  0x1A;
TB_KEY_ESC ::  0x1B;
TB_KEY_CTRL_LSQ_BRACKET ::  0x1B /* clash with 'ESC' */;
TB_KEY_CTRL_3 ::  0x1B /* clash with 'ESC' */;
TB_KEY_CTRL_4 ::  0x1C;
TB_KEY_CTRL_BACKSLASH ::  0x1C /* clash with 'CTRL_4' */;
TB_KEY_CTRL_5 ::  0x1D;
TB_KEY_CTRL_RSQ_BRACKET ::  0x1D /* clash with 'CTRL_5' */;
TB_KEY_CTRL_6 ::  0x1E;
TB_KEY_CTRL_7 ::  0x1F;
TB_KEY_CTRL_SLASH ::  0x1F /* clash with 'CTRL_7' */;
TB_KEY_CTRL_UNDERSCORE ::  0x1F /* clash with 'CTRL_7' */;
TB_KEY_SPACE ::  0x20;
TB_KEY_BACKSPACE2 ::  0x7F;
TB_KEY_CTRL_8 ::  0x7F /* clash with 'BACKSPACE2' */;

TB_MOD_ALT :: 0x01;
TB_MOD_MOTION :: 0x02;

/* Colors (see struct tb_cell's fg and bg fields). */
TB_DEFAULT :: 0x00;
TB_BLACK ::   0x01;
TB_RED ::     0x02;
TB_GREEN ::   0x03;
TB_YELLOW ::  0x04;
TB_BLUE ::    0x05;
TB_MAGENTA :: 0x06;
TB_CYAN ::    0x07;
TB_WHITE ::   0x08;

TB_BOLD ::      0x0100;
TB_UNDERLINE :: 0x0200;
TB_REVERSE ::   0x0400;

TB_EVENT_KEY ::    1;
TB_EVENT_RESIZE :: 2;
TB_EVENT_MOUSE ::  3;

TB_EUNSUPPORTED_TERMINAL :: -1;
TB_EFAILED_TO_OPEN_TTY ::   -2;
TB_EPIPE_TRAP_ERROR ::      -3;

TB_HIDE_CURSOR :: -1;

TB_INPUT_CURRENT :: 0 /* 000 */;
TB_INPUT_ESC ::     1 /* 001 */;
TB_INPUT_ALT ::     2 /* 010 */;
TB_INPUT_MOUSE ::   4 /* 100 */;

TB_OUTPUT_CURRENT ::   0;
TB_OUTPUT_NORMAL ::    1;
TB_OUTPUT_256 ::       2;
TB_OUTPUT_216 ::       3;
TB_OUTPUT_GRAYSCALE :: 4;

tb_cell :: struct #ordered {
    ch: u32;
    fg, bg: u16;
}

tb_event :: struct #ordered {
    kind: u8;
    mod: u8;
    key: u16;
    ch: u32;
    w, h: i32;
    x, y: i32;
}

foreign_system_library (
termboxlib "termbox";
)

foreign termboxlib {
    tb_init :: proc() -> i32 #cc_c ---;
    tb_init_file :: proc(name: ^u8) -> i32 #cc_c ---;
    tb_init_fd :: proc(inout: i32) -> i32 #cc_c ---;
    tb_shutdown :: proc() #cc_c ---;
    
    tb_width :: proc() -> i32 #cc_c ---;
    tb_height :: proc() -> i32 #cc_c ---;
    
    tb_clear :: proc() #cc_c ---;
    tb_set_clear_attributes :: proc(fg, bg: u16) #cc_c ---;
    
    tb_present :: proc() #cc_c ---;
    
    tb_set_cursor :: proc(x, y: i32) #cc_c ---;
    
    tb_put_cell :: proc(x, y: i32, cell: ^tb_cell) #cc_c ---;
    tb_change_cell :: proc(x, y: i32, ch: u32, fg, bg: u16) #cc_c ---;
    
    tb_blit :: proc(x, y: i32, w, h: i32, cells: ^tb_cell) #cc_c ---;
    
    tb_cell_buffer :: proc() -> ^tb_cell #cc_c ---;
    
    tb_select_input_method :: proc(mode: i32) -> i32 #cc_c ---;
    
    tb_select_output_mode :: proc(mode: i32) -> i32 #cc_c ---;
    
    tb_peek_event :: proc(event: ^tb_event, timeout: i32) #cc_c ---;
    tb_poll_event :: proc(event: ^tb_event) #cc_c ---;
}