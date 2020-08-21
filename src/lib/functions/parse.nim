import decryptAES
import ../more/zlibstatic/src/zlibstatic/zlib

from base64 import decode

from strutils import split

let data = """/mj73fpSvZQ0KKIg8NzRXSH3oJRtjRDgY6yP0IENLT97Ufs3GR/mCefXtt/t1K3YScv9OKYvMcBbmnbMHjkBW57dpk7J9IgTYEv0338vpp+fS/8rehH/cs5Hw7K35EY4mRwml0sDMn9phisZTd/w7ak/JHmvv7kIDEnIjltYsM7H22QxNw0P/d8vs1RbJKrywdQxvDg0RuxHSRvhtiKZJ/C6n1RLRvkxXUi9oRMj+y9g/DLtZfGGdnDdMoyjFSRGbjuLWPaixqWmtCSZigYVhRpXiFCRCAxaLkT4NmhcXElohwSDO5iqvkifsBOwX45TxfuilWJi68bjc+mpwqIeoc4q2ndZwj2B+h7zkWrExmjHHxa0VesCdJTv0mbeyO5BtgYnnhBMNtXjGugz946pkv7G44Ugao6LcRZt06Z7IBmcnWakrL7+JYR0UO5SPkjx8xr1uEoxh+KbskusGNAtHLnc7NKrOIIoTHch9UujWCjFA7n44iBYvvaXr201VUmRQVRGBv8sJLY6CIlz3P8wt8g8FAy3BHgQ9HydY2z93HxO2IkzDulf+WxSmUiZKnz5JS1cdCxSgLvKivrhHvaEAcXOJEzRF8h5za4oR0V/6ID+Pr9cNS7KQaTSvutH1ZV2QQy7PK8abuJEwi/L8g4Ps9SB906g9yztO2l1fYb5Api71Hw7T1s2csEy1jQO5MM2i4s1IRsjMscqQlE5ALGgAs+4br5I5Uwn6wxAj7jYkVqAxOBZQAedOQEyKSQS4CgKnMQLtKS7byEAkR3g1J8uRzE94qB/yg0Uh720Ek2d5PdNT4r2AsPA5lyJ9kH9OOotYk0GCPsyqSsGsefLlU6O6A+TBdxD/o5kzvq1gscSdMvaJ83y4QvClOenzNWzdakOocWtOBeGhzZxAolyLwTRiKXPbnbBVOiZRgxkZ8IuuckIayRef9cFftUvfXJVgxEWfTogryx0A2vi6YISc00JBvqsb4cIEZw95pcSQGbjLDPP"""

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


parseThreads uncompress(decrypt data, stream = RAW_DEFLATE)
