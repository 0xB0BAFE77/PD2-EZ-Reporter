; Script written by Steam user 0xB0BAFE77
; http://steamcommunity.com/profiles/76561197967463466/
; This program is open source and is to be used in troubleshooting the game PAYDAY 2.
; I have authroized Overkill to distribute this at their discretion to assist their users.

;============================== Start Auto-Execution Section ==============================
; Always run as admin
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}

; Determines how fast a script will run (affects CPU utilization).
; The value -1 means the script will run at it's max speed possible.
SetBatchLines, -1

; Avoids checking empty variables to see if they are environment variables.
; Recommended for performance and compatibility with future AutoHotkey releases.
#NoEnv

; Ensures that there is only a single instance of this script running.
#SingleInstance, Force

; Disables the system tray icon.
#NoTrayIcon

; Ensures that the path of the 64-bit Program Files directory is returned if the OS is 64-bit and the script is not.
SetRegView 64

;============================== Main Script ==============================
; Used to add icon to taskbar button and systray (which is hidden)
Menu, Tray, Icon, PD2.ico

; Generate GUI
Gui, -Caption +Border
Gui, Color, 000033
Gui, Font, s18 c07A3FF bold
Gui, Add, Text, x12 y10 w220 h40 +Center, PD2 EZ Reporter
Gui, Font, s12 cBlue c07A3FF underline 
Gui, Add, Text, x12 y250 w220 h25 gPD2Skills, pd2skills.com
Gui, Font

Gui, Font, s10 cWhite
Gui, Add, CheckBox, x12 y50 w160 h30 vmodCheck Checked, Check for IPHLPAPI.dll
Gui, Add, CheckBox, x12 y80 w140 h30 vcrashCheck Checked, Most recent crash
Gui, Add, CheckBox, x12 y110 w170 h30 vrenderCheck Checked, Renderer_settings.xml
Gui, Add, CheckBox, x12 y140 w160 h30 vcrashFullCheck, All crashes recorded
Gui, Add, Text, x12 y180 w220 h70 , You may be asked to provide your spec. This is to determine if a skill is causing the issue.`nPlease create your build here.
Gui, Font

Gui, Font, Bold
Gui, Add, Button, x12 y290 w100 h30 gRunAndDone, Generate Report
Gui, Add, Button, x142 y290 w100 h30 gGuiClose, Exit
Gui, Show, x50 y50 w250 h340, PD2 EZ Reporter
OnMessage( 0x200, "WM_MOUSEMOVE")
return

; Makes GUI dragable.
WM_MOUSEMOVE(wparam, lparam, msg, hwnd)
{
	if wparam = 1 ; LButton
		PostMessage, 0xA1, 2,,, A ; WM_NCLBUTTONDOWN
}

; Provides hyperlink to pd2skills website
PD2Skills:
	Run, http://pd2skills.com/
return

; Run report to be copy and pasted
RunAndDone:
Gui, Submit

; Read registry location and get user's install path. Ensures PD2 is installed.
; HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 218620
; Key: InstallLocation
RegRead, installPath, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 218620, InstallLocation

; Delete old crash files
FileDelete, %A_Temp%\PD2EZCrash.txt

; Check for presence of iphlpapi.dll
If (modCheck = 1){
	; Get full crash data
	IfExist %installPath%\iphlpapi.dll
		tmpLog	:= "present"
	else
		tmpLog	:= "not present"
}
else
	tmpLog	:= "User did not check this."

; Write to log
FileAppend, IPHLPAPI.dll is %tmpLog% in the Payday 2 main folder.`n`n`n, %A_Temp%\PD2EZCrash.txt


; Get crash file info
If (crashCheck = 1){
	; Get crash data
	IfExist %A_AppData%\..\Local\PAYDAY 2\crash.txt
	{
		FileRead, tmpLog, %A_AppData%\..\Local\PAYDAY 2\crash.txt
		; Removes all blank lines
		Loop
		{
			StringReplace, tmpLog, tmpLog, `n`n, `n, UseErrorLevel
			if ErrorLevel = 0
				break
		}
	}
	else
		tmpLog	:= "Crash log could not be found."	
}
else
	tmpLog	:= "User did not check this."

; Write to log
FileAppend, Most recent crash log:`n, %A_Temp%\PD2EZCrash.txt
FileAppend, ============================================================`n, %A_Temp%\PD2EZCrash.txt
FileAppend, %tmpLog%`n`n`n, %A_Temp%\PD2EZCrash.txt


; Get renderer_settings.xml info
If (renderCheck = 1){
	; Get full crash data
	IfExist %A_AppData%\..\Local\PAYDAY 2\renderer_settings.xml
	{
		FileRead, tmpLog, %A_AppData%\..\Local\PAYDAY 2\renderer_settings.xml
		Loop
		{
			StringReplace, tmpLog, tmpLog, `n`n, `n, UseErrorLevel
			if ErrorLevel = 0
				break
		}
	}
	else
		tmpLog	:= "Full crash log could not be found."	
}
else
	tmpLog	:= "User did not check this."

; Write to log
FileAppend, Renderer_settings.xml:`n, %A_Temp%\PD2EZCrash.txt
FileAppend, ============================================================`n, %A_Temp%\PD2EZCrash.txt
FileAppend, %tmpLog%`n`n`n, %A_Temp%\PD2EZCrash.txt

; Get full crash file info
If (crashFullCheck = 1){
	; Get full crash data
	IfExist %A_AppData%\..\Local\PAYDAY 2\crashlog.txt
	{
		FileRead, tmpLog, %A_AppData%\..\Local\PAYDAY 2\crashlog.txt
		Loop
		{
			StringReplace, tmpLog, tmpLog, `n`n, `n, UseErrorLevel
			if ErrorLevel = 0
				break
		}
	}
	else
		tmpLog	:= "Full crash log could not be found."	
}
else
	tmpLog	:= "User did not check this."

; Write to log
FileAppend, Full Crash Log:`n, %A_Temp%\PD2EZCrash.txt
FileAppend, ============================================================`n, %A_Temp%\PD2EZCrash.txt
; Removes all blank lines
Loop
{
    StringReplace, tmpLog, tmpLog, `r`n`r`n, `r`n, UseErrorLevel
    if ErrorLevel = 0
        break
}
FileAppend, %tmpLog%`n`n`n, %A_Temp%\PD2EZCrash.txt

Sleep, 50
IfExist %A_Temp%\PD2EZCrash.txt
	Run, %A_Temp%\PD2EZCrash.txt
else
	MsgBox, Could not generate crash report.`nClosing PD2 EZ Reporter.
ExitApp

GuiClose:
ExitApp

;============================== 0xB0BAFE77==============================
;============================== End Script ==============================