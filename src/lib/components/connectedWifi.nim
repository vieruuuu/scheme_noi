import basicCard
from base64 import decode

proc render*(data: string): string =
  result = basicCard.render("Connected to wifi:", decode data)
