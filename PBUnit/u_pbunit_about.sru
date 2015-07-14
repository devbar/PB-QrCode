HA$PBExportHeader$u_pbunit_about.sru
forward
global type u_pbunit_about from userobject
end type
type st_build from statictext within u_pbunit_about
end type
type st_os from statictext within u_pbunit_about
end type
type st_2 from statictext within u_pbunit_about
end type
type st_pbunit from statictext within u_pbunit_about
end type
end forward

global type u_pbunit_about from userobject
integer width = 1554
integer height = 488
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_build st_build
st_os st_os
st_2 st_2
st_pbunit st_pbunit
end type
global u_pbunit_about u_pbunit_about

type prototypes
FUNCTION ulong GetFileVersionInfoSizeW  &
   ( REF string lpFilename, REF ulong lpdwHandle ) &
   LIBRARY "version.dll"

FUNCTION integer GetFileVersionInfoW &
   ( REF string lpFilename, REF ulong lpdwHandle, ulong dwLen, &
     REF string lpData )  &
   LIBRARY "version.dll"

FUNCTION boolean VerQueryValueW &
   ( REF string lpBlock, string lpSubBlock, REF long lpBuffer, &
     REF uint puLen )  &
    LIBRARY "version.dll"

SUBROUTINE CopyMemoryA &
   ( REF string d, long s, long l )  &
   LIBRARY "kernel32.dll"  &
   ALIAS FOR RtlMoveMemory


FUNCTION ulong GetModuleFileName (ulong hinstModule, ref string lpszPath, ulong cchPath )  &
   LIBRARY "KERNEL32.DLL" &
   ALIAS FOR "GetModuleFileNameA;ansi"  // ;ansi  required for PB10 or better


end prototypes

forward prototypes
public function string of_get_version ()
public function string of_get_pb_version ()
end prototypes

public function string of_get_version ();
ulong  dwHandle, dwLength
string ls_Buff, ls_key 
uint   lui_length
long   ll_pointer
string ls_filename  
integer li_rc
string  ls_result = '?'
string ls_EXE_FILE_NAME 
String ls_fullpath 
ulong lul_handle, lul_length = 512

lul_handle = handle( getapplication() )

If lul_handle = 0 Then //IDE MODE
	RETURN '[IDE mode]'
End if

// running from EXE
ls_fullpath=space(lul_length) 
GetModuleFilename( lul_handle, ls_fullpath, lul_length )

//ls_filename = GetCurrentDirectory ( ) + "\" + ls_EXE_FILE_NAME
ls_filename = ls_fullpath

dwLength = GetFileVersionInfoSizeW( ls_filename, dwHandle )
IF dwLength <= 0 THEN
   RETURN ls_result
END IF

ls_Buff = Space( dwLength )

li_rc = GetFileVersionInfoW( ls_filename, dwHandle, dwLength, ls_Buff )

IF li_rc = 0 THEN
    RETURN ls_result
END IF

// the strange numbers below represents the country and language
// of the version ressource.
ls_key = "\StringFileInfo\040904e4\FileVersion"
 
IF NOT VerQueryValueW( ls_buff, ls_key, ll_pointer, lui_length ) OR &
    lui_length <= 0 THEN
    ls_result = "?"
ELSE
    ls_result = Space( lui_length )
    CopyMemoryA( ls_result, ll_pointer, lui_length*2 ) // unicode 
END IF
 

return ls_result

end function

public function string of_get_pb_version ();String ls_name

String ls_version
 
Constant String ls_currver = "8.0.3"
ContextInformation ci

ci = create ContextInformation  
//or 
//GetContextService("ContextInformation", ci)

ci.GetVersionName(ls_version)

return ls_version
end function

on u_pbunit_about.create
this.st_build=create st_build
this.st_os=create st_os
this.st_2=create st_2
this.st_pbunit=create st_pbunit
this.Control[]={this.st_build,&
this.st_os,&
this.st_2,&
this.st_pbunit}
end on

on u_pbunit_about.destroy
destroy(this.st_build)
destroy(this.st_os)
destroy(this.st_2)
destroy(this.st_pbunit)
end on

event constructor;Environment	lnv_Environment
String			ls_OSMajor = " OS Major=";
String			ls_OSMinor = " Minor=";
String			ls_OSFixes = " Fixes=";
String			ls_OSType = " Type=";

getEnvironment ( lnv_Environment )
ls_OSMajor = ls_OSMajor + String ( lnv_Environment . OSMajorRevision );
ls_OSMinor = ls_OSMinor + String ( lnv_Environment . OSMinorRevision );
ls_OSFixes = ls_OSFixes + String ( lnv_Environment . OSFixesRevision );
CHOOSE CASE lnv_Environment . OSType
	CASE	Windows!
		ls_OSType = ls_OSType + "Windows!";
	CASE	WindowsNT!
		ls_OSType = ls_OSType + "WindowsNT!";
	CASE	ELSE
		ls_OSType = ls_OSType + "???";
END CHOOSE
st_os.text = ls_OSMajor + ls_OSMinor + ls_OSFixes + ls_OSType;


st_pbunit.text = 'PBUnit - Powerbuilder ' + of_get_pb_version()

end event

type st_build from statictext within u_pbunit_about
integer x = 37
integer y = 140
integer width = 1495
integer height = 48
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "build"
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;
Constant		String	COMPILE_DATE = String(Today(), 'MMM dd, yyyy hh:mm' )


this.text = "Version " + of_get_version() &
+ " Build on " + COMPILE_DATE


end event

type st_os from statictext within u_pbunit_about
boolean visible = false
integer x = 32
integer y = 424
integer width = 1458
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within u_pbunit_about
integer x = 50
integer y = 204
integer width = 1431
integer height = 216
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Ported to PowerBuilder from Kent Beck and Eric Gamma~'s JUnit 2.1 Unit testing framework by John Urberg and Jaimme York, upgraded GUI interface by Phil Yandel, Frank Mao,                    further development by Aleksander Skj$$HEX1$$e600$$ENDHEX$$veland Larsen"
alignment alignment = center!
long bordercolor = 4194304
boolean focusrectangle = false
end type

event clicked;st_os.Visible = NOT st_os.Visible
end event

type st_pbunit from statictext within u_pbunit_about
integer x = 37
integer y = 28
integer width = 1431
integer height = 96
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "PBUnit"
alignment alignment = center!
long bordercolor = 4194304
boolean focusrectangle = false
end type

event clicked;st_os.Visible = NOT st_os.Visible
end event

