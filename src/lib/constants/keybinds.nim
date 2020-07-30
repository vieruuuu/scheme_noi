type keys = seq[(int, string)]

## sursa: http://www.kbdedit.com/manual/low_level_vk_list.html

let keysReadable: keys = @[
  (0xC1, "[ABNT C1]"), # VK_ABNT_C1
  (0xC2, "[ABNT C2]"), # VK_ABNT_C2
  (0x6B, "[NUMPAD +]"), # VK_ADD
  (0xF6, "[ATTN]"), # VK_ATTN
  (0x08, "[BACKSPACE]"), # VK_BACK
  (0x03, "[BREAK]"), # VK_CANCEL
  (0x0C, "[CLEAR]"), # VK_CLEAR
  (0xF7, "[CR SEL]"), # VK_CRSEL
  (0x6E, "[NUMPAD .]"), # VK_DECIMAL
  (0x6F, "[NUMPAD /]"), # VK_DIVIDE
  (0xF9, "[ER EOF]"), # VK_EREOF
  (0x1B, "[ESC]"), # VK_ESCAPE
  (0x2B, "[EXECUTE]"), # VK_EXECUTE
  (0xF8, "[EX SEL]"), # VK_EXSEL
  (0xE6, "[ICOCLR]"), # VK_ICO_CLEAR
  (0xE3, "[ICOHLP]"), # VK_ICO_HELP
  (0x30, "0"), # VK_KEY_0
  (0x31, "1"), # VK_KEY_1
  (0x32, "2"), # VK_KEY_2
  (0x33, "3"), # VK_KEY_3
  (0x34, "4"), # VK_KEY_4
  (0x35, "5"), # VK_KEY_5
  (0x36, "6"), # VK_KEY_6
  (0x37, "7"), # VK_KEY_7
  (0x38, "8"), # VK_KEY_8
  (0x39, "9"), # VK_KEY_9
  (0x41, "A"), # VK_KEY_A
  (0x42, "B"), # VK_KEY_B
  (0x43, "C"), # VK_KEY_C
  (0x44, "D"), # VK_KEY_D
  (0x45, "E"), # VK_KEY_E
  (0x46, "F"), # VK_KEY_F
  (0x47, "G"), # VK_KEY_G
  (0x48, "H"), # VK_KEY_H
  (0x49, "I"), # VK_KEY_I
  (0x4A, "J"), # VK_KEY_J
  (0x4B, "K"), # VK_KEY_K
  (0x4C, "L"), # VK_KEY_L
  (0x4D, "M"), # VK_KEY_M
  (0x4E, "N"), # VK_KEY_N
  (0x4F, "O"), # VK_KEY_O
  (0x50, "P"), # VK_KEY_P
  (0x51, "Q"), # VK_KEY_Q
  (0x52, "R"), # VK_KEY_R
  (0x53, "S"), # VK_KEY_S
  (0x54, "T"), # VK_KEY_T
  (0x55, "U"), # VK_KEY_U
  (0x56, "V"), # VK_KEY_V
  (0x57, "W"), # VK_KEY_W
  (0x58, "X"), # VK_KEY_X
  (0x59, "Y"), # VK_KEY_Y
  (0x5A, "Z"), # VK_KEY_Z
  (0x6A, "[NUMPAD *]"), # VK_MULTIPLY
  (0xFC, "[NONAME]"), # VK_NONAME
  (0x60, "[NUMPAD 0]"), # VK_NUMPAD0
  (0x61, "[NUMPAD 1]"), # VK_NUMPAD1
  (0x62, "[NUMPAD 2]"), # VK_NUMPAD2
  (0x63, "[NUMPAD 3]"), # VK_NUMPAD3
  (0x64, "[NUMPAD 4]"), # VK_NUMPAD4
  (0x65, "[NUMPAD 5]"), # VK_NUMPAD5
  (0x66, "[NUMPAD 6]"), # VK_NUMPAD6
  (0x67, "[NUMPAD 7]"), # VK_NUMPAD7
  (0x68, "[NUMPAD 8]"), # VK_NUMPAD8
  (0x69, "[NUMPAD 9]"), # VK_NUMPAD9
  (0xBA, "[OEM_1 (: ;)]"), # VK_OEM_1
  (0xE2, "[OEM_102 (&GT; &LT;)]"), # VK_OEM_102
  (0xBF, "[OEM_2 (? /)]"), # VK_OEM_2
  (0xC0, "[OEM_3 (~ `)]"), # VK_OEM_3
  (0xDB, "[OEM_4 ({ [)]"), # VK_OEM_4
  (0xDC, "[OEM_5 (| \)]"), # VK_OEM_5
  (0xDD, "[OEM_6 (} ])]"), # VK_OEM_6
  (0xDE, "[OEM_7 (\" ')]"), # VK_OEM_7
  (0xDF, "[OEM_8 (Ï¿½ !)]"), # VK_OEM_8
  (0xF0, "[OEM ATTN]"), # VK_OEM_ATTN
  (0xF3, "[AUTO]"), # VK_OEM_AUTO
  (0xE1, "[AX]"), # VK_OEM_AX
  (0xF5, "[BACK TAB]"), # VK_OEM_BACKTAB
  (0xFE, "[OEMCLR]"), # VK_OEM_CLEAR
  (0xBC, "[OEM_COMMA (&LT; ]"), # VK_OEM_COMMA
  (0xF2, "[COPY]"), # VK_OEM_COPY
  (0xEF, "[CU SEL]"), # VK_OEM_CUSEL
  (0xF4, "[ENLW]"), # VK_OEM_ENLW
  (0xF1, "[FINISH]"), # VK_OEM_FINISH
  (0x95, "[LOYA]"), # VK_OEM_FJ_LOYA
  (0x93, "[MASHU]"), # VK_OEM_FJ_MASSHOU
  (0x96, "[ROYA]"), # VK_OEM_FJ_ROYA
  (0x94, "[TOUROKU]"), # VK_OEM_FJ_TOUROKU
  (0xEA, "[JUMP]"), # VK_OEM_JUMP
  (0xBD, "[OEM_MINUS (_ -)]"), # VK_OEM_MINUS
  (0xEB, "[OEMPA1]"), # VK_OEM_PA1
  (0xEC, "[OEMPA2]"), # VK_OEM_PA2
  (0xED, "[OEMPA3]"), # VK_OEM_PA3
  (0xBE, "[OEM_PERIOD (&GT; .)]"), # VK_OEM_PERIOD
  (0xBB, "[OEM_PLUS (+ =)]"), # VK_OEM_PLUS
  (0xE9, "[RESET]"), # VK_OEM_RESET
  (0xEE, "[WSCTRL]"), # VK_OEM_WSCTRL
  (0xFD, "[PA1]"), # VK_PA1
  (0xE7, "[PACKET]"), # VK_PACKET
  (0xFA, "[PLAY]"), # VK_PLAY
  (0xE5, "[PROCESS]"), # VK_PROCESSKEY
  (0x0D, "[ENTER]"), # VK_RETURN
  (0x29, "[SELECT]"), # VK_SELECT
  (0x6C, "[SEPARATOR]"), # VK_SEPARATOR
  (0x20, "[SPACE]"), # VK_SPACE
  (0x6D, "[NUM -]"), # VK_SUBTRACT
  (0x09, "[TAB]"), # VK_TAB
  (0xFB, "[ZOOM]") # VK_ZOOM
]
