import jester
import karax / [karaxdsl, vdom]
from strutils import replace

const index: string = staticRead("./static/index.html")

proc buildPage(): string =
  let vnode = buildHtml(section(class = "section")):
    tdiv(class = "container"):
      h1(class = "title"):
        text "abi"
      p(class = "subtitle"):
        text "abi"

  result = index.replace("$vnode", $vnode)

routes:
  get "/":
    resp buildPage()
