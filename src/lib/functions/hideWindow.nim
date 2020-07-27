from winim/inc/winuser import ShowWindow
from winim/inc/wincon import GetConsoleWindow


proc hideWindow*(): void =
  ShowWindow(GetConsoleWindow(), 0)
