/*
Autohor TAKE Takashi
URL https://github.com/take-takashi

Change log
2014/07/10 new
*/

#include <ClassSetter>

class AutoBaseListViewClass
{
  __local__ := {hwnd: 0, pid: 0} 
  
  __New()
  {
  }
  
  makeGui()
  {
    Global AUTOBASE_Gui_Edit
    Global AUTOBASE_Gui_ListView
    Global AUTOBASE_Gui_Text
    
    ; TODO Setting
    int_w            := 500
    int_h            := 300
    xdigit_fontColor := "FFFFFF"
    xdigit_bc        := "313131"
    int_scrollWidth  := DllCall("GetSystemMetrics", UInt,3, UInt) ; SM_CXVSCROLL
    int_windowEdgeX  := DllCall("GetSystemMetrics", UInt,45, UInt) ; SM_CXEDGE
    
    Gui, Margin, 0, 0
    Gui, Add, Edit, gAUTOBASE_Gui_Edit_Change vAUTOBASE_Gui_Edit x0 y0 w%int_w% r1
    Gui, Add, ListView, vAUTOBASE_Gui_ListView -Hdr x0 y+0 w%int_w% -Multi c%xdigit_fontColor% Background%xdigit_bc%, display
    Gui, Add, Text, vAUTOBASE_Gui_Text y+1 r2 w%int_w%, % ""
    Gui, +Resize LastFound 0x00CF0000
    LV_ModifyCol(1,int_w-int_scrollWidth-int_windowEdgeX*2) ; サイズに、スクロールバーの幅とウィンドウの枠幅*2を引くことにより横スクロールバーを出さないようにしている。
    ;LV_SetImageList(new IconClass().getMemoryClass().getImageList(), 1) ; TODO ok?
    Gui, Show, XCenter YCenter w%int_w% h%int_h% Hide, AutoBase
    GuiControlGet, int_posEdit, Pos, AUTOBASE_Gui_Edit
    GuiControlGet, int_posText, Pos, AUTOBASE_Gui_Text
    int_height := int_h - int_posEditH - int_posTextH
    int_textY  := int_posEditH + int_height
    GuiControl, Move, AUTOBASE_Gui_ListView, h%int_height%
    GuiControl, Move, AUTOBASE_Gui_Text, y%int_textY%
    Gui, Show
    
    int_hwnd := WinExist()
    WinGet, int_pid, PID, ahk_id %int_hwnd%
    this.__local__.hwnd := int_hwnd
    this.__local__.pid  := int_pid
  }
  
  addList(str_)
  {
    ;LV_Add("Icon" . _ListViewClass.getIcon(), _ListViewClass.getDisplayText())
    LV_Add("", str_)
  }
  
  show()
  {
    Gui, Show
  }
  
  ; getter setter

}

;*** Label ***;
AUTOBASE_Gui_Edit_Change:
  return