import asyncdispatch
import functions/getWindowName
import os

proc main() {.async.} =
  echo getWindowName()
  await sleepAsync(1000)
  asyncCheck main()

asyncCheck main()

runForever()

