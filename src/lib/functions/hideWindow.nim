import winim/inc/[wincon, windef, winuser]

proc hideWindow*(): void =
  AllocConsole()
  let Stealth: HWND = FindWindowA("ConsoleWindowClass", NULL)
  ShowWindow(Stealth, 0)
