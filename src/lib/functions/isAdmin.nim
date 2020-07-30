from winim/inc/shellapi import IsUserAnAdmin

proc isAdmin*(): bool =
  return IsUserAnAdmin() == 1

