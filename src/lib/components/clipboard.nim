import basicCardList

proc render*(data: openArray[string]): string =
  result = basicCardList.render(
    "Collected clipboard data", data,
    true,
    ["<li><pre>", "</pre></li>"]
  )
