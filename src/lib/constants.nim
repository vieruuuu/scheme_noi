import functions/base64/newAlphabet64

const BUFFER_LENGTH* = 2048

const
  B64Alphabet* = newAlphabet64("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdef" &
                               "ghijklmnopqrstuvwxyz0123456789+/")
  B64UrlAlphabet* = newAlphabet64("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdef" &
                                  "ghijklmnopqrstuvwxyz0123456789-_")
