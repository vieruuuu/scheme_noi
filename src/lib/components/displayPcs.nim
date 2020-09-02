import component

proc render*(): string =
  getFile("displayPcs.html")

  result = file
