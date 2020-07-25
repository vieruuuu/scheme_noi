type
  ImageData* = object
    width*: int32
    height*: int32
    data*: seq[byte]

  Base64Status* {.pure.} = enum
    Error,
    Success,
    Incorrect,
    Overrun

  Base64Alphabet* = object
    decode*: array[128, int8]
    encode*: array[64, uint8]

  Base64* = object
    ## Type to use RFC4648 alphabet without padding
  Base64Pad* = object
    ## Type to use RFC4648 alphabet with padding
  Base64Url* = object
    ## Type to use RFC4648 URL alphabet without padding
  Base64UrlPad* = object
    ## Type to use RFC4648 URL alphabet with padding

  Base64PadTypes* = Base64Pad | Base64UrlPad
    ## All types with padding support
  Base64NoPadTypes* = Base64 | Base64Url
    ## All types without padding support
  Base64Types* = Base64 | Base64Pad | Base64Url | Base64UrlPad
    ## All types

  Base64Error* = object of CatchableError
    ## Base64 specific exception type
