package tb

Key :: enum u16 {
	F1               = (0xFFFF-0),
	F2               = (0xFFFF-1),
	F3               = (0xFFFF-2),
	F4               = (0xFFFF-3),
	F5               = (0xFFFF-4),
	F6               = (0xFFFF-5),
	F7               = (0xFFFF-6),
	F8               = (0xFFFF-7),
	F9               = (0xFFFF-8),
	F10              = (0xFFFF-9),
	F11              = (0xFFFF-10),
	F12              = (0xFFFF-11),
	INSERT           = (0xFFFF-12),
	DELETE           = (0xFFFF-13),
	HOME             = (0xFFFF-14),
	END              = (0xFFFF-15),
	PGUP             = (0xFFFF-16),
	PGDN             = (0xFFFF-17),
	ARROW_UP         = (0xFFFF-18),
	ARROW_DOWN       = (0xFFFF-19),
	ARROW_LEFT       = (0xFFFF-20),
	ARROW_RIGHT      = (0xFFFF-21),
	MOUSE_LEFT       = (0xFFFF-22),
	MOUSE_RIGHT      = (0xFFFF-23),
	MOUSE_MIDDLE     = (0xFFFF-24),
	MOUSE_RELEASE    = (0xFFFF-25),
	MOUSE_WHEEL_UP   = (0xFFFF-26),
	MOUSE_WHEEL_DOWN = (0xFFFF-27),
	CTRL_TILDE       =  0x00,
	CTRL_2           =  0x00 /* clash with 'CTRL_TILDE' */,
	CTRL_A           =  0x01,
	CTRL_B           =  0x02,
	CTRL_C           =  0x03,
	CTRL_D           =  0x04,
	CTRL_E           =  0x05,
	CTRL_F           =  0x06,
	CTRL_G           =  0x07,
	BACKSPACE        =  0x08,
	CTRL_H           =  0x08 /* clash with 'CTRL_BACKSPACE' */,
	TAB              =  0x09,
	CTRL_I           =  0x09 /* clash with 'TAB' */,
	CTRL_J           =  0x0A,
	CTRL_K           =  0x0B,
	CTRL_L           =  0x0C,
	ENTER            =  0x0D,
	CTRL_M           =  0x0D /* clash with 'ENTER' */,
	CTRL_N           =  0x0E,
	CTRL_O           =  0x0F,
	CTRL_P           =  0x10,
	CTRL_Q           =  0x11,
	CTRL_R           =  0x12,
	CTRL_S           =  0x13,
	CTRL_T           =  0x14,
	CTRL_U           =  0x15,
	CTRL_V           =  0x16,
	CTRL_W           =  0x17,
	CTRL_X           =  0x18,
	CTRL_Y           =  0x19,
	CTRL_Z           =  0x1A,
	ESC              =  0x1B,
	CTRL_LSQ_BRACKET =  0x1B /* clash with 'ESC' */,
	CTRL_3           =  0x1B /* clash with 'ESC' */,
	CTRL_4           =  0x1C,
	CTRL_BACKSLASH   =  0x1C /* clash with 'CTRL_4' */,
	CTRL_5           =  0x1D,
	CTRL_RSQ_BRACKET =  0x1D /* clash with 'CTRL_5' */,
	CTRL_6           =  0x1E,
	CTRL_7           =  0x1F,
	CTRL_SLASH       =  0x1F /* clash with 'CTRL_7' */,
	CTRL_UNDERSCORE  =  0x1F /* clash with 'CTRL_7' */,
	SPACE            =  0x20,
	BACKSPACE2       =  0x7F,
	CTRL_8           =  0x7F /* clash with 'BACKSPACE2' */,
}

Mod :: enum u8 {
	ALT    = 0x01,
	MOTION = 0x02,
}

/* Colors (see struct tb_cell's fg and bg fields). */
Color :: enum u16 {
	DEFAULT   = 0x00,
	BLACK     = 0x01,
	RED       = 0x02,
	GREEN     = 0x03,
	YELLOW    = 0x04,
	BLUE      = 0x05,
	MAGENTA   = 0x06,
	CYAN      = 0x07,
	WHITE     = 0x08,
	BOLD      = 0x0100,
	UNDERLINE = 0x0200,
	REVERSE   = 0x0400,
}

EventKind :: enum u8 {
	KEY    = 1,
	RESIZE = 2,
	MOUSE  = 3,
}

Error :: enum i32 {
	UNSUPPORTED_TERMINAL = -1,
	FAILED_TO_OPEN_TTY   = -2,
	PIPE_TRAP_ERROR      = -3,
}

Input_Mode :: enum i32 {
	CURRENT = 0 /* 000 */,
	ESC     = 1 /* 001 */,
	ALT     = 2 /* 010 */,
	MOUSE   = 4 /* 100 */,
}

Output_Mode :: enum i32 {
	CURRENT   = 0,
	NORMAL    = 1,
	T256      = 2,
	T216      = 3,
	GRAYSCALE = 4,
}

Cell :: struct {
	ch: rune,
	fg, bg: Color,
}

Event :: struct {
	kind: EventKind,
	mod: Mod,
	key: Key,
	ch: rune,
	w, h: i32,
	x, y: i32,
}

/* Sets the position of the cursor. Upper-left character is (0, 0). If you pass
 * TB_HIDE_CURSOR as both coordinates, then the cursor will be hidden. Cursor
 * is hidden by default.
 */
TB_HIDE_CURSOR :: -1;

foreign import termboxlib "system:termbox";

@(default_calling_convention="c", link_prefix="tb_")
foreign termboxlib {
	init :: proc() -> Error ---;
	init_file :: proc(name: cstring) -> Error ---;
	init_fd :: proc(inout: i32) -> Error ---;
	shutdown :: proc() ---;

	width :: proc() -> i32 ---;
	height :: proc() -> i32 ---;

	clear :: proc() ---;
	set_clear_attributes :: proc(fg, bg: Color) ---;

	present :: proc() ---;
	
	set_cursor :: proc(x, y: i32) ---;

	put_cell :: proc(x, y: i32, cell: ^Cell) ---;
	change_cell :: proc(x, y: i32, ch: rune, fg, bg: Color) ---;

	blit :: proc(x, y: i32, w, h: i32, cells: ^Cell) ---;

	cell_buffer :: proc() -> ^Cell ---;

	select_input_mode :: proc(mode: Input_Mode) -> Input_Mode ---;
	select_output_mode :: proc(mode: Output_Mode) -> Output_Mode ---;

	peek_event :: proc(event: ^Event, timeout: i32) ---;
	poll_event :: proc(event: ^Event) ---;
}