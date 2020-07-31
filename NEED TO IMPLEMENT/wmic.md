# wmic - multe info folositoare

## exemple

diskuri
```batch
C:\Users\d4rck>wmic diskdrive get model,name,size
Model                           Name                Size
WDC PC SN520 SDAPNUW-512G-1202  \\.\PHYSICALDRIVE0  512105932800 
```

copy paste pt comanda de mai jos:
> Lists each of the programs that are installed on the computer with brief details. Note: This command could take a minute or two to complete depending on how many programs you have installed on the computer. Furthermore, the output may exceed the limit of what can be shown in the window. This command can also be made into an HTML table as explained in the previous example.

```batch
C:\Users\d4rck>wmic product list brief
Caption                                                                  IdentifyingNumber                       Name                                                                     Vendor                             Version
Python 3.8.3 Test Suite (32-bit)                                         {0F5C1C82-9A7A-4FB4-8681-D4E7E9BBFD9C}  Python 3.8.3 Test Suite (32-bit)                                         Python Software Foundation         3.8.3150.0
FileBot                                                                  {57D85EC2-421B-40E9-ABFC-5D494BF525F1}  FileBot                                                                  Reinhard Pointner                  4.9.1
Python 3.8.3 Tcl/Tk Support (32-bit)                                     {56AC5D63-87FC-4BA0-B4F2-6013D58F3302}  Python 3.8.3 Tcl/Tk Support (32-bit)                                     Python Software Foundation         3.8.3150.0
Python 3.8.3 Utility Scripts (32-bit)                                    {14A8B424-0141-4E46-A1E2-548DF8349BB7}  Python 3.8.3 Utility Scripts (32-bit)                                    Python Software Foundation         3.8.3150.0
Python 3.8.3 Core Interpreter (32-bit)                                   {D3A7FDC5-BA4E-44FC-8822-800226B81C71}  Python 3.8.3 Core Interpreter (32-bit)                                   Python Software Foundation         3.8.3150.0
Python 3.8.3 Add to Path (32-bit)                                        {A9147DC8-C9A3-4E0B-9508-445B7AC2872F}  Python 3.8.3 Add to Path (32-bit)                                        Python Software Foundation         3.8.3150.0
Python 3.8.3 Executables (32-bit)                                        {D1EFF389-2F77-4A46-8AFD-4F37BC6F1F99}  Python 3.8.3 Executables (32-bit)                                        Python Software Foundation         3.8.3150.0
OpenVPN Technologies               3.2.0
              =============== SNIP ===============
```

## resurse
- https://www.computerhope.com/wmic.htm
- https://stackoverflow.com/questions/13449322/call-wmic-commands-in-c-code
