#Requires AutoHotkey v2
#include .\Lib\OCR.ahk
InstallKeybdHook 1, 1
#UseHook 1

triggerKey := "MButton"  ; Remapping script will update this line

CoordMode "Mouse", "Screen"
CoordMode "ToolTip", "Screen"

DllCall("SetThreadDpiAwarenessContext", "ptr", -3)
OCR.PerformanceMode := 1

f9::exitapp

global w := 1200, h := 400, minsize := 5, step := 21, toRun := 0, prevWin := 0, toSay := "", hbuffer := 0, bX := 0, bY := 0, bW := 0, bH := 0, cX := 0, cY := 0

Loop {
	if toRun == 0 {
		hbuffer := 8
		Suspend 1
		KeyWait triggerKey, "D"
		MouseGetPos(&x, &y)
		cX := x
		cY := y
		toRun := 1

		if !WinExist("ahk_exe msedge.exe") {
			Run 'msedge.exe "https://onlinenotepad.org/notepad#google_vignette"'
			Sleep 2000
		}
	}
	else if toRun == 1 {
		Suspend 0

		if (hbuffer > 0) {
			hbuffer -= 1
		} else {
			MouseGetPos(&x, &y)
		}

		w := x - cX
		h := y - cY

		inArea := 0
		if (Abs(x - bX) < bW // 2) && (Abs(y - bY) < bH // 2) || hbuffer > 0 {
			inArea := 1
		}

		x := x - w // 2
		y := y - h // 2

		if (bH != 0) {
			if (inArea) {
				x := bX
				y := bY
				h := bH
				w := bW
				Highlight(bX - bW // 2, bY - bH // 2, bW, bH, "Red")
			} else {
				Highlight(bX - bW // 2, bY - bH // 2, bW, bH, "Blue")
				Highlight(x - w // 2, y - h // 2, w, h, "Red")
			}
		} else {
			Highlight(x - w // 2, y - h // 2, w, h, "Red")
		}

		if GetKeyState("LButton", "P") {
			if (!inArea) {
				bX := x
				bY := y
				bH := h
				bW := w
			} else {
				bX := 0
				bY := 0
				bH := 0
				bW := 0
			}
		}

		if !GetKeyState(triggerKey, "P") || GetKeyState("LButton", "P") {
			if hbuffer > 0 {
				prevClip := A_Clipboard
				A_Clipboard := ""
				Send "^c"
				Sleep 20

				if (A_Clipboard != prevClip) {
					toSay := A_Clipboard
					A_Clipboard := prevClip
				}
			}

			if StrLen(toSay) <= 0 {
				toSay := OCR.FromRect(x - w // 2, y - h // 2, w, h,, 2).Text
			}

			Highlight(-100, -100, 0, 0, "Red")

			if StrLen(toSay) > 0 {
				prevWin := WinGetID("A")

				WinActivate "ahk_exe msedge.exe"
				Sleep 500

				WinGetPos &wx, &wy, &ww, &wh, "ahk_exe msedge.exe"
				MouseClick "left", wx + ww // 2, wy + wh // 2
				Sleep 300

				Send "^a"
				Sleep 100
				Send "{Delete}"
				Sleep 100
				A_Clipboard := toSay
				Send "^v"
				Sleep 200
				Send "^a"
				Sleep 100
				Send "^+u"
				Sleep 1500

				toSay := ""
				WinActivate prevWin
				toRun := 0
			} else {
				toRun := 0
				Sleep 200
			}

			Suspend 1
		}
		else if GetKeyState("RButton") {
			toRun := 0
			Highlight(-100, -100, 0, 0, "Red")
			Sleep 1200
		}

		Sleep 25
	}
}

Highlight(x?, y?, w?, h?, color?, showTime := 0, d := 2) {
	static guis := []

	if IsSet(color) && (color == "Res") {
		showTime := 500
	}
	else if !IsSet(x) {
		for _, r in guis
			r.Destroy()
		guis := []
		return
	}
	if !guis.Length || toRun == 0 {
		Loop 4
			guis.Push(Gui("+AlwaysOnTop -Caption +ToolWindow -DPIScale +E0x08000000"))
	}
	Loop 4 {
		i := A_Index
		x1 := (i = 2 ? x + w : x - d)
		y1 := (i = 3 ? y + h : y - d)
		w1 := (i = 1 or i = 3 ? w + 2 * d : d)
		h1 := (i = 2 or i = 4 ? h + 2 * d : d)
		guis[i].BackColor := color
		guis[i].Show("NA x" . x1 . " y" . y1 . " w" . w1 . " h" . h1)
	}
	if showTime > 0 {
		Sleep showTime
		Highlight()
	} else if showTime < 0 {
		SetTimer(Highlight, -Abs(showTime))
	}
}
