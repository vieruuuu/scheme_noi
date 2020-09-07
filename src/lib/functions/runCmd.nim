from osproc import execCmdEx
from osproc import ProcessOption

proc runCmd*(command: string): string =
  result = execCmdEx(command, options = {poDaemon}).output
