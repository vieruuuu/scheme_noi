import asyncdispatch

import lib/functions/getWindowName
import lib/functions/hideWindow
import lib/functions/screenshot

hideWindow()

let base64Ss: string = screenshot()

writeFile("base64.tmp.txt", base64Ss)

proc main() {.async.} =
  echo getWindowName()
  await sleepAsync(1000)
  asyncCheck main()


asyncCheck main()

runForever()
