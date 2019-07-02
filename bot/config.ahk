; ----------------------------------------------------------
; 	Global Flags
; ----------------------------------------------------------
; Which Macro do you want to use
global macroKey := "turnIn"
; Are you crafting a collectible?
global collectible := True
; How many times do you want to craft it
global times := 6

; ----------------------------------------------------------
; 	Consumable Definitions
; ----------------------------------------------------------
; New Consumable(
; 	what key to press, 
;	how long does it last, 
;	any initial time, 
;	at what time left should i consume more,
;	for logging what do you want to call this
;	)
global food := New Consumable("=", 40 * minute, 4 * minute, 3 * minute, "food")
global tea := New Consumable("-", 15 * minute, 0, 2 * minute, "tea")

; ----------------------------------------------------------
; 	Macro Definitions
; ----------------------------------------------------------
; New Macro(
; 	sequence of buttons and durations [{button: 6, duration: 5000}],
;	an array of consumables that are needed for the craft
;	)
global macros := {}
macros["502star"] := New Macro([{button: 6, duration: 5 * second}], [food])
macros["turnIn"] := New Macro([{button: 1, duration: 34 * second}], [])