type keys = seq[(int, string)]

## sursa: http://www.kbdedit.com/manual/low_level_vk_list.html

let keysReadable: keys = @[
    # "Mappable" codes
            # TODO
    # "Non-mappable" codes
    0xFF: "[NO VK MAPPING]", # VK__none_
    0x1E: "[ACCEPT]", # VK_ACCEPT
    0x5D: "[CONTEXT MENU]", # VK_APPS
    0xA6: "[BROWSER BACK]", # VK_BROWSER_BACK
    0xAB: "[BROWSER FAVORITES]", # VK_BROWSER_FAVORITES
    0xA7: "[BROWSER FORWARD]", # VK_BROWSER_FORWARD
    0xAC: "[BROWSER HOME]", # VK_BROWSER_HOME
    0xA8: "[BROWSER REFRESH]", # VK_BROWSER_REFRESH
    0xAA: "[BROWSER SEARCH]", # VK_BROWSER_SEARCH
    0xA9: "[BROWSER STOP]", # VK_BROWSER_STOP
    0x14: "[CAPS LOCK]", # VK_CAPITAL
    0x1C: "[CONVERT]", # VK_CONVERT
    0x2E: "[DELETE]", # VK_DELETE
    0x28: "[ARROW DOWN]", # VK_DOWN
    0x23: "[END]", # VK_END
    0x70: "[F1]", # VK_F1
    0x79: "[F10]", # VK_F10
    0x7A: "[F11]", # VK_F11
    0x7B: "[F12]", # VK_F12
    0x7C: "[F13]", # VK_F13
    0x7D: "[F14]", # VK_F14
    0x7E: "[F15]", # VK_F15
    0x7F: "[F16]", # VK_F16
    0x80: "[F17]", # VK_F17
    0x81: "[F18]", # VK_F18
    0x82: "[F19]", # VK_F19
    0x71: "[F2]", # VK_F2
    0x83: "[F20]", # VK_F20
    0x84: "[F21]", # VK_F21
    0x85: "[F22]", # VK_F22
    0x86: "[F23]", # VK_F23
    0x87: "[F24]", # VK_F24
    0x72: "[F3]", # VK_F3
    0x73: "[F4]", # VK_F4
    0x74: "[F5]", # VK_F5
    0x75: "[F6]", # VK_F6
    0x76: "[F7]", # VK_F7
    0x77: "[F8]", # VK_F8
    0x78: "[F9]", # VK_F9
    0x18: "[FINAL]", # VK_FINAL
    0x2F: "[HELP]", # VK_HELP
    0x24: "[HOME]", # VK_HOME
    0xE4: "[ICO00]", # VK_ICO_00
    0x2D: "[INSERT]", # VK_INSERT
    0x17: "[JUNJA]", # VK_JUNJA
    0x15: "[KANA]", # VK_KANA
    0x19: "[KANJI]", # VK_KANJI
    0xB6: "[APP1]", # VK_LAUNCH_APP1
    0xB7: "[APP2]", # VK_LAUNCH_APP2
    0xB4: "[MAIL]", # VK_LAUNCH_MAIL
    0xB5: "[MEDIA]", # VK_LAUNCH_MEDIA_SELECT
    0x01: "[LEFT BUTTON]", # VK_LBUTTON
    0xA2: "[LEFT CTRL]", # VK_LCONTROL
    0x25: "[ARROW LEFT]", # VK_LEFT
    0xA4: "[LEFT ALT]", # VK_LMENU
    0xA0: "[LEFT SHIFT]", # VK_LSHIFT
    0x5B: "[LEFT WIN]", # VK_LWIN
    0x04: "[MIDDLE BUTTON]", # VK_MBUTTON
    0xB0: "[NEXT TRACK]", # VK_MEDIA_NEXT_TRACK
    0xB3: "[PLAY / PAUSE]", # VK_MEDIA_PLAY_PAUSE
    0xB1: "[PREVIOUS TRACK]", # VK_MEDIA_PREV_TRACK
    0xB2: "[STOP]", # VK_MEDIA_STOP
    0x1F: "[MODE CHANGE]", # VK_MODECHANGE
    0x22: "[PAGE DOWN]", # VK_NEXT
    0x1D: "[NON CONVERT]", # VK_NONCONVERT
    0x90: "[NUM LOCK]", # VK_NUMLOCK
    0x92: "[JISHO]", # VK_OEM_FJ_JISHO
    0x13: "[PAUSE]", # VK_PAUSE
    0x2A: "[PRINT]", # VK_PRINT
    0x21: "[PAGE UP]", # VK_PRIOR
    0x02: "[RIGHT BUTTON]", # VK_RBUTTON
    0xA3: "[RIGHT CTRL]", # VK_RCONTROL
    0x27: "[ARROW RIGHT]", # VK_RIGHT
    0xA5: "[RIGHT ALT]", # VK_RMENU
    0xA1: "[RIGHT SHIFT]", # VK_RSHIFT
    0x5C: "[RIGHT WIN]", # VK_RWIN
    0x91: "[SCROL LOCK]", # VK_SCROLL
    0x5F: "[SLEEP]", # VK_SLEEP
    0x2C: "[PRINT SCREEN]", # VK_SNAPSHOT
    0x26: "[ARROW UP]", # VK_UP
    0xAE: "[VOLUME DOWN]", # VK_VOLUME_DOWN
    0xAD: "[VOLUME MUTE]", # VK_VOLUME_MUTE
    0xAF: "[VOLUME UP]", # VK_VOLUME_UP
    0x05: "[X BUTTON 1]", # VK_XBUTTON1
    0x06: "[X BUTTON 2]", # VK_XBUTTON2
]
