from random import rand

proc id*(prefix: string): string =
  result = prefix & $rand(1..1000000)
