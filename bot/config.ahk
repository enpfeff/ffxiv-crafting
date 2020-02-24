; ----------------------------------------------------------
; 	Global Flags
; ----------------------------------------------------------
; Which Macro do you want to usen
global macroKey := "star3"
; Are you crafting a collectible?
global collectible := False
; How many times do you want to craft it
global times := 12

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
global food := New Consumable("=", 40 * minute, 20 * minute, 3 * minute, "food")
global tea := New Consumable("-", 15 * minute, 14 * minute, 2 * minute, "tea")

; ----------------------------------------------------------
; 	Macro Definitions
; ----------------------------------------------------------
; New Macro(
; 	sequence of buttons and durations [{button: 6, duration: 5000}],
;	an array of consumables that are needed for the craft
;	)
global macros := {}
macros["whiteScrip"] := New Macro([{button: 1, duration: 32 * second}], [])
macros["doIt2star"] := New Macro([{button: 6, duration: 18 * second}], [])
macros["star3"] := New Macro([{button: 4, duration: 38000}, {button: 5, duration: 13000}], [food])

macros["turnIn"] := New Macro([{button: 1, duration: 34 * second}], [])
macros["doIt3"] := New Macro([{button: 3, duration: 11 * second}], [])
macros["doIt2"] := New Macro([{button: 5, duration: 7500}], [])
macros["level80"] := New Macro([{button: 2, duration: 41000}], [])
macros["level7180"] := New Macro([{button: 4, duration: 41000}], [])
macros["level80star1"] := New Macro([{button: 7, duration: 36000}, {button: 8, duration: 17500}], [food, tea])
macros["level80star2special"] := New Macro([{button: 8, duration: 36300}, {button: 9, duration: 34300}], [food])