;; v2
#Include "%A_ScriptDir%\libv2.ahk"

toggle := 1
#MaxThreadsPerHotkey 2
PgDn::{
  global toggle
  toggle := !toggle
  if toggle {
    SoundBeep 750, 100
    Sleep 100
    SoundBeep 750, 100
  } else {
    SoundBeep 750, 100
  }
  Pause !toggle
}

;;
SetKeyDelay 200, 100  ; 75ms between keys, 25ms between down/up.

EnterPauseScreen(){
  logf("entering pause screen")
  ; while(!PixelColorClose(318, 79, 0xFDFDFD)){
  ; while(!PixelColorClose(318, 79, 0xE7E7E7)){
  while(!PixelColorClose(318, 79, 0x000000c)){
    logf("pressing Esc")
    Send "{Esc}"
    Sleep 1000
  }
  logf("entered pause screen")
}

LoadGame(){
  EnterPauseScreen()

  ;; LOAD GAME
  logf("entering load game screen")
  while(!PixelColorClose(529, 136, 0x000000)){
    logf("clicking LOAD GAME")
    Click 330, 470
    Sleep 1000
  }
  logf("entered load game screen")

  ;; 4th entry
  while(!PixelColorClose(1145, 479, 0xDDCFB4)){
    logf("clicking 4th entry")
    Click 1050, 389
    Sleep 1000
  }
  logf("clicked 4th entry")

  ;; confirm lost progress
  logf("confirming lost progress")
  while(PixelColorClose(866, 572, 0xFFFFFF)){
    logf("pressing Enter")
    Send "{Enter}"
    Sleep 1000
  }
  logf("confirmed lost progress")

  ;; wait loading screen
  Sleep 5000
  logf("loading game")

  ;; till inside game
  logf("skipping loading screen")
  while(!PixelColorClose(960, 540, 0x000000)){
    logf("pressing Enter")
    Send "{Enter}"
    Sleep 1000
  }
  while(PixelColorClose(960, 540, 0x000000)){
    logf("waiting game")
    Sleep 1000
  }
  logf("exited loading screen")
}

SkipDialog(){
  logf("skipping dialog")
  ; while(!PixelColorClose(1728, 946, 0x685942)){
  while(!PixelColorClose(1735, 972, 0x695942)){
    logf("pressing Space")
    Send "{Space}"
    Sleep 100
  }
  Sleep 2000
  logf("entered game screen")
}

CheckSword(){
  ;; inventory screen
  logf("entering inventory screen")
  while(!PixelColorClose(300, 68, 0xFFFFFF)){
    logf("pressing i")
    Send "{i}"
    Sleep 1000
  }
  logf("entered inventory screen")

  ;; click sword
  while(!PixelColorClose(191, 438, 0xACA5A2)){
    Click 70, 332
    logf("clicking sword")
    Click 145, 332
    Sleep 1000
  }

  Send "#!{PrintScreen}"
  Sleep 3000

  ;; back to game screen
  logf("entering game screen")
  ; while(!PixelColorClose(1728, 946, 0x685942)){
  while(!PixelColorClose(1735, 972, 0x695942)){
    logf("pressing i")
    Send "{i}"
    Sleep 1000
  }
  logf("entered game screen")
}

;; not required. Danger! Overwrite latest save!
; SaveGame(){
;   EnterPauseScreen()

;   ;; SAVE GAME
;   while(!PixelColorClose(529, 136, 0x000000)){
;     logf("clicking SAVE GAME")
;     Click 330, 425
;     Sleep 1000
;   }
;   logf("save game screen")

;   ;; 2ed entry
;   while(!PixelColorClose(1167, 421, 0xDDCFB4)){
;     logf("clicking 2nd entry")
;     Click 792, 262
;     Sleep 100
;   }

;   ;; confirm lost progress
;   while(PixelColorClose(1167, 421, 0xFFFFFF)){
;     logf("confirming lost progress")
;     Send "{Enter}"
;     Sleep 1000
;   }

;   ;; back to game screen
;   logf("entering game screen")
;   while(!PixelColorClose(1728, 946, 0x685942)){
;     logf("pressing Esc")
;     Send "{Esc}"
;     Sleep 1000
;   }
;   logf("entered game screen")

;   Sleep 5000
; }

CopySave(){
  latest_time_created := 0
  latest_file := ""
  Loop Files, A_MyDocuments "\The Witcher 3\gamesaves\*.sav" {
    If (A_LoopFileTimeCreated > latest_time_created){
      latest_time_created := A_LoopFileTimeCreated
      latest_file := A_LoopFileName
    }
  }
  FileCopy A_MyDocuments "\The Witcher 3\gamesaves\" latest_file, A_MyDocuments "\The Witcher 3\gamesaves\hjalmar sword\", 1
}


PgUp::{
  while(1){
    LoadGame()
    SkipDialog()
    CheckSword()
    CopySave()
  }
}
