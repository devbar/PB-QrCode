HA$PBExportHeader$n_cst_qrcode_dwsrv.sru
forward
global type n_cst_qrcode_dwsrv from nonvisualobject
end type
end forward

global type n_cst_qrcode_dwsrv from nonvisualobject
end type
global n_cst_qrcode_dwsrv n_cst_qrcode_dwsrv

type variables
private:

n_cst_qrcoder		inv_qrcoder
datawindow			idw_requestor
end variables

forward prototypes
public subroutine of_setrequestor (datawindow adw_requestor)
public function long of_render (string as_text, long al_blocksizeinpixel) throws throwable
end prototypes

public subroutine of_setrequestor (datawindow adw_requestor);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Initialize Requestor
// 
// Author: 
// B.Kemner, 13.07.2015 
//

idw_requestor = adw_requestor
end subroutine

public function long of_render (string as_text, long al_blocksizeinpixel) throws throwable;//////////////////////////////////////////////////////////////////////////////
// Description: 
// Renders the QR Code
// 
// Author: 
// B.Kemner, 13.07.2015 
// 

long					ll_size, ll_x, ll_y
string				ls_modify
n_cst_qrcode		lnv_qrcode
s_bitarray			lstra_modulMatrix[]

lnv_qrcode = inv_qrcoder.of_createQrCode(as_text, n_cst_qrcoder.ECCLEVEL_M)

ll_size = lnv_qrcode.of_getModulMatrix(ref lstra_modulMatrix)

for ll_x = 1 to ll_size
	for ll_y = 1 to ll_size
		if lstra_modulMatrix[ll_y].bits[ll_x] then
			ls_modify += &
				" create rectangle(band=detail"  +  &
				" moveable=0 resizeable=0 x='" + string((ll_x -1) * PixelsToUnits(al_blockSizeInPixel, XPixelsToUnits!)) + "' y='" + string((ll_y -1) * PixelsToUnits(al_blockSizeInPixel, YPixelsToUnits!)) + "' height='" + string(PixelsToUnits(al_blockSizeInPixel, YPixelsToUnits!)) + "' width='" + string(PixelsToUnits(al_blockSizeInPixel, XPixelsToUnits!)) + "' name=r_qr_" + string(ll_x) + "_" + string(ll_y) + &				
				" background.mode='0' background.color='0')"
		end if
	next
next

idw_requestor.setRedraw(false)
idw_requestor.modify(ls_modify)
idw_requestor.setRedraw(true)

return 1


end function

on n_cst_qrcode_dwsrv.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_qrcode_dwsrv.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//////////////////////////////////////////////////////////////////////////////
// Description: 
// Initialization
// 
// Author: 
// B.Kemner, 13.07.2015 
// 

inv_qrcoder = create n_cst_qrcoder

return 0

end event

event destructor;//////////////////////////////////////////////////////////////////////////////
// Description: 
// Finalize
// 
// Author: 
// B.Kemner, 13.07.2015 
// 

destroy inv_qrcoder

return 0


end event

