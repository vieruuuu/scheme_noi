import basicCardList

proc render*(data: openArray[string]): string =
  result = basicCardList.render(
    "Collected wifi passwords", data,
    true,
    ["<li><pre>", "</pre></li>"]
  )
