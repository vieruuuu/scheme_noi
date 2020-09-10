import processedDataCard
import component

from strutils import contains
from strutils import rsplit
from strutils import splitWhitespace

from base64 import decode

proc render*(data: openArray[string]): string =
  const oui: string = staticRead("./connectedDevices_oui.txt")
  var processedData: seq[string]
  var processedMacs: seq[string]

  for fullMac in data:
    if fullMac == "":
      continue

    processedMacs.add fullMac.decode.rsplit("-", 3)[0]

  var foundMacs: int = 0

  for line in oui.split("\n"):
    if foundMacs == processedMacs.len:
      break

    for mac in processedMacs:
      if line.contains mac:
        processedData.add line.splitWhitespace(2)[2]
        foundMacs += 1
        break


  result = processedDataCard.render(
    "Connected devices", processedData.genList,
    data.genList(true), "cd"
  )
