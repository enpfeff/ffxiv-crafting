thirtyMin := 30 * 60 * 1000

Log(text) {
	FileAppend % text,*
	FileAppend, `n, *
}