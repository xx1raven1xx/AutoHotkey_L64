/*
Autohor TAKE Takashi
URL https://github.com/take-takashi
*/

#persistent
/*
論文をコピペして翻訳等にかける時に一部のウザい文字を置きかえる。
ついでに改行も無くす。
ただし、普段のコピペも改行が無くなってしまうので注意。
*/

IsMultiLine := 1
Menu, Tray, Add, IsMultiLine, Label_IsMultiLine
Menu, Tray, Check, IsMultiLine
return

OnClipboardChange:
SetTimer, OnClipboardChangeThread, 0
return

OnClipboardChangeThread:
SetTimer, OnClipboardChangeThread, Off
if(Clipboard != oldClipboard){
	Clipboard := CopyTextReplace(Clipboard, IsMultiLine)
	oldClipboard := Clipboard
}
return

Label_IsMultiLine:
Menu, Tray, ToggleCheck, IsMultiLine
IsMultiLine := !IsMultiLine
return

CopyTextReplace(_text, _isMultiLine){
	_text := RegExReplace(_text, "ﬁ", "fi")
	_text := RegExReplace(_text, "ﬂ", "fl")
	_text := RegExReplace(_text, "ﬀ", "ff")
	_text := RegExReplace(_text, "ﬃ", "ffi")
	_text := RegExReplace(_text, "ﬄ", "ffl")
	_text := RegExReplace(_text, "\-\r\n", "")
	_text := RegExReplace(_text, "\r\n", " ")
	if(_isMultiLine){
		_text := RegExReplace(_text, "\.\s", ".`r`n")
		_text := RegExReplace(_text, "。\s", "。`r`n")
	}
	return _text
	
}