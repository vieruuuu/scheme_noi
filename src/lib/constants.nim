## aici o pun constantele de care am nev si in alte fisiere,

## dezactiveaza functiile de care nu am nev cand developez
const isProd* {.booldefine.}: bool = false

## cred ca numele ii destul de descriptiv
const BUFFER_LENGTH* = 2048

## numele la program cand ii instalat
const EXE_NAME* = "explоrer.exe"

## folosit in master si in components/screenshot.nim
when isProd:
  const publicDir*: string = "public"
else:
  const publicDir*: string = "tmp/public"
