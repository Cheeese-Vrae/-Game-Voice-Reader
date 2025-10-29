#Requires AutoHotkey v2

scriptPath := "C:\OCR\Game Voice Reader.ahk"
global newKey := ""

MsgBox("Press the key or mouse button you want to use as the new trigger for OCR.")

; List of keys to monitor
hotkeys := [
    "F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12",
    "Space","Enter","Tab","Escape","Up","Down","Left","Right",
    "LButton","RButton","MButton","XButton1","XButton2",
    "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
    "1","2","3","4","5","6","7","8","9","0"
]

HotIfWinActive("Remap Trigger Key")
for key in hotkeys {
    Hotkey("*" . key, SetTriggerKey.Bind(key), "On")
}

remapGui := Gui("+AlwaysOnTop -SysMenu", "Remap Trigger Key")
remapGui.Add("Text",, "Press any key or mouse button to use as the new trigger:")
remapGui.Show("w300 h100")

Loop {
    if newKey != "" {
        break
    }
    Sleep 50
}

remapGui.Destroy()

for key in hotkeys {
    Hotkey("*" . key, "Off")
}

try {
    scriptText := FileRead(scriptPath)
} catch {
    MsgBox("Could not read the Game Voice Reader script at:`n" scriptPath)
    ExitApp
}

; Replace only the triggerKey assignment line
newScript := RegExReplace(scriptText, 'triggerKey\s*:=\s*"[^"]+"', 'triggerKey := "' . newKey . '"')

try {
    FileDelete(scriptPath)
    FileAppend(newScript, scriptPath)
    MsgBox("✅ Action key successfully remapped to: " . newKey)
} catch {
    MsgBox("❌ Failed to update the script. Please check file permissions.")
}

ExitApp

SetTriggerKey(key, *) {
    global newKey := key
}
