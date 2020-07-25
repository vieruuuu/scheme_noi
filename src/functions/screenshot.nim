import winim/inc/[windef, winuser, wingdi]
import winim/utils
import encodeImageBytes

type ColorRGBA* = object
  ## Color stored as 4 uint8s
  r*: byte ## Red 0-255
  g*: byte ## Green 0-255
  b*: byte ## Blue 0-255
  a*: byte ## Alpha 0-255

proc screenshot*(): string =
  let
    x: int32 = GetSystemMetrics(SM_XVIRTUALSCREEN)
    y: int32 = GetSystemMetrics(SM_YVIRTUALSCREEN)
    cx: int32 = GetSystemMetrics(SM_CXVIRTUALSCREEN)
    cy: int32 = GetSystemMetrics(SM_CYVIRTUALSCREEN)

    width: int32 = abs(cx - x)
    height: int32 = abs(cy - y)
    data: seq[byte] = newSeq[byte](width * height * 4)

    hScreen: HDC = GetDC(0)
    hDC: HDC = CreateCompatibleDC(hScreen)
    hBitmap: HBITMAP = CreateCompatibleBitmap(hScreen, width, height)
    old_obj: HGDIOBJ = SelectObject(hDC, hBitmap)

  BitBlt(hDC, 0, 0, width, height, hScreen, x, y, SRCCOPY)


  # setup bmi structure
  var bmpInfo: BITMAPINFO

  bmpInfo.bmiHeader.biSize = DWORD sizeof(BITMAPINFOHEADER)
  bmpInfo.bmiHeader.biWidth = width
  bmpInfo.bmiHeader.biHeight = height
  bmpInfo.bmiHeader.biPlanes = 1
  bmpInfo.bmiHeader.biBitCount = 32
  bmpInfo.bmiHeader.biCompression = BI_RGB
  bmpInfo.bmiHeader.biSizeImage = 0
  bmpInfo.bmiHeader.biXPelsPerMeter = 0
  bmpInfo.bmiHeader.biYPelsPerMeter = 0
  bmpInfo.bmiHeader.biClrUsed = 0
  bmpInfo.bmiHeader.biClrImportant = 0


  # copy data from bmi structure to the flippy image
  discard CreateDIBSection(hdc, addr bmpInfo, DIB_RGB_COLORS, cast[ptr pointer](
      unsafeAddr(data[0])), 0, 0)
  discard GetDIBits(hdc, hBitmap, 0, height.UINT, cast[ptr pointer](unsafeAddr(
      data[0])), addr bmpInfo, DIB_RGB_COLORS)

  # writeFile("1.txt", data)

  # cleanup
  SelectObject(hDC, old_obj)
  DeleteDC(hDC)
  ReleaseDC(0, hScreen)
  DeleteObject(hBitmap)

  result = encode(width, height, data)

