import jester
from random import randomize

import lib/components/index as index
import lib/components/clipboard as clipboard
import lib/components/header as header
import lib/components/pcname as pcname
import lib/components/basicinfo as basicinfo
import lib/components/av as av
import lib/components/keylog as keylog
import lib/components/devicemac as devicemac
import lib/components/devceip as deviceip

randomize()

proc buildPage(): string =
  result = index.render(
    pcname.render("abi regele") &
    #header.render("basic info") &
    basicinfo.render("Lorem ipsum dolor sit amet, consectetur adipiscing elit. <strong>Pellentesque risus mi</strong>, tempus quis placerat ut, porta nec nulla. Vestibulum rhoncus ac ex sit amet fringilla. Nullam gravida purus diam, et dictum <a>felis venenatis</a> efficitur. Aenean ac <em>eleifend lacus</em>, in mollis lectus. Donec sodales, arcu et sollicitudin porttitor, tortor urna tempor ligula, id porttitor mi magna a neque. Donec dui urna, vehicula et sem eget, facilisis sodales sem.") &
    av.render("norton") &
    av.render("windows defenders") &
    clipboard.render("nimic") &
    keylog.render("A B C D E F G H I J K L M N O P Q R T S T U V W Y X Z") &
    devicemac.render("AA:BB:CC:DD:EE:FF") & # aici pt manufacturer folosesti aia oui
    deviceip.render("192.168.0.1") # aici pt manufacturer folosesti aia oui
  )

routes:
  get "/":
    resp buildPage()
