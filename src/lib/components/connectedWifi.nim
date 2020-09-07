import basicCard
import component
from base64 import decode

proc render*(data: string): string =
  result = basicCard.render("Connected to wifi:", sanitize decode data)
