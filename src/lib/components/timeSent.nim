import basicCard
import component

proc render*(data: string): string =
  result = basicCard.render("Time server received", sanitize(data) & " UTC")
