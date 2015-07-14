HA$PBExportHeader$u_pbunit_cb.sru
forward
global type u_pbunit_cb from commandbutton
end type
end forward

global type u_pbunit_cb from commandbutton
integer width = 325
integer height = 92
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "none"
end type
global u_pbunit_cb u_pbunit_cb

event clicked;LONG	ll_Pos
String	ls_Event = "ue_";
String	ls_Name;

ls_Name = THIS.ClassName ();
ll_Pos = POS ( ls_name, "_" );
ls_Event = ls_Event + RIGHT ( ls_Name, LEN ( ls_Name ) - ll_Pos );
//MessageBox("Event call",ls_Event)
Parent . TriggerEvent ( ls_Event );
end event

on u_pbunit_cb.create
end on

on u_pbunit_cb.destroy
end on

