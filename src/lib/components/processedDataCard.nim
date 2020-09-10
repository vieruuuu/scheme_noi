import component

proc render*(
  name: string, processedData: string,
  rawData: string, identifier: string
): string =
  getFile("processedDataCard.html")

  result = file.replace("$name", name)
  result = result.replace("$dataProcessed", processedData)
  result = result.replace("$data", rawData)
  result = result.replace("$id", id(identifier))
