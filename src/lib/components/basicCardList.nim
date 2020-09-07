import basicCard
import component

proc render*(
  name: string, data: openArray[string],
  decode: bool = true,
  separators: array[2, string] = ["<li>", "</li>"]
): string =
  result = basicCard.render(name, data.genList(decode, separators), true)
