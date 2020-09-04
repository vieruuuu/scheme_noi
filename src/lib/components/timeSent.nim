import basicCard

proc render*(data: string): string =
  result = basicCard.render("Time sent", data)
