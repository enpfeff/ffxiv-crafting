#Include, %A_ScriptDir%\common.ahk
#Include, %A_ScriptDir%\macros.ahk
#MaxThreadsPerHotkey 1
#SingleInstance, Force

; ----------------------------------------------------------
; 	First Class Vars (Change these)
; ----------------------------------------------------------
; Which Macro do you want to use
global macroKey := "502star"
; Are you crafting a collectible?
global collectible := True
; How many times do you want to craft it
global times := 11
; is the craft currently running -- dont touch this
global running := False

return

; ----------------------------------------------------------
; 	Start
; 	Assuming you set all the variables correctly this will DO IT
; ----------------------------------------------------------
^F1::
	WinGet, programid, List, FINAL FANTASY
	; Global Time / State Vars
	running := True
	global startTime := A_TickCount
	global craftTook := 0

	; Main
	Main()
	return

; ----------------------------------------------------------
; 	Stop
; 	Triggering this will stop the craft at the end of the 
;   current iteration
; ----------------------------------------------------------
^F2::
	Stop()
	return

; ----------------------------------------------------------
; 	Interrupt Stop
; 	This will stop the program at this instant
; ----------------------------------------------------------
^Esc::
	Exit()
	return


Main() {
	Log("---- Start ---------------------------------------")
	Log("Crafting " macroKey " macro " times " times")
	Run(times, macros[macroKey])
	Log("---- End -----------------------------------------")
	Log("")
	ExitApp
}

Run(iterations, macro) {
	if(!IsObject(macro)) {
		Log("macro " macroKey " is not a macro")
	}

	Loop %iterations% {
		Log("Starting iteration: " A_Index "/" iterations)
		
		For index, consumable in macro.consumables {
			shouldConsume := consumable.shouldConsume()
			if(shouldConsume) {
				Consume(consumable)
			}
		}

		iterationStartTime := A_TickCount

		StartSynthesis()
		For index, sequence in macro.sequence {
			button := "{" sequence.button "}"
			SendToGame(button, sequence.duration)
		}

		Sleep 1000
		if collectible {
			EndCollectable() 
		}

		iterationTook := A_TickCount - iterationStartTime
		craftTook := craftTook + iterationTook
		Log("Iteration took: " iterationTook / second "s")

		For index, consumable in macro.consumables {
			consumable.subtractTimeLeft(iterationTook)
		}

		Log("Estimated time left: " (iterationTook * (iterations - A_Index)) / minute "m")
		Log("")

		if(!running) {
			Log("Stopping")
			break
		}
	}
	
	Log("Done, craft took: " craftTook / minute "m")

	return
}

Stop() {
	running := False
	Log("Stopping iteration at the end of this craft.")
	return
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

OutOfCrafting() {
	SendToGame("{esc}", 500)
	Sleep 5000
}

IntoCrafting() {
	SendToGame("n", 500)
}

Consume(consumable) {
	OutOfCrafting()
	consumable.consume()
	button := "{" consumable.key "}"
	SendToGame(button, 5 * second)
	IntoCrafting()
}