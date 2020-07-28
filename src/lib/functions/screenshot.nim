from winim/inc/windef import DWORD
from winim/inc/windef import HDC
from winim/inc/windef import HBITMAP
from winim/inc/windef import HGDIOBJ
from winim/inc/windef import UINT

from winim/inc/winuser import GetSystemMetrics
from winim/inc/winuser import SM_XVIRTUALSCREEN
from winim/inc/winuser import SM_YVIRTUALSCREEN
from winim/inc/winuser import SM_CXVIRTUALSCREEN
from winim/inc/winuser import SM_CYVIRTUALSCREEN
from winim/inc/winuser import GetDC
from winim/inc/winuser import ReleaseDC

from winim/inc/wingdi import BITMAPINFO
from winim/inc/wingdi import BITMAPINFOHEADER
from winim/inc/wingdi import CreateCompatibleDC
from winim/inc/wingdi import CreateCompatibleBitmap
from winim/inc/wingdi import SelectObject
from winim/inc/wingdi import BitBlt
from winim/inc/wingdi import CreateDIBSection
from winim/inc/wingdi import SRCCOPY
from winim/inc/wingdi import DIB_RGB_COLORS
from winim/inc/wingdi import GetDIBits
from winim/inc/wingdi import SelectObject
from winim/inc/wingdi import DeleteDC
from winim/inc/wingdi import DeleteObject
from winim/inc/wingdi import BI_RGB

import encodeImageBytes

proc newImageData(width: int32, height: int32): ImageData =
  result = ImageData()

  result.width = width
  result.height = height
  result.data = newSeq[byte](width * height * 4)

proc newBITMAPINFO(width: int32, height: int32): BITMAPINFO =
  result = BITMAPINFO()

  result.bmiHeader.biSize = DWORD sizeof(BITMAPINFOHEADER)
  result.bmiHeader.biWidth = width
  result.bmiHeader.biHeight = height
  result.bmiHeader.biPlanes = 1
  result.bmiHeader.biBitCount = 32
  result.bmiHeader.biCompression = BI_RGB
  result.bmiHeader.biSizeImage = 0
  result.bmiHeader.biXPelsPerMeter = 0
  result.bmiHeader.biYPelsPerMeter = 0
  result.bmiHeader.biClrUsed = 0
  result.bmiHeader.biClrImportant = 0

proc screenshot*(): string =
  let
    x: int32 = GetSystemMetrics(SM_XVIRTUALSCREEN)
    y: int32 = GetSystemMetrics(SM_YVIRTUALSCREEN)
    cx: int32 = GetSystemMetrics(SM_CXVIRTUALSCREEN)
    cy: int32 = GetSystemMetrics(SM_CYVIRTUALSCREEN)

    img: ImageData = newImageData(abs(cx - x), abs(cy - y))

    hScreen: HDC = GetDC(0)
    hDC: HDC = CreateCompatibleDC(hScreen)
    hBitmap: HBITMAP = CreateCompatibleBitmap(hScreen, img.width, img.height)
    old_obj: HGDIOBJ = SelectObject(hDC, hBitmap)


  BitBlt(hDC, 0, 0, img.width, img.height, hScreen, x, y, SRCCOPY)

  let bmpInfo: BITMAPINFO = newBITMAPINFO(img.width, img.height)

  # convertesc din bitmap device dependent in dib
  discard CreateDIBSection(hdc, unsafeAddr bmpInfo, DIB_RGB_COLORS, cast[
      ptr pointer](unsafeAddr img.data[0]), 0, 0)
  discard GetDIBits(hdc, hBitmap, 0, img.height.UINT, cast[ptr pointer](
      unsafeAddr img.data[0]), unsafeAddr bmpInfo, DIB_RGB_COLORS)

  # cleanup
  SelectObject(hDC, old_obj)
  DeleteDC(hDC)
  ReleaseDC(0, hScreen)
  DeleteObject(hBitmap)

  result = encode(img)

