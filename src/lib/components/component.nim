from os import `/`

from ../constants import isProd

template getFile*(path: string): untyped =
  when isProd:
    const file {.inject.}: string = staticRead("./" / path)
  else:
    let file {.inject.}: string = readFile("./src/lib/components" / path)
