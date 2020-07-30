type keys = seq[(int, string)]

## trebuie sa scapuiesti linkul asta
## http://www.kbdedit.com/manual/low_level_vk_list.html
## ambele tabele

let keysReadable: keys = @[
  (0xC1, "[ABNT C1]"), # original: Abnt C1, valorile mai lungi sau F1 etc, gen astea, trebuie sa fie cu caps
  (0xC2, "[ABNT C2]"), # si trebuie sa fie in []
  (0x6B, "[NUMPAD +]"),
  # samd
  (0x30, "0"),         # la cifre si litere nu e nev de nimic in plus sau in minus
                       # samd
  (0x41, "A"),

]

## poti scrie un python script sa iei datele din tabel sau cv js
## ideea ii sa le pui asa cum le am pus eu
