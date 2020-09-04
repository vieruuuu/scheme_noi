import basicCardList

proc render*(names: openArray[string]): string =
  result = basicCardList.render("Viewed windows:", names)
