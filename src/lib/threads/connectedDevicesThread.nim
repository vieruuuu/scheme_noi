## TODO: instabil, trb sa vad care i faza

from strutils import split
from strutils import contains
from strutils import parseUInt
from strutils import unIndent
from strutils import splitWhitespace
from strutils import toUpperAscii

from base64 import encode

import ../functions/runCmd

from math import ceil

var connectedDevicesThreadChannel: Channel[string]

from ../flags import CONNECTED_DEVICES_THREAD_NO_OF_THREADS
from ../channels import mainChannel

proc getIPAndSubnetMask(): tuple[worked: bool, ip: string, subnetMask: string] =
  result.worked = true

  var netsh: string = runCmd "netsh interface ip show addresses \"Wi-Fi\""

  if netsh.contains "incorrect.":
    netsh = runCmd "netsh interface ip show addresses \"Ethernet\""

  let subnetPrefix: string = "Subnet Prefix"

  if not netsh.contains subnetPrefix:
    result.worked = false

  for line in netsh.split "\n":
    if line.contains subnetPrefix:
      let split = line.split(":")[1].unIndent().split(" ")[0].split("/")

      result.ip = split[0]
      result.subnetMask = split[1]

      break

proc generateIPsForPing(start1, stop1, start2, stop2: uint8): seq[string] =
  ## a.  b.  c.  d
  ## 100.100.100.100
  for c in start1..stop1:
    for d in start2..stop2:
      result.add d(e("192.168.")) & $c & d(e(".")) & $d

proc pingIPs(ips: seq[string]): void {.thread.} =
  for ip in ips:
    let ping: string = runCmd d(e("ping -n 1 ")) & ip

    if ping.contains "Approximate round":
      connectedDevicesThreadChannel.send ip

proc assignIPSToThread(ips: seq[string]): seq[seq[string]] =
  let ipsPerThread: int = int ceil(ips.len.float /
      CONNECTED_DEVICES_THREAD_NO_OF_THREADS.float)
  var index: int

  for thread in 0..<CONNECTED_DEVICES_THREAD_NO_OF_THREADS:
    if index >= ips.len:
      break
    result.add @[]
    for i in 0..<ipsPerThread:
      index = i + thread * ipsPerThread
      if index >= ips.len:
        break
      let val: string = ips[index]

      result[thread].add val

proc getMACSFromIPS(ips: seq[string]): void =
  let arp: string = runCmd "arp -a"

  for line in arp.split "\n":
    if line.contains "dynamic":
      for ip in ips:
        if line.contains(ip):
          mainChannel.send (
             "cd",
            encode line.splitWhitespace()[1].toUpperAscii
          )
          break

proc createThreads(ips: seq[seq[string]]): void =
  let actualNumberOfThreads: int = ips.len

  var
    threads: seq[Thread[seq[string]]] = newSeq[Thread[seq[string]]](actualNumberOfThreads)

  for i in 0..<actualNumberOfThreads:
    createThread(threads[i], pingIPs, ips[i])

  joinThreads threads

proc initConnectedDevicesThread*(): void {.thread.} =
  let (worked, ip, subnetMask) = getIPAndSubnetMask()

  if worked:
    let ipParts: seq[string] = ip.split "."
    let ipPart2: uint8 = uint8 parseUInt ipParts[2]

    var ips: seq[string]

    case subnetMask
    of "24":
      ips = generateIPsForPing(ipPart2, ipPart2, 0, 255)

    let assignedIPs: seq[seq[string]] = assignIPSToThread ips

    open connectedDevicesThreadChannel

    createThreads assignedIPs

    var data = connectedDevicesThreadChannel.tryRecv()
    var workingIPs: seq[string]

    while data.dataAvailable:
      workingIPs.add data.msg
      data = connectedDevicesThreadChannel.tryRecv()

    close connectedDevicesThreadChannel

    getMACSFromIPS workingIPs
