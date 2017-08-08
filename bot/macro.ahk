#Include, common.ahk
#MaxThreadsPerHotkey 1
ProcessName := "FFXIVGAME"

; ----------------------------------------------------------
; 	First Class Vars (Change these)
; ----------------------------------------------------------
; Which Macro do you want to use
macroKey := "60to70dur80"
; Are you crafting a collectible?
collectible := False
; How many times do you want to craft it
times := 30
; if you are using food how much food is left in minutes
foodLeft := 38
; how much time is added to food after each eatting
timePerFood := 40 * 60 * 1000
; at what point in time do you want to eat more food (5 minutes left)
eatFoodThreshold := 3 * 60000
; what button is the food on?
foodKey := 9


; ----------------------------------------------------------
; 	Macro Definitions
; ----------------------------------------------------------
class Macro {
	; an object with the key being what button and the value
	; being how long to wait after pressing it
	sequence := Object()
	hasFood := False

	__New(sequence, hasFood) {
		this.sequence := sequence
		this.hasFood := hasFood
	}
}

macros := {}
; 50 < Level < 60 all durability
macros["old"] := New Macro(Object("1", 38500, "2", 17000), False)
; 66 - 70 80 Durability
macros["60to70dur80"] := New Macro(Object("3", 42000, "4", 28000), True)
; 66 - 70 40 Durability
macros["60to70dur40"] := New Macro(Object("5", 38000, "6", 21000), True)
; Level 70 1 star
macros["1star"] := New Macro(Object("7", 40000, "8", 32000), True)


; ----------------------------------------------------------
; 	Stop
; 	Triggering this will stop the craft at the end of the 
;   current iteration
; ----------------------------------------------------------
^F2::
Stop()
Return


; ----------------------------------------------------------
; 	Start
; 	Assuming you set all the variables correctly this will
; ----------------------------------------------------------
^F1::
WinGet, programid, List, FINAL FANTASY
; Global Time / State Vars
running := True
startTime := A_TickCount
elapsedTime := A_TickCount
timeTook := 0
willTake := 0
foodCounter := foodLeft * 60 * 1000

; Main
Main()

Return

; ----------------------------------------------------------
; 	Functions
; ----------------------------------------------------------

Main() {
	global

	running := True
	Log("Crafting: " times " runs, with " macroKey "`n")
	Run(times, macros[macroKey])
}

Run(iterations, macro) {
	global

	Loop %iterations% {
		Log("Starting iteration: " A_Index "/" iterations) 

		; Check that food
		if (macro.hasFood) {
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

		For button, duration in macro.sequence {
			aButton := "{" button "}"
			SendToGame(aButton, duration)
		}

		Sleep 1500
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
		if not running {
			Log("Done took: " (A_TickCount - startTime) / 60000 "m")
			break
		}
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
	Sleep 1250
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
	global

	Log("Eating Food now")
	button := "{" foodKey "}"
	SendToGame(button, 3000)
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