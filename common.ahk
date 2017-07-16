thirtyMin := 30 * 60 * 1000

Log(text) {
	FileAppend % text,*
	FileAppend, `n, *
}

Elapsed(StartTime) {
	Return := A_TickCount - StartTime
}

isThirtyMin(StartTime) {
	return thirtyMin < A_TickCount - StartTime
}