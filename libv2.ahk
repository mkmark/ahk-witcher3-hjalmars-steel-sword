;; v2
SendMode "Event"
SetWorkingDir(A_ScriptDir)

;; run as admin
;; https://lexikos.github.io/v2/docs/commands/Run.htm#RunAs
; full_command_line := DllCall("GetCommandLine", "str")
; if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)")){
;   try  {
;     if A_IsCompiled
;       Run '*RunAs "' A_ScriptFullPath '" /restart'
;     else
;       Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
;   }
;   ExitApp
; }
; MsgBox A_IsAdmin: %A_IsAdmin%`nCommand line: %full_command_line%

;; log
;; https://www.autohotkey.com/board/topic/89516-iso-8601formatting-datetime/
logf(str){
  formatted_now := FormatTime(A_Now, "yyyy-MM-ddTHH:mm:ss ")
  formatted_today := FormatTime(A_Now, "yyyy-MM-dd")
  try{
    FileAppend formatted_now str "`n", "log/" formatted_today ".log"
  }
}

;; https://lexikos.github.io/v2/docs/commands/WinMove.htm
CenterWindow(WinTitle){
  WinGetPos ,, &Width, &Height, WinTitle
  WinMove (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2),,, WinTitle
}

;; https://www.autohotkey.com/boards/viewtopic.php?t=75606
RGBfromColor(color) {
  return {r: (0xFF0000 & color) >> 16, g: (0xFF00 & color) >> 8, b: 0xFF & color}
}
ColorRGBCompare(col1, col2, tol) {
  col1 := RGBfromColor(col1)
  col2 := RGBfromColor(col2)
  return (Abs(col1.r - col2.r) + Abs(col1.g - col2.g) + Abs(col1.r - col2.r) <= tol)
}
PixelColorClose(x, y, target, tol:=25){
  source := PixelGetColor(x, y)
  logf(source)
  return ColorRGBCompare(source, target, tol)
}
