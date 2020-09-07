import basicCardList

proc render*(data: openArray[string]): string =
  result = basicCardList.render("Installed antivirus software", data, false)
