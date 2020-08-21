from osproc import execProcess
from osproc import ProcessOption

proc runCmd*(command: string): string =
  result = execProcess(command, options = {poDaemon})
