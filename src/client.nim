import asyncdispatch
import functions/getWindowName
import functions/screenshot
import flippy
# import functions/decodeBytes

let base64Ss: string = screenshot()

# writeFile("sal.txt", base64Ss)

# let data = decodeBytes(base64Ss)

writeFile("sal.txt", base64Ss)

# var img = Image()

# img.width = 1366
# img.height = 768
# img.channels = 4
# img.data = data

# img = img.flipVertical()

# # writeFile("2.txt", img.data)

# img.save("sal.png")


# proc main() {.async.} =
#   echo getWindowName()
#   await sleepAsync(1000)
#   asyncCheck main()

# asyncCheck main()

# runForever()

