#Include, %A_ScriptDir%\common.ahk
#Include, %A_ScriptDir%\config.ahk
#MaxThreadsPerHotkey 1
#SingleInstance, Force

global running := False
global moveEvery30IsActive := False
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

^F3::
	moveEvery30IsActive := True
	MoveEvery30()
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

MoveEvery30() {
	if(!moveEvery30IsActive) {
		Exit()
	}
	Log("Moving")
	SendToGame("n", 100)
	Sleep 20000
	MoveEvery30()
}