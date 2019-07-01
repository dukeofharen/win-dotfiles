; https://stackoverflow.com/questions/16115278/how-do-i-use-autohotkey-to-create-a-new-text-file-by-right-click-new-new-t
SetTitleMatchMode RegEx
MsgBox, 64, NewTextFile, USAGE: Press Ctrl + Shift + T to add a new file.

#IfWinActive ahk_class ExploreWClass|CabinetWClass
    ^+t::
        NewTextFile()
        return
#IfWinActive

NewTextFile()
{
    WinGetText, full_path, A
    StringSplit, word_array, full_path, `n
    Loop, %word_array0%
    {
        IfInString, word_array%A_Index%, Address
        {
            full_path := word_array%A_Index%
            break
        }
    } 
    full_path := RegExReplace(full_path, "^Address: ", "")
    StringReplace, full_path, full_path, `r, , all

    IfInString full_path, \
    {
        InputBox, FileName, Enter new filename my dude
        FileAppend, ,%full_path%\%FileName%
    }
    else
    {
        return
    }
}