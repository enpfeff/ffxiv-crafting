; ----------------------------------------------------------
; 	Consumable Definitions
; ----------------------------------------------------------
; New Consumable(
; 	what key to press, 
;	how long does it last, 
;	any initial time, 
;	at what point in time should i consume more,
;	for logging what do you want to call this
;	)
food := New Consumable("=", 40 * minute, 4 * minute, 3 * minute, "food")
tea := New Consumable("-", 15 * minute, 0, 2 * minute, "tea")

; ----------------------------------------------------------
; 	Macro Definitions
; ----------------------------------------------------------
global macros := {}
macros["502star"] := New Macro([{button: 6, duration: 5 * second}], [food])