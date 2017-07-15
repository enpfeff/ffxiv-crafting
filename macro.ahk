^F1::
WinGet, programid, List, FINAL FANTASY
#MaxThreadsPerHotkey 1
ProcessName := "FFXIVGAME"

Main()
Return

Main()
{
	Run(20)
}

Run(iterations)
{
	Loop %iterations%
	{
		StartSynthesis()
		SendToGame("{1}", 40000)
		SendToGame("{2}", 32000)
		Sleep 3000
	}
}

StartSynthesis()
{	
	SendToGame("{Numpad0}", 750)	
	SendToGame("{Numpad0}", 1000)
	SendToGame("{Numpad0}", 500)
	Sleep 3000
}
EndCollectable() 
{
	SendToGame("{Numpad0}", 750)	
	SendToGame("{Numpad0}", 1000)
}

SendToGame(KeyToSend, SleepTime)
{
	global ProcessName
	ControlSend,, %KeyToSend%, ahk_class %ProcessName%
	Sleep %SleepTime%
}