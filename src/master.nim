import jester
import httpclient
import json
import tables

from random import randomize

from strutils import parseInt

import lib/components/displayPcs
import lib/components/searchSnippets
import lib/components/timeSent

from lib/flags import SEND_SIZE

randomize()

var headers {.threadvar.}: Table[string, string]

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
from lib/functions/parse import initHeaderKey
from lib/functions/parse import clearHeaderKey
from lib/functions/parse import decryptData

proc getHeader(id: string): string =
  try:
    let data: string = parseJson(getSnippet id)["files"]
      .getElems()[0]["content"].getStr

    if data.len < 10:
      raise newException(ValueError, "")

    let dataDecrypted: string = decryptData(
      data
    )

    headers[id] = dataDecrypted

    result = parseThreads(id, dataDecrypted)
  except:
    result = ""

import times

proc getInstanceSnippet(header: string, id: string): string =
  try:

    initHeaderKey(headers[header])

    let snippet: JsonNode = parseJson(getSnippet id)

    let thatDate: DateTime = parse(snippet["created"].getStr, "yyyy-MM-dd\'T\'HH:mm:ss\'Z\'")

    result = timeSent.render(
      $thatDate.year & "/" & $thatDate.month & "/" &
      $thatDate.monthday & "/" &
      $thatDate.hour & "/" & $thatDate.minute & "/" & $thatDate.second
    )

    let data: string = snippet["files"].getElems()[0]["content"].getStr

    if data.len < SEND_SIZE:
      raise newException(ValueError, "")

    let dataDecrypted: string = decryptData(
      data
    )

    result.add parseThreads(id, dataDecrypted)
  except:
    result = ""

proc getSnippets(page: string): string =
  result = getData "https://snippets.glot.io/snippets?page=" & page & "&per_page=30"

routes:
  get "/":
    resp displayPcs.render()
  get "/header/@header":
    resp searchSnippets.render @"header"
  get "/getHeader/@id":
    resp getHeader @"id"
  get "/clearHeaders":
    clearHeaderKey()
    headers = initTable[string, string]()
    resp ""
  get "/getPage/@page":
    resp getSnippets @"page"
  get "/getInstanceSnippet/@header/@id":
    resp getInstanceSnippet(@"header", @"id")
