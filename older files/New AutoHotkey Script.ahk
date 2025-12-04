#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#Include Chrome.ahk

; Create an instance of the Chrome class using
; the folder ChromeProfile to store the user profile
FileCreateDir, ChromeProfile
ChromeInst := new Chrome("ChromeProfile")

; Connect to the newly opened tab and navigate to another website
; Note: If your first action is to navigate away, it may be just as
; effective to provide the target URL when instantiating the Chrome class
PageInst := ChromeInst.GetPage()
PageInst.Call("Page.navigate", {"url": "https://www.youtube.com/"})
PageInst.WaitForLoad()

MsgBox, %A_AppData%`n%A_thisLabel% - %A_LineFile% - line: %A_LineNumber%

;Pause


;ExitApp
return


Numpad0::
; Execute some JavaScript
PageInst.Evaluate("document.getElementById('menu-item-14600').click()")
return



^f4::
;~ Close the browser (note: this closes *all* pages/tabs)
PageInst.Call("Browser.close")
PageInst.Disconnect()
return