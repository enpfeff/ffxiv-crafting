#Include, common.ahk
#MaxThreadsPerHotkey 1
ProcessName := "FFXIVGAME"

; ----------------------------------------------------------
; 	First Class Vars (Change these)
; ----------------------------------------------------------
; Which Macro do you want to use
macroKey := "3starSpecial"
; Are you crafting a collectible?
collectible := False
; How many times do you want to craft it
times := 52
; if you are using food how much food is left in minutes
foodLeft := 20
; how much time is added to food after each eatting
timePerFood := 40 * 60000
; at what point in time do you want to eat more food (5 minutes left)
eatFoodThreshold := 3 * 60000
; what button is the food on?
foodKey := "="
; Sometimes the macro doesnt need food
foodOverride := False

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

macros["502star"] := New Macro(Object("6", 18500), False)
macros["503star"] := New Macro(Object("1", 20000), False)
macros["68andBelow"] := New Macro(Object("7", 40500), False)
macros["68below40"] := New Macro(Object("0", 39000), False)
macros["60to70dur80"] := New Macro(Object("2", 37000, "3", 19000), False)
macros["3star"] := New Macro(Object("8", 38000, "9", 42000), False)
macros["3starSpecial"] := New Macro(Object("8", 41000, "9", 42000), False)
macros["60to70dur40"] := New Macro(Object("5", 38000, "6", 21000), True)
macros["2star"] := New Macro(Object("7", 38600, "8", 40000), True)
macros["justDoIt"] := New Macro(Object("9", 12000), False)

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
; 	Assuming you set all the variables correctly this will DO IT
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
	Log("Crafting: " times " runs with " macroKey " Macro`n")
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

		Sleep 1000
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