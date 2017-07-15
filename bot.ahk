; ------------------------------------------------------------------
; Global Vars
; ------------------------------------------------------------------
^F12::
#MaxThreadsPerHotkey 1

ProcessName := "FFXIVGAME"
WindowTitle := "FINAL FANTASY XIV"
SetTitleMatchMode, 2

; ------------------------------------------------------------------
; Main Class that Defines the skill 
; ------------------------------------------------------------------

class Skill
{
	hotkey := "z"
	delay := 0

	__New(h, d)
	{
		this.hotkey := h
		this.delay := d
	}
}

; ------------------------------------------------------------------
; Definition of Skills
;
;	!	Alt
;	^	Control
; 	+	Shift
;
; ------------------------------------------------------------------
SkillMap := {}
; Bar 1
SkillMap["BasicTouch"] := new Skill("1", 4300)
SkillMap["StandardTouch"] := new Skill("2", 4300)
SkillMap["AdvancedTouch"] := new Skill("3", 4300)
SkillMap["PreciseTouch"] := new Skill("4", 4300)
SkillMap["StandardSynthesis"] := new Skill("5", 4300)
SkillMap["MastersMend2"] := new Skill("6", 4300)
SkillMap["MastersMend"] := new Skill("7", 4300)
SkillMap["InnerQuiet"] := new Skill("8", 4300)
SkillMap["GreatStrides"] := new Skill("9", 4300)
SkillMap["SteadyHand"] := new Skill("0", 4300)
SkillMap["Observe"] := new Skill("-", 4300)
SkillMap["Collectible"] := new Skill("=", 4300)

; bar 2
SkillMap["HastyTouch2"] := new Skill("^1", 4300)
SkillMap["CarefulSynthesis3"] := new Skill("^2", 4300)
SkillMap["RapidSynthesis2"] := new Skill("^3", 4300)
SkillMap["PatientTouch"] := new Skill("^4", 4300)
SkillMap["Manipulation2"] := new Skill("^5", 4300)
SkillMap["PrudentTouch"] := new Skill("^6", 4300)
SkillMap["FocusedSynthesis"] := new Skill("^7", 4300)
SkillMap["FocusedTouch"] := new Skill("^8", 4300)
SkillMap["InitialPreperations"] := new Skill("^9", 4300)

; Bar 3
SkillMap["HastyTouch"] := new Skill("!1", 4300)
SkillMap["ByregotsBlessing"] := new Skill("!2", 4300)
SkillMap["RapidSynthesis"] := new Skill("!3", 4300)
SkillMap["CarefulSynthesis"] := new Skill("!4", 4300)
SkillMap["CarefulSynthesis2"] := new Skill("!5", 4300)
SkillMap["SteadyHand2"] := new Skill("!6", 4300)
SkillMap["InnovativeTouch"] := new Skill("!7", 4300)
SkillMap["Innovation"] := new Skill("!8", 4300)
SkillMap["PieceByPiece"] := new Skill("!9", 4300)
SkillMap["FlawlessSynthesis"] := new Skill("!0", 4300)
SkillMap["MakersMark"] := new Skill("!-", 4300)
SkillMap["MuscleMemory"] := new Skill("!=", 4300)

; Bar 4
SkillMap["Manipulation"] := new Skill("^!1", 4300)
SkillMap["WasteNot"] := new Skill("^!2", 4300)
SkillMap["WasteNot2"] := new Skill("^!3", 4300)
SkillMap["TricksOfTheTrade"] := new Skill("^!4", 4300)
SkillMap["Rumination"] := new Skill("^!5", 4300)
SkillMap["Ingenuity"] := new Skill("^!6", 4300)
SkillMap["Ingenuity2"] := new Skill("^!7", 4300)
SkillMap["ComfortZone"] := new Skill("^!8", 4300)
SkillMap["Reclaim"] := new Skill("^!9", 4300)

; ------------------------------------------------------------------
; Definition of Macros
; ------------------------------------------------------------------
CraftMap := {}
CraftNames := {}
; 1-50
1to50 := ["InnerQuiet", "SteadyHand", "Innovation", "GreatStrides", "AdvancedTouch", "CarefulSynthesis2"]
CraftMap["1to50"] := 1to50
CraftNames["1 to 50"] := "1to50"

60lv70dur := [ "ComfortZone","InnerQuiet", "SteadyHand2", "BasicTouch", "BasicTouch", "BasicTouch", "BasicTouch", "BasicTouch", "SteadyHand2", "BasicTouch", "MastersMend2", "BasicTouch", "GreatStrides", "ByregotsBlessing", "CarefulSynthesis2", "CarefulSynthesis2", "CarefulSynthesis2" ]
CraftMap["60lv70dur"] := 60lv70dur
CraftNames["60 70 Durability"] := "60lv70dur"

60to65dur40 := ["ComfortZone", "InnerQuiet", "SteadyHand2", "WasteNot", "HastyTouch", "HastyTouch", "HastyTouch", "HastyTouch", "Manipulation", "SteadyHand2", "HastyTouch", "HastyTouch", "Manipulation", "HastyTouch", "HastyTouch", "SteadyHand", "GreatStrides", "Innovation", "Ingenuity2", "ByregotsBlessing", "CarefulSynthesis3", "CarefulSynthesis2", "CarefulSynthesis2"]
CraftMap["60to65dur40"] := 60to65dur40
CraftNames["60 to 65 50 Durability"] := "60to65dur40"

60to65dur80 := [ "MuscleMemory","ComfortZone","InnerQuiet","SteadyHand2","WasteNot2","PieceByPiece","HastyTouch","HastyTouch","HastyTouch","SteadyHand2","HastyTouch","HastyTouch","HastyTouch","ComfortZone","HastyTouch","CarefulSynthesis2","MastersMend2","SteadyHand2","HastyTouch","HastyTouch","HastyTouch","SteadyHand","Ingenuity2","GreatStrides","Innovation","ByregotsBlessing","CarefulSynthesis2","CarefulSynthesis2"]
CraftMap["60to65dur80"] := 60to65dur80
CraftNames["60 to 65 80 Durability"] := "60to65dur80"

66to70dur80 := ["MuscleMemory","ComfortZone","InnerQuiet","SteadyHand2","PrudentTouch","PrudentTouch","PrudentTouch","PrudentTouch","PrudentTouch","Manipulation2","SteadyHand2","PrudentTouch","PrudentTouch","PrudentTouch","PrudentTouch","HastyTouch","SteadyHand","Ingenuity2","ByregotsBlessing","CarefulSynthesis3","CarefulSynthesis3","CarefulSynthesis2","CarefulSynthesis2","CarefulSynthesis2"]
CraftMap["66to70dur80"] := 66to70dur80
CraftNames["66 to 70 80 Durability"] := "66to70dur80"

70oneStar := ["MuscleMemory","ComfortZone","InnerQuiet","SteadyHand2","PrudentTouch","PrudentTouch","PrudentTouch","PrudentTouch","PrudentTouch","Manipulation2","SteadyHand2","PrudentTouch","ComfortZone","PrudentTouch","PrudentTouch", "PrudentTouch","SteadyHand", "PieceByPiece", "Innovation", "Ingenuity2","ByregotsBlessing","CarefulSynthesis3","CarefulSynthesis3","CarefulSynthesis3","CarefulSynthesis2"]
CraftMap["70oneStar"] := 70oneStar
CraftNames["70 One Star"] := "70oneStar"

; ------------------------------------------------------------------
; Main
; ------------------------------------------------------------------
if KeepRunning
{
	Stop()
	return
}
KeepRunning := true
Dialog()

return

; ------------------------------------------------------------------
; Gui
; ------------------------------------------------------------------
Dialog()
{
	global

	Gui, Crafting:New,, Crafting

	; Iterations 
	Gui, Crafting:Add, Text, x12 y9 w140 h30 , Iterations
	Gui, Crafting:Add, Edit, x162 y9 w140 h20 vMyIterations, 1
	; Macro Sleection 
	Gui, Crafting:Add, Text, x12 y39 w140 h30, Select Macro
	Gui, Crafting:Add, DropDownList, r10 x162 y39 w140 h10 vMacroName, 1to50|60lv70dur|60to65dur40|60to65dur80|66to70dur80|70oneStar
	; are we doing a collectible 
	Gui, Crafting:Add, CheckBox, x12 y69 w140 h30 vIsCollectible, Is Collectible?
	; Progress Bar
	Gui, Crafting:Add, Progress, x12 y119 w290 h30 vProgress, 0
	; Start and stop things 
	Gui, Crafting:Add, Button, x162 y169 w140 h50 gStart, Start
	Gui, Crafting:Add, Button, x12 y169 w140 h50 gStop, Stop

	Gui, Crafting:Show, x287 y397 h236 w315,
	Return

	ButtonDoOnce:
	Gui, Submit, NoHide
	Run(MacroName, 1, IsCollectible)
	Return

	Start:
	Gui, Submit, NoHide
	Run(MacroName, MyIterations, IsCollectible)
	Return

	Stop:
	Stop()
	Return

	GuiClose:
	ExitApp
}


; ------------------------------------------------------------------
; Updates the progress bar
; ------------------------------------------------------------------
UpdateProgress(number)
{
	GuiControl,, Progress, number
}

; ------------------------------------------------------------------
; Runs a Macro
; ------------------------------------------------------------------
Run(macro, iterations, isCollectible)
{
	global

	WinActivate, %WindowTitle%
	if(iterations < 1)
	{
		MsgBox % "Invalid Iterations"
		return
	}

	KeepRunning := true
	
	Loop %iterations%
	{
		Craft(macro)

		if isCollectible
			EndCollectable()

		progress := A_Index / iterations
		UpdateProgress(progress)

		if not KeepRunning
			break

		Sleep 5000 
	}

	NotifyUser("Done")
	KeepRunning := false
	return
}

; ------------------------------------------------------------------
; executes an entire macro  
; ------------------------------------------------------------------
Craft(name) 
{
	global

	IfWinNotActive, %WindowTitle%
		WinActivate, %WindowTitle%

	StartSynthesis()
	Sleep 1500

	aCraft := CraftMap[name]
	Loop % aCraft.MaxIndex()
		ExecuteAction(aCraft[A_Index])

	return
}

; ------------------------------------------------------------------
; Executes an action  
; ------------------------------------------------------------------
ExecuteAction(name)
{
	global 
	aSkill := SkillMap[name]

	Send(aSkill.hotkey, aSkill.delay)
	return	
}

; ------------------------------------------------------------------
; Uitility to Start a craft 
; ------------------------------------------------------------------
StartSynthesis()
{	
	SendToGame("{Numpad0}", 750)	
	SendToGame("{Numpad0}", 1000)
	
	SendToGame("{Numpad0}", 500)
}

; ------------------------------------------------------------------
; At the end of a craft if collectible need to hit ok 
; ------------------------------------------------------------------
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

Send(KeyToSend, SleepTime)
{
	Send %KeyToSend%
	Sleep %SleepTime%
}

; ------------------------------------------------------------------
; Fuynction to tell teh User something
; ------------------------------------------------------------------
NotifyUser(text) 
{
	MsgBox,, Hey, %text%, 1
}

; ------------------------------------------------------------------
; Stops the current thing
; ------------------------------------------------------------------
Stop()
{
	global KeepRunning
	
	KeepRunning := false
	NotifyUser("Stopping after this loop")
}

st_contains(mixed, lookFor*)
{
   if (IsObject(mixed))
   {
      for key1,input in mixed
         for key,search in lookFor
            if (InStr(input, search))
               Return 1
   }
   Else
   {
      for key,search in lookFor
         if (InStr(mixed, search))
            Return 1
   }
   Return 0
}