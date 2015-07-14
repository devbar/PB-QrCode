HA$PBExportHeader$pbunit.sra
forward
global type pbunit from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
long 		gl_returncode
boolean 	gb_commandline = false

end variables
global type pbunit from application
string appname = "pbunit"
end type
global pbunit pbunit

on pbunit.create
appname="pbunit"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on pbunit.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event systemerror;f_catchSystemError()

w_pbunit.event ue_reset_to_ready()

// close the application if it's in commandline mode.
if gb_commandline then
	gl_returncode = 1
	Halt Close 
end if
end event

event open;n_pbunit_LibraryManager lm 
lm = create n_pbunit_LibraryManager;

lm.StartPBUnit(Trim(commandline))

//lm.StartPBUnit ("C:\kode\powerbuilder\test2\test2.pbt");
//lm.StartPBUnit ("C:\workspaces\pbunit\pb9\Demo\myDemoapp.pbt");

end event

event close;Message.LongParm = gl_returncode
end event

