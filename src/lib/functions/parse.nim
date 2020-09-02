import aes
import ../more/zlibstatic/src/zlibstatic/zlib

from base64 import decode

from std/sha1 import secureHash
from std/sha1 import `$`

from strutils import split

let header = """frDpPaJUuSyrrOGfroJAcsL6HMa5kHfwvlNeCVK3Q3bDTlOdk+b/QbsGTN714OUsc0B0GXcIT/J2qA4OvCXtffqPHHXQJIdKWl4tXDNFWSRucFXGoZ5graSUhBU1Ev2lICTOHyoMm3ARJbkvkIZlx5Kc33XUUb/NUAiJm04NSrPQSeUJg1kczAiAC1eb58RqDpqiXH6PVBOp5t9hTHYysRyp6OFczoaiI+QgQNpcUFCxTBQNuU7Zz/Sx/rM1gTVJcdercc1Yci8/C8MUdnWLwKniJa6nLZztZiHeY+E0F43ON/hqO6EDL6LaeisNMh28ZqpwNbJC8GsaeK88V1dWN7immFby+U8/BQrP5GQOsz/HKdZMXwk8mAXQrMmQ2GsoCfBCV+fHG84QlYW6m31oYwtUD2Mc8tgbxtFC"""

let headerContent = uncompress(decrypt header, stream = RAW_DEFLATE)

# use header specific key
config.key = $secureHash headerContent & config.key & config.aad & config.iv

let data = """WTGTRw2coUYwOxoJGoBcBCLwGFj7d/9elZSHc3VLDo+aGL5N6au27EZett1czk7Nb11I8/TSMhg1yuvg2DVu45cMSdZnzSSrLtWOG+u69PdEaZu0JMgxGGxsi2IU2pd5urlhuXLLQAp7bvQJ6UZBAEnySi/ek5tsiVR5mMHKGA5h8Sq7UxHjB+QA2b29g6aAa5orl07uPdN1EXa+vM/FxLY3/0dzNIZJUygU0OqlZyww9GMVSA=="""

proc parseThreads(data: string): void =
  for thread in data.split("."):
    if thread == "":
      continue
    let threadSplit: seq[string] = thread.split(",")
    let threadName: string = threadSplit[0]
    let threadData: string = threadSplit[1]

    echo "name: " & threadName

    case threadName
    of "h":
      for data in threadData.split(";"):
        if data == "":
          continue
        echo "  data: " & decode data
    of "wn":
      for data in threadData.split(";"):
        if data == "":
          continue
        echo "  data: " & decode data
    of "k":
      for data in threadData.split(";"):
        if data == "":
          continue
        echo "  data: " & data
    of "kl":
      for data in threadData.split(";"):
        if data == "":
          continue
        echo "  data: " & data

parseThreads headerContent

parseThreads uncompress(decrypt data, stream = RAW_DEFLATE)
