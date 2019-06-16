global minute := 60000
global second := 1000
global ProcessName := "FFXIVGAME"

Log(text) {
	FileAppend %text%, %A_ScriptDir%\log.log
	FileAppend `n, %A_ScriptDir%\log.log
}

Exit() {
	Log("---- Interrupt Exit ------------------------------")
	Log("")
	ExitApp
}

SendToGame(KeyToSend, SleepTime) {
	ControlSend,, %KeyToSend%, ahk_class %ProcessName%
	Sleep %SleepTime%
}

class Macro {
	; an object with the key being what button and the value
	; being how long to wait after pressing it
	sequence := []
	consumables := []

	__New(sequence, consumables) {
		this.sequence := sequence
		this.consumables := consumables
	}
}

class Consumable {
	key := ""
	timePerFood := 0
	timeLeft := 0
	threshold := 0
	name := ""

	__New(key, timePerFood, initialTime, threshold, name) {
		this.key := key
		this.timePerFood := timePerFood
		this.timeLeft := initialTime
		this.threshold := threshold
		this.name := name

		if(initialTime) {
			this.timeLeft := initialTime
		}
	}

	shouldConsume() {
		return (Abs(this.timeLeft) < Abs(this.threshold))
	}

	subtractTimeLeft(amount) {
		this.timeLeft := this.timeLeft - amount
		Log(this.name " has " this.timeLeft / minute "m left.")
	}

	consume() {
		this.timeLeft := this.timePerFood
		Log("Consuming " consumable.name)
	}

}