🎮 Game Voice Reader – README

📦 What It Does

Game Voice Reader lets you capture in-game text using a red selection box and have it read aloud automatically using your browser. It uses OCR (Optical Character Recognition) and Microsoft Edge to display and vocalize the text.

🛠️ Setup Instructions
1. Install AutoHotkey  
   Download and install from: https://www.autohotkey.com/

2. Place the OCR Folder  
   Move the entire OCR folder to the root of your C: drive.  
   Your path should look like: C:\OCR

3. Run the Script  
   Double-click the file named: Game Voice Reader.ahk  
   Tip: Right-click and choose “Run as administrator” for better compatibility in some games.

4. Keep Edge Open  
   Do not close the Microsoft Edge window that opens.  
   Do not switch tabs in that window.  
   Best experience: keep the Edge window maximized.

5. Done!  
   You're ready to use Game Voice Reader in your games.

🎮 Usage Instructions
1. Game Display Mode  
   Your game must be running in borderless full-screen or windowed mode.  
   Exclusive full-screen is not supported.

2. Trigger OCR  
   Hold down F10 (or your custom trigger key) and drag the red box over the text you want to read.

3. Voice Options  
   After the text is read, you can open the Edge window and click “Voice Options” (top-right) to choose a different voice.

4. Cancel Scan  
   Press Right Click while the red box is visible to cancel the scan.

5. Exit Script  
   While holding the trigger key, press F9 to stop the script.

🔁 Remapping the Trigger Key
If you want to change the default trigger key (F10) to something else:

1. Run the script: Remap Game Voice Reader Key.ahk
2. Enter your desired key (e.g., F12, XButton2, Space).
3. The script will automatically update Game Voice Reader.ahk with your new key.
4. Done! You can now use your preferred key to activate the red box.

💬 Need Help?
If something isn’t working as expected, double-check:
- That AutoHotkey is installed
- That the OCR folder is in C:\OCR
- That Edge is open and on the correct tab
- That your game is not in exclusive full-screen mode

Many thanks to the original https://github.com/KnightDevRedEmber/GameVoiceReader, from which this script takes a great inspiration!
