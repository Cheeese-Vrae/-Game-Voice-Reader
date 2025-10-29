#Requires AutoHotkey v2

scriptPath := "C:\OCR\Game Voice Reader.ahk"

; Prompt user for new key
result := InputBox("Enter the new key to trigger OCR (e.g., F12, XButton2, Space):", "Remap Action Key")
newKey := result.Value

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

; Replace only the KeyWait line
newScript := RegExReplace(scriptText, 'KeyWait\s+"[^"]+",\s*"D"', 'KeyWait "' . newKey . '", "D"')

; Replace only the GetKeyState line that matches the KeyWait key
; This line looks like: if !GetKeyState("F10", "P")
newScript := RegExReplace(newScript, 'if\s+!GetKeyState\("F10",\s*"P"\)', 'if !GetKeyState("' . newKey . '", "P")')

try {
    FileDelete(scriptPath)
    FileAppend(newScript, scriptPath)
    MsgBox("✅ Action key successfully remapped to: " . newKey)
} catch {
    MsgBox("❌ Failed to update the script. Please check file permissions.")
}

ExitApp
