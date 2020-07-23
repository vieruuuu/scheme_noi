import winim/inc/[windef, winuser, wingdi]

proc screenshot*(): void =
  let
    x: int32 = GetSystemMetrics(SM_XVIRTUALSCREEN)
    y: int32 = GetSystemMetrics(SM_YVIRTUALSCREEN)
    cx: int32 = GetSystemMetrics(SM_CXVIRTUALSCREEN)
    cy: int32 = GetSystemMetrics(SM_CYVIRTUALSCREEN)

    width: int32 = abs(cx - x)
    height: int32 = abs(cy - y)

    hScreen: HDC = GetDC(0)
    hDC: HDC = CreateCompatibleDC(hScreen)
    hBitmap: HBITMAP = CreateCompatibleBitmap(hScreen, width, height)
    old_obj: HGDIOBJ = SelectObject(hDC, hBitmap)

  BitBlt(hDC, 0, 0, width, height, hScreen, x, y, SRCCOPY)

  # copy to clipboard
  OpenClipboard(0)
  EmptyClipboard()
  SetClipboardData(CF_BITMAP, hBitmap)
  CloseClipboard()

  # cleanup
  SelectObject(hDC, old_obj)
  DeleteDC(hDC)
  ReleaseDC(0, hScreen)
  DeleteObject(hBitmap)
