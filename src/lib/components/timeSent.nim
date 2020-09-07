import basicCard
import component

proc render*(data: string): string =
  result = basicCard.render("Time sent", sanitize(data) & " UTC")
