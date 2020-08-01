## this file contains flags and other options
## used by the program


## when `true` the browser thread will remove cookies
## and other files instead of renaming them
## use `false` only for testing purposes only so no data is lost
## DEFAULT: true
const BROWSER_THREAD_REMOVE_FILE*: bool = false

## TODO: IMPLEMENT THE FOLLOWING LINES

type DateVerification* = enum
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

const useDateVerification*: bool = true

const dateVerificationType*: DateVerification = LocalApi

const expireDate*: Date = NewDate(20, 10, 2020)
