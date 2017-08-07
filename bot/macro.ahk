#Include, common.ahk
#MaxThreadsPerHotkey 1
ProcessName := "FFXIVGAME"

hasFood := True
collectible := False
times := 30
timeOne := 42000
timeTwo := 28000
foodLeft := 38

foodCounter := foodLeft * 60 * 1000
timePerFood := 40 * 60 * 1000
eatFoodThreshold := 5 * 60 * 1000
willTake := 0

class Macro {
	sequence := []
	timeTook := 0
	hasFood := False
}

; New Macros ------------------------------------------------>
; 70 - 70/80 Dur - 1. 38500 2. 17000


; Old Macros ------------------------------------------------>
; 40 Durability
; 60 to 65 craft 40 Dur - 1. 37000 2. 27000 Time took: 70.32
; 60 to 65 craft 80 Dur - 1. 40000 2. 35000 Time Took: 75
; 
; 80 Durability
; 60 to 65 craft 80 Dur - 1. 37000 2. 38000 Time Took: 82.125 no peice by peice

; 66 - 70
; 66 to 70 craft 80 Dur - 1. 42000 2. 28000 Time Took:  80.12
; 66 to 70 craft 40 Dur - 1. 38000 2. 21000 Time Took:  65.34

; 1 Star
; 1 star 70 - 1. 40000 2. 32000  Time took: 78.5


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
timeTook := 0

; Main
Main()

Return

; ----------------------------------------------------------
; 	Functions
; ----------------------------------------------------------

Main() {
	global

	running := True
	Log("Crafting: " times " runs`n")
	Run(times)
}

Run(iterations) {
	global

	Loop %iterations% {
		Log("Starting iteration: " A_Index "/" iterations) 

		; Check that food
		if (hasFood) {
			; check food 
			foodCounter := Abs(foodCounter) - Abs(timeTook)
			Log("Food counter has " foodCounter / 60000 "m")

			if (Abs(foodCounter) < Abs(eatFoodThreshold)) {
				OutOfCrafting()
				EatFood()
				IntoCrafting()
				; up the amount of food on the food couter
				foodCounter := foodCounter + timePerFood
			}
		}

		StartSynthesis()
		SendToGame("{1}", timeOne)
		SendToGame("{2}", timeTwo)
		Sleep 2000
		if collectible
			EndCollectable() 
		
		; Time Stuff
		; time took in milliseconds
		timeTook := A_TickCount - elapsedTime
		; estimated time that it will take is timeTook * number of times Left
		; number of times left is iterations - the current index
		willTake := (timeTook * (iterations - A_Index)) / 1000 
		Log("Iteration took: " timeTook / 1000 "s")
		Log("Estimated Time Left: " willTake / 60 "m`n")
		elapsedTime := A_TickCount

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
	Sleep 1500
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
	Sleep 2000
	Return
}

OutOfCrafting() {
	SendToGame("{esc}", 500)
	Sleep 5000
}

IntoCrafting() {
	SendToGame("n", 500)
}