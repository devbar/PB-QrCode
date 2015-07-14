HA$PBExportHeader$w_pbunit_about.srw
$PBExportComments$A cheesy about box
forward
global type w_pbunit_about from window
end type
type uo_1 from u_pbunit_about within w_pbunit_about
end type
type cb_ok from commandbutton within w_pbunit_about
end type
end forward

global type w_pbunit_about from window
integer x = 1056
integer y = 484
integer width = 1605
integer height = 680
boolean titlebar = true
string title = "About"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 76585128
uo_1 uo_1
cb_ok cb_ok
end type
global w_pbunit_about w_pbunit_about

on w_pbunit_about.create
this.uo_1=create uo_1
this.cb_ok=create cb_ok
this.Control[]={this.uo_1,&
this.cb_ok}
end on

on w_pbunit_about.destroy
destroy(this.uo_1)
destroy(this.cb_ok)
end on

type uo_1 from u_pbunit_about within w_pbunit_about
integer width = 1536
integer height = 448
integer taborder = 10
end type

on uo_1.destroy
call u_pbunit_about::destroy
end on

type cb_ok from commandbutton within w_pbunit_about
integer x = 626
integer y = 472
integer width = 329
integer height = 96
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
boolean default = true
end type

event clicked;close(parent)
end event

