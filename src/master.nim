import jester
import httpclient
import json
import tables

from random import randomize

from strutils import parseInt

import lib/components/displayPcs
import lib/components/searchSnippets
import lib/components/timeSent

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
    let data: string = decryptData(
      parseJson(getSnippet id)["files"].getElems()[0]["content"].getStr
    )

    headers[id] = data

    result = parseThreads(id, data)
  except:
    result = ""

import times

proc getInstanceSnippet(header: string, id: string): string =
  try:

    initHeaderKey(headers[header])

    let snippet: JsonNode = parseJson(getSnippet id)
    # 2020-09-04T13:56:32Z
    let thatDate: DateTime = parse(snippet["created"].getStr, "yyyy-MM-dd\'T\'HH:mm:ss\'Z\'")

    result = $thatDate.year & "/" & $thatDate.month & "/" & $thatDate.monthday & "/" &
      $thatDate.hour & "/" & $thatDate.minute & "/" & $thatDate.second


    let data: string = decryptData(
      snippet["files"].getElems()[0]["content"].getStr
    )

    result.add parseThreads(id, data)
  except:
    result = ""

proc getSnippets(page: string): string =
  result = getData "https://snippets.glot.io/snippets?page=" & page & "&per_page=10"

routes:
  get "/":
    resp displayPcs.render()
  get "/header/@header":
    resp searchSnippets.render @"header"
  get "/getHeader/@id":
    echo $headers
    resp getHeader @"id"
  get "/clearHeaders":
    clearHeaderKey()
    headers = initTable[string, string]()
    resp ""
  get "/getPage/@page":
    resp getSnippets @"page"
  get "/getInstanceSnippet/@header/@id":
    resp getInstanceSnippet(@"header", @"id")
