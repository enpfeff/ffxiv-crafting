#Include, common.ahk
#MaxThreadsPerHotkey 1
ProcessName := "FFXIVGAME"
times := 5
foodLeft := 56
foodCounter := foodLeft * 60 * 1000
timePerFood := 30 * 60 * 1000
eatFoodThreshold := 3 * 60 * 1000

; 60 to 65 craft 40 Dur - 1. 40000 2. 35000
; 1 star 70 - 1. 40000 2. 32000 

; ----------------------------------------------------------
; 	Stop
; ----------------------------------------------------------
^F2::
Stop()
Return

; ----------------------------------------------------------
; 	Start
; ----------------------------------------------------------
^F1::
WinGet, programid, List, FINAL FANTASY
; Global Time / State Vars
running := True
startTime := A_TickCount
elapsedTime := A_TickCount

; Main
Main()

Return

; ----------------------------------------------------------
; 	Functions
; ----------------------------------------------------------

Main() {
	global

	running := True
	Log("Crafting: " times " runs")
	Run(times)
}

Run(iterations) {
	global

	Loop %iterations% {
		Log("Starting iteration: " A_Index "/" iterations) 
		
		StartSynthesis()
		SendToGame("{1}", 40000)
		SendToGame("{2}", 32000)
		Sleep 2000
		; EndCollectable() 
		
		; Time Stuff
		timeTook := A_TickCount - elapsedTime
		Log("Iteration took " (timeTook) / 1000 "s")
		elapsedTime := A_TickCount

		; check food 
		foodCounter := Abs(foodCounter) - Abs(timeTook)
		Log("Food counter has " foodCounter / 60000 "m")

		; We need to eat food,  
		if (Abs(foodCounter) < Abs(eatFoodThreshold)) {
			OutOfCrafting()
			EatFood()
			IntoCrafting()
			; up the amount of food on the food couter
			foodCounter := foodCounter + timePerFood
		}

		; Stop?
		if not running
			break
	}
	Log("Done took: " (A_TickCount - startTime) / 60000 "m")
	Return
}

Stop() {
	global running

	running := False
	Log("Stopping Iteration after next loop")
	Return
}

StartSynthesis() {	
	SendToGame("{Numpad0}", 750)	
	SendToGame("{Numpad0}", 1000)
	SendToGame("{Numpad0}", 500)
	Sleep 2000
}
EndCollectable() {
	SendToGame("{Numpad0}", 750)	
	SendToGame("{Numpad0}", 1000)
	Sleep 2000
}

SendToGame(KeyToSend, SleepTime) {
	global ProcessName
	ControlSend,, %KeyToSend%, ahk_class %ProcessName%
	Sleep %SleepTime%
}

EatFood() {
	Log("Eating Food now")
	SendToGame("{3}", 3000)
	Return
}

OutOfCrafting() {
	SendToGame("{esc}", 500)
	SendToGame("{esc}", 500)
}

IntoCrafting() {
	SendToGame("n", 500)
}