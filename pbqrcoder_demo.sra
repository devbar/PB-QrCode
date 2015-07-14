HA$PBExportHeader$pbqrcoder_demo.sra
$PBExportComments$Generated Application Object
forward
global type pbqrcoder_demo from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables

end variables
global type pbqrcoder_demo from application
string appname = "pbqrcoder_demo"
end type
global pbqrcoder_demo pbqrcoder_demo

on pbqrcoder_demo.create
appname="pbqrcoder_demo"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on pbqrcoder_demo.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;open (w_demo)
end event

