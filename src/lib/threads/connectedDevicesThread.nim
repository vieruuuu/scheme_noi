from strutils import split
from strutils import contains
from strutils import parseUInt
from strutils import unIndent
from strutils import splitWhitespace

from osproc import execProcess

from math import ceil

var connectedDevicesThreadChannel: Channel[string]

from ../flags import CONNECTED_DEVICES_THREAD_NO_OF_THREADS
from ../channels import mainChannel

proc getIPAndSubnetMask(): tuple[ip: string, subnetMask: string] =
  let netsh: string = execProcess "netsh interface ip show addresses \"Wi-Fi\""

  for line in netsh.split("\n"):
    if line.contains("Subnet Prefix"):
      let split = line.split(":")[1].unIndent().split(" ")[0].split("/")

      result.ip = split[0]
      result.subnetMask = split[1]

proc generateIPsForPing(start1, stop1, start2, stop2: uint8): seq[string] =
  ## a.  b.  c.  d
  ## 100.100.100.100
  for c in start1..stop1:
    for d in start2..stop2:
      result.add "192.168." & $c & "." & $d

proc pingIPs(ips: seq[string]): void {.thread.} =
  for ip in ips:
    let ping: string = execProcess "ping -n 1 " & ip

    if ping.contains("Approximate round"):
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
  let arp: string = execProcess "arp -a"

  for line in arp.split "\n":
    if line.contains("dynamic"):
      for ip in ips:
        if line.contains(ip):
          mainChannel.send "mac: " & line.splitWhitespace()[1]
          break

proc createThreads(ips: seq[seq[string]]): void =
  let actualNumberOfThreads: int = ips.len

  var
    threads: seq[Thread[seq[string]]] = newSeq[Thread[seq[string]]](actualNumberOfThreads)

  open connectedDevicesThreadChannel

  for i in 0..<actualNumberOfThreads:
    createThread(threads[i], pingIPs, ips[i])

  joinThreads threads

proc initConnectedDevicesThread*(): void {.thread.} =
  let (ip, subnetMask) = getIPAndSubnetMask()

  let ipParts: seq[string] = ip.split(".")
  let ipPart2: uint8 = uint8 parseUInt ipParts[2]

  var ips: seq[string]

  case subnetMask
  of "24":
    ips = generateIPsForPing(ipPart2, ipPart2, 0, 255)

  let assignedIPs: seq[seq[string]] = assignIPSToThread ips

  createThreads assignedIPs

  var data = connectedDevicesThreadChannel.tryRecv()
  var workingIPs: seq[string]

  while data.dataAvailable:
    workingIPs.add data.msg
    data = connectedDevicesThreadChannel.tryRecv()

  close connectedDevicesThreadChannel

  getMACSFromIPS workingIPs
