HA$PBExportHeader$n_pbunit_testresult.sru
$PBExportComments$Extends a test result to work with the user interface
forward
global type n_pbunit_testresult from testresult
end type
end forward

global type n_pbunit_testresult from testresult
end type
global n_pbunit_testresult n_pbunit_testresult

type variables
Private w_pbunit iw_testRunner
end variables

forward prototypes
public subroutine addfailure (Test anv_test, String as_errorMessage)
public subroutine addError (test anv_test, string as_errormessage)
public subroutine initialize (w_pbunit aw_testrunner)
end prototypes

public subroutine addfailure (Test anv_test, String as_errorMessage);super::addFailure(anv_test, as_errorMessage)
iw_testRunner.addFailure(this, anv_test, as_errorMessage)
end subroutine

public subroutine addError (test anv_test, string as_errormessage);super::addError(anv_test, as_errorMessage)
iw_testRunner.addError(this, anv_test, as_errorMessage)
end subroutine

public subroutine initialize (w_pbunit aw_testrunner);iw_testRunner = aw_testRunner
end subroutine

on n_pbunit_testresult.create
call super::create
end on

on n_pbunit_testresult.destroy
call super::destroy
end on

event starttest;call super::starttest;iw_testRunner.startTest(this, anv_test)
end event

event endtest;call super::endtest;iw_testRunner.endTest(this, anv_test)
end event

