HA$PBExportHeader$w_demo.srw
forward
global type w_demo from window
end type
type st_1 from statictext within w_demo
end type
type sle_blocksize from singlelineedit within w_demo
end type
type cb_1 from commandbutton within w_demo
end type
type sle_text from singlelineedit within w_demo
end type
type dw_1 from datawindow within w_demo
end type
end forward

global type w_demo from window
integer width = 3730
integer height = 1980
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_1 st_1
sle_blocksize sle_blocksize
cb_1 cb_1
sle_text sle_text
dw_1 dw_1
end type
global w_demo w_demo

type variables
private:

n_cst_qrcode_dwsrv	inv_qrcode_dwsrv
end variables

on w_demo.create
this.st_1=create st_1
this.sle_blocksize=create sle_blocksize
this.cb_1=create cb_1
this.sle_text=create sle_text
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.sle_blocksize,&
this.cb_1,&
this.sle_text,&
this.dw_1}
end on

on w_demo.destroy
destroy(this.st_1)
destroy(this.sle_blocksize)
destroy(this.cb_1)
destroy(this.sle_text)
destroy(this.dw_1)
end on

type st_1 from statictext within w_demo
integer x = 2816
integer y = 416
integer width = 293
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Blocksize:"
boolean focusrectangle = false
end type

type sle_blocksize from singlelineedit within w_demo
integer x = 3109
integer y = 384
integer width = 512
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "9"
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_demo
integer x = 2816
integer y = 160
integer width = 805
integer height = 192
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Create Code"
end type

event clicked;dw_1.dataobject = "d_qr_demo"
dw_1.insertRow(0)

try
	inv_qrcode_dwsrv.of_render(sle_text.text, long(sle_blocksize.text))
catch (Throwable exp)
	MessageBox("Error", exp.getMessage())
end try
end event

type sle_text from singlelineedit within w_demo
integer x = 2816
integer y = 32
integer width = 805
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "http://www.devbar.de"
end type

type dw_1 from datawindow within w_demo
integer x = 37
integer y = 32
integer width = 2743
integer height = 1792
integer taborder = 10
string title = "none"
string dataobject = "d_qr_demo"
boolean border = false
boolean livescroll = true
end type

event constructor;//////////////////////////////////////////////////////////////////////////////
// Description: 
// Initialization
// 
// Author: 
// B.Kemner, 13.07.2015 
// 

insertRow(0)

inv_qrcode_dwsrv = create n_cst_qrcode_dwsrv
inv_qrcode_dwsrv.of_setRequestor(this)

return 0
end event

event destructor;//////////////////////////////////////////////////////////////////////////////
// Description: 
// Finalize
// 
// Author: 
// B.Kemner, 13.07.2015 
// 

destroy inv_qrcode_dwsrv

return 0


end event

