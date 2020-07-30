from tables import toTable

const
  BUFFER_LENGTH* = 2048

## sursa: http://www.kbdedit.com/manual/low_level_vk_list.html
const keys* = {
    # "Mappable" codes
  0xC1: "[ABNT C1]",             # VK_ABNT_C1
  0xC2: "[ABNT C2]",             # VK_ABNT_C2
  0x6B: "[NUMPAD +]",            # VK_ADD
  0xF6: "[ATTN]",                # VK_ATTN
  0x08: "[BACKSPACE]",           # VK_BACK
  0x03: "[BREAK]",               # VK_CANCEL
  0x0C: "[CLEAR]",               # VK_CLEAR
  0xF7: "[CR SEL]",              # VK_CRSEL
  0x6E: "[NUMPAD .]",            # VK_DECIMAL
  0x6F: "[NUMPAD /]",            # VK_DIVIDE
  0xF9: "[ER EOF]",              # VK_EREOF
  0x1B: "[ESC]",                 # VK_ESCAPE
  0x2B: "[EXECUTE]",             # VK_EXECUTE
  0xF8: "[EX SEL]",              # VK_EXSEL
  0xE6: "[ICOCLR]",              # VK_ICO_CLEAR
  0xE3: "[ICOHLP]",              # VK_ICO_HELP
  0x30: "0",                     # VK_KEY_0
  0x31: "1",                     # VK_KEY_1
  0x32: "2",                     # VK_KEY_2
  0x33: "3",                     # VK_KEY_3
  0x34: "4",                     # VK_KEY_4
  0x35: "5",                     # VK_KEY_5
  0x36: "6",                     # VK_KEY_6
  0x37: "7",                     # VK_KEY_7
  0x38: "8",                     # VK_KEY_8
  0x39: "9",                     # VK_KEY_9
  0x41: "A",                     # VK_KEY_A
  0x42: "B",                     # VK_KEY_B
  0x43: "C",                     # VK_KEY_C
  0x44: "D",                     # VK_KEY_D
  0x45: "E",                     # VK_KEY_E
  0x46: "F",                     # VK_KEY_F
  0x47: "G",                     # VK_KEY_G
  0x48: "H",                     # VK_KEY_H
  0x49: "I",                     # VK_KEY_I
  0x4A: "J",                     # VK_KEY_J
  0x4B: "K",                     # VK_KEY_K
  0x4C: "L",                     # VK_KEY_L
  0x4D: "M",                     # VK_KEY_M
  0x4E: "N",                     # VK_KEY_N
  0x4F: "O",                     # VK_KEY_O
  0x50: "P",                     # VK_KEY_P
  0x51: "Q",                     # VK_KEY_Q
  0x52: "R",                     # VK_KEY_R
  0x53: "S",                     # VK_KEY_S
  0x54: "T",                     # VK_KEY_T
  0x55: "U",                     # VK_KEY_U
  0x56: "V",                     # VK_KEY_V
  0x57: "W",                     # VK_KEY_W
  0x58: "X",                     # VK_KEY_X
  0x59: "Y",                     # VK_KEY_Y
  0x5A: "Z",                     # VK_KEY_Z
  0x6A: "[NUMPAD *]",            # VK_MULTIPLY
  0xFC: "[NONAME]",              # VK_NONAME
  0x60: "[NUMPAD 0]",            # VK_NUMPAD0
  0x61: "[NUMPAD 1]",            # VK_NUMPAD1
  0x62: "[NUMPAD 2]",            # VK_NUMPAD2
  0x63: "[NUMPAD 3]",            # VK_NUMPAD3
  0x64: "[NUMPAD 4]",            # VK_NUMPAD4
  0x65: "[NUMPAD 5]",            # VK_NUMPAD5
  0x66: "[NUMPAD 6]",            # VK_NUMPAD6
  0x67: "[NUMPAD 7]",            # VK_NUMPAD7
  0x68: "[NUMPAD 8]",            # VK_NUMPAD8
  0x69: "[NUMPAD 9]",            # VK_NUMPAD9
  0xBA: "[OEM_1 (: ;)]",         # VK_OEM_1
  0xE2: "[OEM_102 (&GT; &LT;)]", # VK_OEM_102
  0xBF: "[OEM_2 (? /)]",         # VK_OEM_2
  0xC0: "[OEM_3 (~ `)]",         # VK_OEM_3
  0xDB: "[OEM_4 ({ [)]",         # VK_OEM_4
  0xDC: "[OEM_5 (| \\)]",        # VK_OEM_5
  0xDD: "[OEM_6 (} ])]",         # VK_OEM_6
  0xDE: "[OEM_7 (\" ')]",        # VK_OEM_7
  0xDF: "[OEM_8 (Â§ !)]",      # VK_OEM_8
  0xF0: "[OEM ATTN]",            # VK_OEM_ATTN
  0xF3: "[AUTO]",                # VK_OEM_AUTO
  0xE1: "[AX]",                  # VK_OEM_AX
  0xF5: "[BACK TAB]",            # VK_OEM_BACKTAB
  0xFE: "[OEMCLR]",              # VK_OEM_CLEAR
  0xBC: "[OEM_COMMA (&LT; ]",    # VK_OEM_COMMA
  0xF2: "[COPY]",                # VK_OEM_COPY
  0xEF: "[CU SEL]",              # VK_OEM_CUSEL
  0xF4: "[ENLW]",                # VK_OEM_ENLW
  0xF1: "[FINISH]",              # VK_OEM_FINISH
  0x95: "[LOYA]",                # VK_OEM_FJ_LOYA
  0x93: "[MASHU]",               # VK_OEM_FJ_MASSHOU
  0x96: "[ROYA]",                # VK_OEM_FJ_ROYA
  0x94: "[TOUROKU]",             # VK_OEM_FJ_TOUROKU
  0xEA: "[JUMP]",                # VK_OEM_JUMP
  0xBD: "[OEM_MINUS (_ -)]",     # VK_OEM_MINUS
  0xEB: "[OEMPA1]",              # VK_OEM_PA1
  0xEC: "[OEMPA2]",              # VK_OEM_PA2
  0xED: "[OEMPA3]",              # VK_OEM_PA3
  0xBE: "[OEM_PERIOD (&GT; .)]", # VK_OEM_PERIOD
  0xBB: "[OEM_PLUS (+ =)]",      # VK_OEM_PLUS
  0xE9: "[RESET]",               # VK_OEM_RESET
  0xEE: "[WSCTRL]",              # VK_OEM_WSCTRL
  0xFD: "[PA1]",                 # VK_PA1
  0xE7: "[PACKET]",              # VK_PACKET
  0xFA: "[PLAY]",                # VK_PLAY
  0xE5: "[PROCESS]",             # VK_PROCESSKEY
  0x0D: "[ENTER]",               # VK_RETURN
  0x29: "[SELECT]",              # VK_SELECT
  0x6C: "[SEPARATOR]",           # VK_SEPARATOR
  0x20: "[SPACE]",               # VK_SPACE
  0x6D: "[NUM -]",               # VK_SUBTRACT
  0x09: "[TAB]",                 # VK_TAB
  0xFB: "[ZOOM]",                # VK_ZOOM
                                 # "Non-mappable" codes
  0xFF: "[NO VK MAPPING]",       # VK__none_
  0x1E: "[ACCEPT]",              # VK_ACCEPT
  0x5D: "[CONTEXT MENU]",        # VK_APPS
  0xA6: "[BROWSER BACK]",        # VK_BROWSER_BACK
  0xAB: "[BROWSER FAVORITES]",   # VK_BROWSER_FAVORITES
  0xA7: "[BROWSER FORWARD]",     # VK_BROWSER_FORWARD
  0xAC: "[BROWSER HOME]",        # VK_BROWSER_HOME
  0xA8: "[BROWSER REFRESH]",     # VK_BROWSER_REFRESH
  0xAA: "[BROWSER SEARCH]",      # VK_BROWSER_SEARCH
  0xA9: "[BROWSER STOP]",        # VK_BROWSER_STOP
  0x14: "[CAPS LOCK]",           # VK_CAPITAL
  0x1C: "[CONVERT]",             # VK_CONVERT
  0x2E: "[DELETE]",              # VK_DELETE
  0x28: "[ARROW DOWN]",          # VK_DOWN
  0x23: "[END]",                 # VK_END
  0x70: "[F1]",                  # VK_F1
  0x79: "[F10]",                 # VK_F10
  0x7A: "[F11]",                 # VK_F11
  0x7B: "[F12]",                 # VK_F12
  0x7C: "[F13]",                 # VK_F13
  0x7D: "[F14]",                 # VK_F14
  0x7E: "[F15]",                 # VK_F15
  0x7F: "[F16]",                 # VK_F16
  0x80: "[F17]",                 # VK_F17
  0x81: "[F18]",                 # VK_F18
  0x82: "[F19]",                 # VK_F19
  0x71: "[F2]",                  # VK_F2
  0x83: "[F20]",                 # VK_F20
  0x84: "[F21]",                 # VK_F21
  0x85: "[F22]",                 # VK_F22
  0x86: "[F23]",                 # VK_F23
  0x87: "[F24]",                 # VK_F24
  0x72: "[F3]",                  # VK_F3
  0x73: "[F4]",                  # VK_F4
  0x74: "[F5]",                  # VK_F5
  0x75: "[F6]",                  # VK_F6
  0x76: "[F7]",                  # VK_F7
  0x77: "[F8]",                  # VK_F8
  0x78: "[F9]",                  # VK_F9
  0x18: "[FINAL]",               # VK_FINAL
  0x2F: "[HELP]",                # VK_HELP
  0x24: "[HOME]",                # VK_HOME
  0xE4: "[ICO00]",               # VK_ICO_00
  0x2D: "[INSERT]",              # VK_INSERT
  0x17: "[JUNJA]",               # VK_JUNJA
  0x15: "[KANA]",                # VK_KANA
  0x19: "[KANJI]",               # VK_KANJI
  0xB6: "[APP1]",                # VK_LAUNCH_APP1
  0xB7: "[APP2]",                # VK_LAUNCH_APP2
  0xB4: "[MAIL]",                # VK_LAUNCH_MAIL
  0xB5: "[MEDIA]",               # VK_LAUNCH_MEDIA_SELECT
  0x01: "[LEFT BUTTON]",         # VK_LBUTTON
  0xA2: "[LEFT CTRL]",           # VK_LCONTROL
  0x25: "[ARROW LEFT]",          # VK_LEFT
  0xA4: "[LEFT ALT]",            # VK_LMENU
  0xA0: "[LEFT SHIFT]",          # VK_LSHIFT
  0x5B: "[LEFT WIN]",            # VK_LWIN
  0x04: "[MIDDLE BUTTON]",       # VK_MBUTTON
  0xB0: "[NEXT TRACK]",          # VK_MEDIA_NEXT_TRACK
  0xB3: "[PLAY / PAUSE]",        # VK_MEDIA_PLAY_PAUSE
  0xB1: "[PREVIOUS TRACK]",      # VK_MEDIA_PREV_TRACK
  0xB2: "[STOP]",                # VK_MEDIA_STOP
  0x1F: "[MODE CHANGE]",         # VK_MODECHANGE
  0x22: "[PAGE DOWN]",           # VK_NEXT
  0x1D: "[NON CONVERT]",         # VK_NONCONVERT
  0x90: "[NUM LOCK]",            # VK_NUMLOCK
  0x92: "[JISHO]",               # VK_OEM_FJ_JISHO
  0x13: "[PAUSE]",               # VK_PAUSE
  0x2A: "[PRINT]",               # VK_PRINT
  0x21: "[PAGE UP]",             # VK_PRIOR
  0x02: "[RIGHT BUTTON]",        # VK_RBUTTON
  0xA3: "[RIGHT CTRL]",          # VK_RCONTROL
  0x27: "[ARROW RIGHT]",         # VK_RIGHT
  0xA5: "[RIGHT ALT]",           # VK_RMENU
  0xA1: "[RIGHT SHIFT]",         # VK_RSHIFT
  0x5C: "[RIGHT WIN]",           # VK_RWIN
  0x91: "[SCROL LOCK]",          # VK_SCROLL
  0x5F: "[SLEEP]",               # VK_SLEEP
  0x2C: "[PRINT SCREEN]",        # VK_SNAPSHOT
  0x26: "[ARROW UP]",            # VK_UP
  0xAE: "[VOLUME DOWN]",         # VK_VOLUME_DOWN
  0xAD: "[VOLUME MUTE]",         # VK_VOLUME_MUTE
  0xAF: "[VOLUME UP]",           # VK_VOLUME_UP
  0x05: "[X BUTTON 1]",          # VK_XBUTTON1
  0x06: "[X BUTTON 2]"           # VK_XBUTTON2
}.toTable
