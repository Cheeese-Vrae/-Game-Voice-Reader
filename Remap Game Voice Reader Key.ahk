#Requires AutoHotkey v2

scriptPath := "C:\OCR\Game Voice Reader.ahk"

; Show input box and capture result object
result := InputBox("Enter the new key to trigger OCR (e.g., F12, XButton2, Space):", "Remap Action Key")

; Extract the actual string value
newKey := result.Value

; If user cancels or enters nothing
if newKey == "" {
    MsgBox("Remapping cancelled.")
    ExitApp
}

try {
    scriptText := FileRead(scriptPath)
} catch {
    MsgBox("Could not read the Game Voice Reader script at:`n" scriptPath)
    ExitApp
}

; Replace KeyWait line
newScript := RegExReplace(scriptText, 'KeyWait\s+"[^"]+",\s*"D"', 'KeyWait "' . newKey . '", "D"')

; Replace GetKeyState line
newScript := RegExReplace(newScript, 'GetKeyState\("([^"]+)",\s*"P"\)', 'GetKeyState("' . newKey . '", "P")')

try {
    FileDelete(scriptPath)
    FileAppend(newScript, scriptPath)
    MsgBox("✅ Action key successfully remapped to: " . newKey)
} catch {
    MsgBox("❌ Failed to update the script. Please check file permissions.")
}

ExitApp