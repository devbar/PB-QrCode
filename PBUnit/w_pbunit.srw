HA$PBExportHeader$w_pbunit.srw
$PBExportComments$A simple user interface to run tests.  Enter the name of a Test or TestSuite class that contains the test to be run.
forward
global type w_pbunit from window
end type
type cb_reload_target from u_pbunit_cb within w_pbunit
end type
type tv_testcases from treeview within w_pbunit
end type
type dw_unfiltered_tests from datawindow within w_pbunit
end type
type cb_runall from u_pbunit_cb within w_pbunit
end type
type dw_result from datawindow within w_pbunit
end type
type st_errors from statictext within w_pbunit
end type
type st_6 from statictext within w_pbunit
end type
type cb_show from u_pbunit_cb within w_pbunit
end type
type cb_run from u_pbunit_cb within w_pbunit
end type
type st_status from statictext within w_pbunit
end type
type lb_1 from listbox within w_pbunit
end type
type st_failures from statictext within w_pbunit
end type
type st_4 from statictext within w_pbunit
end type
type st_runs from statictext within w_pbunit
end type
type st_3 from statictext within w_pbunit
end type
type uo_progress from u_pbunit_progressbar within w_pbunit
end type
type gb_3 from groupbox within w_pbunit
end type
type gb_2 from groupbox within w_pbunit
end type
end forward

global type w_pbunit from window
integer x = 1056
integer y = 484
integer width = 3026
integer height = 2276
boolean titlebar = true
string title = "PBUnit"
string menuname = "m_pbunit_main"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 76585128
string icon = "pbunit.ico"
boolean center = true
event ue_run ( )
event ue_show ( )
event ue_quit ( )
event ue_about ( )
event ue_object ( long al_row )
event ue_library ( long al_row )
event type boolean ue_preopen ( )
event ue_postopen ( )
event type boolean ue_target ( )
event ue_runall ( )
event ue_showstatus ( string as_status )
event ue_reload ( )
event ue_populate_data_to_treeview ( )
event ue_set_treeviewitem_to_fail ( integer ai_testcaseid )
event ue_set_treeviewitem_to_success ( integer ai_testcaseid )
event ue_run_testmethod ( )
event ue_reset_to_ready ( )
event ue_reload_target ( )
cb_reload_target cb_reload_target
tv_testcases tv_testcases
dw_unfiltered_tests dw_unfiltered_tests
cb_runall cb_runall
dw_result dw_result
st_errors st_errors
st_6 st_6
cb_show cb_show
cb_run cb_run
st_status st_status
lb_1 lb_1
st_failures st_failures
st_4 st_4
st_runs st_runs
st_3 st_3
uo_progress uo_progress
gb_3 gb_3
gb_2 gb_2
end type
global w_pbunit w_pbunit

type prototypes
Function Long GetSystemDirectoryA (ref string lpBuffer, long nSize)  Library "kernel32" alias for "GetSystemDirectoryA;Ansi"

end prototypes

type variables
Private n_pbunit_TestResult inv_testResult
Private String _iniFile = "pbunit.ini"
Private n_pbunit_WindowResizeService _resize
Private n_pbunit_librarymanager	inv_lm;
Private	Boolean	ib_inprogress = false;

Private:

Long	il_TestID = 0;
Long	il_LibraryRow = 0;
Long	il_ObjectRow = 0;
Long	il_LibraryID = 0;

String	is_CurrentTestClassName = ""
 
String   is_TargetFile = ""


long il_row

constant string KEYWORD_TRUE = "True"
constant string KEYWORD_FALSE = "False"
constant string TEMP_EXPORT_FILE = "pbunit-results.txt"


string REG_RECENT_TARGET 

string is_XML_Reslut_file = "pbunit-results.xml"


// number of asserts
Integer ii_numberOfAsserts = 0

//boolean  ib_commandline = False

boolean  ib_fist_time_load = True 


Long 		il_TVHandle_TestID_Ref[] 
String	il_TVHandle_TestCaseName_Ref[] 
String	il_TVHandle_TestMethodName_Ref[] 

String	is_Current_TestCase_Name

Long		il_Current_Branch_Handle

n_pbunit_objectservice inv_objectservice
integer	ii_index

boolean  ib_RunAllMode
boolean  ib_AllTestPassed = true
end variables

forward prototypes
public subroutine addfailure (testresult anv_result, test anv_test, string as_errormessage)
public subroutine starttest (testresult anv_testresult, test anv_test)
public subroutine endtest (testresult anv_testresult, test anv_test)
private subroutine reset ()
public subroutine adderror (testresult anv_result, test anv_test, string as_errormessage)
public subroutine setupresize ()
private function test gettest (string as_classname)
public function integer of_get_target_from_dialog (ref string as_target)
public function long of_get_target_from_reg (ref string as_target)
public subroutine of_settarget (string as_target)
public subroutine of_add_new_recent_target ()
public subroutine of_save_target_to_reg (string as_target)
public subroutine of_shift_all_recent_targets_down (integer ai_bound)
public function integer of_find_tvhandle_by_testcaseid (integer ai_testcaseid)
end prototypes

event ue_run();String	ls_testClassName
Test 		lnv_test
LONG	ll_row
String	ls_FindTest
LONG	ll_StartCPU, ll_EndCPU;
Decimal	{3} ldc_CPU;
String   ls_testMethodName

if ib_InProgress then
	inv_testResult.stop()
else

//	inv_LM.of_setlibraryid( il_LibraryID );
	inv_LM.of_settestid( il_TestID );
	
	reset()
		
	cb_run.text = "&Stop"

	ib_InProgress = true;

	
// I added of_is_a_valid_test_class in OBjectService. So this one is not needed.
// 	if not inv_lm.isAValidTestClassName(is_CurrentTestClassName) then
//		st_status.text = is_CurrentTestClassName + " name is invalid, should end with 'tests'"
//		goto restore
//	end if
	
	ls_testClassName = is_CurrentTestClassName	//ddlb_test.text
	st_status.text = ls_TestClassName + " Loading test case..."
	
	IF inv_lm.of_SetCurrentTest ( ls_testClassName ) > 0 THEN
		
 		if inv_objectservice.of_get_current_test_method_name( ) = '' then
			// Loop in sub class to get each method name.
			// then re-run ue_run event.
			// to set to result icon properly.
			For ii_index = 1 to inv_lm.of_get_test_method_count_by_object_name(ls_testClassName)
				
				ls_testMethodName = inv_lm.of_get_test_method_name(ls_testClassName, ii_index)
				
				inv_objectservice.of_set_current_test_method_name( ls_testMethodName )
  
//  messagebox('',ls_testMethodName)
				this.event ue_run_testmethod()
	
				
			Next 
			
			inv_objectservice.of_set_current_test_method_name( '' )
			
	
		else 
			
			this.event ue_run_testmethod()		
 
		
		end if
	
	else
		messageBox(title, ls_testClassName + " is not a valid class.")
		st_status.text = ls_TestClassName + " Ready"
	end if
	
	IF IsValid ( inv_testResult ) THEN
		DESTROY inv_testResult;
		setNull(inv_testResult);
	END IF
	
	
	inv_LM.of_terminateTest();
	setNull(lnv_test);
	inv_LM.of_ResetLibraryList ();
	


	// save xml result
	
	
//	dw_result.saveas( is_XML_Reslut_file, xml!, true)
//	dw_result.saveas( TEMP_EXPORT_FILE, text!, false)	
end if

//restore:
	cb_run.text = "&Run"
	ib_InProgress = false;
	
end event

event ue_show();String ls_failure
ls_failure = lb_1.selectedItem()
if len(ls_failure) > 0 then
	messageBox(title, ls_failure)
end if

end event

event ue_quit();close(this)
end event

event ue_about();open(w_PBUnit_About)
end event

event ue_object(long al_row);/*	
	ue_Object
*/
LONG	ll_ID = 0, ll_Row = 0;

dw_unfiltered_tests.SelectRow ( 0, false );
 
IF al_row > 0 THEN
	 
	dw_unfiltered_tests.SelectRow ( al_Row, true );
	cb_Run.Enabled = true;
	ll_Row = al_Row;
	ll_ID = dw_unfiltered_tests.Object.TestID [ al_Row ]
	is_CurrentTestClassName = dw_unfiltered_tests.Object.TestName [ al_Row ]
else
	cb_Run.Enabled = false;
	is_CurrentTestClassName=""
END IF

il_ObjectRow = ll_Row;
il_TestID = ll_ID;

ll_row = dw_unfiltered_tests . RowCount ();



return
end event

event ue_library(long al_row);///*	
//	ue_Library
//*/
//LONG	ll_ID = 0, ll_Row = 0;
//String	ls_Filter;
//
//
//
//
//dw_Libraries.SelectRow ( 0, false );
//IF al_row > 0  THEN
//	dw_Libraries.SelectRow ( al_Row, true );
//	ll_ID = dw_Libraries.Object.LibraryID [ al_Row ];
//	ll_Row = al_Row;
//END IF
//
//il_LibraryRow = ll_Row;
//il_LibraryID = ll_ID;
//inv_LM.of_setlibraryid( il_LibraryID );
//
//ls_Filter = "LibraryID=" + String ( il_LibraryID );
//ll_row = dw_Tests.SetFilter ( ls_Filter )
//ll_row = dw_Tests.Filter ();
//ll_row = dw_Tests.RowCount();
//
//THIS.Event ue_Object ( 0 );
//
//
//
//return
end event

event type boolean ue_preopen();setupresize()

n_pbunit_objectservice lnv_object

REG_RECENT_TARGET = "HKEY_CURRENT_USER\Software\Sybase\PowerUnit\" +lnv_object.of_getPBVersion()+"\Recent-Targets"

return THIS.Event ue_Target();
end event

event ue_postopen();return
end event

event type boolean ue_target();Long	ll_RetCode;
long	ll_row

if Not gb_commandline then
	
	// Try to load recent project from reg.
	// if not exist, then open file dialog.
	// This should only happen in first time load.
	if ib_fist_time_load then
		ib_fist_time_load = False
		
		if of_get_target_from_reg( is_targetFile ) > 0 then

		end if
		
   else
		
//	openWithParm ( w_PBUnit_TargetSelection, inv_LM )
//	ll_RetCode = Message . DoubleParm
//	This.Event ue_Library ( 0 );
//	return (ll_RetCode > 0);

		// targetfile can be set by menu. recent target.
		if is_targetFile = "" then
			
			ll_RetCode = of_get_target_from_dialog( is_targetFile ) 
	
			if ll_RetCode = 0 then
				// User selected cancel btn.
				return false
			end if
			
		end if
		
		if is_targetFile <> "" then
			of_save_target_to_reg(  is_targetFile )
		end if
			
	end if
end if

// reset

			//MessageBox("change dir f", GetCurrentDirectory())
//this.dw_libraries.reset()
//this.dw_tests.reset()

// I only keep one row in LM's target list. 
inv_LM.of_resetTargetList()

if inv_LM.of_settargetdata( is_targetFile ) > 0 then
	// set target data failed, might because folder changed 
	// since last time reg save.
	ll_RetCode = inv_LM.of_setTargetId( 1 )


//		inv_LM.of_setdwshare( dw_libraries, inv_LM.ii_librarydatastore )
//		inv_LM.of_setdwshare( dw_tests, inv_LM.ii_testdatastore);

//MessageBox("zomg",dw_unfiltered_tests.RowCount())

	inv_LM.of_setdwshare( dw_unfiltered_tests, inv_LM.ii_unfilteredtestdatastore);
	//	This.Event ue_Library ( 0 );
	
	
	// Loading target successfully commandline job done. 
	// Why do I need post this event? To wait dw_libraries loading data
	if gb_commandline then
		this.post event ue_runAll()
	else
		
		this.title = is_targetFile + " - PBUnit"

 
		ll_row = inv_LM.of_get_testcase_count()
		if ll_row = 0 then 
			this.event ue_showstatus( "No test case found !" )
		else
			//MessageBox("test cases", string(ll_row))
			this.event ue_showstatus( string(ll_row) + " test cases found." )
		end if
		
		this.event ue_populate_data_to_treeview()
		
		uo_progress.of_reset()
		
		
	End if

	return ( ll_RetCode > 0 )
else
	
	return true
	
end if
 
end event

event ue_runall();
int  i, j
	lb_1.reset()
	dw_result.reset()	
	filedelete( TEMP_EXPORT_FILE )
	filedelete(is_XML_Reslut_file)
	
	cb_runall.enabled = False
	ib_RunAllMode = True
	
	// reset flag
	gl_returncode = 0
 
 
//
//dw_unfiltered_tests.setfilter(' methodname = ""  ')
//dw_unfiltered_tests.filter()

	// this flag will be set to false in ue_run_testmethod() which is called 
	// by ue_run()
	ib_AllTestPassed = true

	for i = 1 to dw_unfiltered_tests.RowCount()
		string ls_testMethodName
		
		ls_testMethodName = dw_unfiltered_tests.getitemstring( i, 'methodname')
		
		if ls_testMethodName <> '' then
	
			inv_objectservice.of_set_current_test_method_name( ls_testMethodName )
		
			dw_unfiltered_tests.setrow( i )
			Event ue_Object ( i )
			Event ue_Run (  )
		end if
		
	Next

 
//dw_unfiltered_tests.setfilter('  ')
//dw_unfiltered_tests.filter()

		if ib_RunAllMode  and  Not ib_AllTestPassed then
			uo_progress.of_setFillColor(RGB(255, 0, 0))
		end if


	cb_runall.enabled = True
	ib_RunAllMode = False
	
		// save xml result
	// Might be a sybase bug, I had to 
	// do a complete import data here,
	// otherwise the group header will only keep the
	// first one?
//	dw_result.saveas( is_XML_Reslut_file, xml!, true)
	integer li_rc

dw_result.GroupCalc()
	dw_result.saveas( TEMP_EXPORT_FILE, text!, false)		
	dw_result.reset()
	li_rc = dw_result.importFile( TEMP_EXPORT_FILE )
	//	messagebox('impprt result', string(li_rc))
	
 
	li_rc = dw_result.saveas( is_XML_Reslut_file, xml!, true)

//	filedelete( TEMP_EXPORT_FILE )
	
	

		
	if gb_commandline then
		gb_commandline = False
	
		close(this)
	end if
Return
end event

event ue_showstatus(string as_status);st_status.text = as_status
end event

event ue_reload();if isvalid(inv_lm) then destroy( inv_lm )

inv_lm = create n_pbunit_LibraryManager
 
This.Event ue_target() 
	
//inv_LM.of_setdwshare( dw_libraries, inv_LM.ii_librarydatastore )
//inv_LM.of_setdwshare( dw_tests, inv_LM.ii_testdatastore);
inv_LM.of_setdwshare( dw_unfiltered_tests, inv_LM.ii_unfilteredtestdatastore);
This.Event ue_Library ( 0 );
 

end event

event ue_populate_data_to_treeview();
long ll_rc, i, ll_root
//string  ls_testcase_object_name
treeviewitem  l_tvi
long ll_empty[]
 

tv_testcases.deleteitem( 0 )
il_TVHandle_TestID_Ref = ll_empty
is_Current_TestCase_Name = ''

string	ls_methodname

//is_targetFile
ll_root = tv_testcases.insertitemfirst( 0,  is_targetFile, 1)
il_TVHandle_TestID_Ref[ll_root] = 0

For i = 1 to dw_unfiltered_tests.Rowcount()
	
	l_tvi.data = dw_unfiltered_tests.getitemnumber( i, 'testId')
	l_tvi.label = dw_unfiltered_tests.getitemstring( i, 'objectname')
	l_tvi.pictureindex = 1
	l_tvi.selectedpictureindex  = 1
	
	ls_methodname = dw_unfiltered_tests.getitemstring( i, 'methodname')
	//ls_testcase_object_name = dw_unfiltered_tests.getitemstring( i, 'objectname')
	
	if is_Current_TestCase_Name <> l_tvi.label Then
		ll_Rc = tv_testcases.insertitemlast( ll_root, l_tvi)
		
		il_Current_Branch_Handle = ll_Rc
		is_Current_TestCase_Name = l_tvi.label
		
//		il_TVHandle_TestID_Ref[ll_Rc] = l_tvi.data
//		il_TVHandle_TestCaseName_Ref[ll_rc] = is_Current_TestCase_Name
//		il_TVHandle_TestMethodName_Ref[ll_rc] = ''		
		
	else
		// Insert method node.	
//		l_tvi.data = dw_unfiltered_tests.getitemnumber( i, 'testId')
		// we want to show method name in sub branch.
		l_tvi.label = ls_methodname
//		l_tvi.pictureindex = 1
//		l_tvi.selectedpictureindex  = 1		
		ll_Rc = tv_testcases.insertitemlast( il_Current_Branch_Handle, l_tvi)
		
	end if
	
	il_TVHandle_TestID_Ref[ll_Rc] = l_tvi.data
	il_TVHandle_TestCaseName_Ref[ll_rc] = is_Current_TestCase_Name
	il_TVHandle_TestMethodName_Ref[ll_rc] = ls_methodname
Next
 
tv_testcases.expandall( 1 )

return
end event

event ue_set_treeviewitem_to_fail(integer ai_testcaseid); 
treeviewitem ltvi_1
long         ll_handle

ll_handle = of_find_tvhandle_by_testcaseId( ai_testcaseId )

if ll_handle > 0 then
	tv_testcases.getitem( ll_handle, ltvi_1)
	
	ltvi_1.pictureindex = 3
	ltvi_1.selectedpictureindex = 3
	
	tv_testcases.setitem( ll_handle, ltvi_1)
	
	
	// All the parent level should also be mark as fail.
	do 
		ll_handle = tv_testcases.finditem( ParentTreeItem!	, ll_handle )
		
		if ll_handle > 0 then
			tv_testcases.getitem( ll_handle, ltvi_1)
	
			ltvi_1.pictureindex = 3
			ltvi_1.selectedpictureindex = 3
			
			tv_testcases.setitem( ll_handle, ltvi_1)
		end if
		
	loop while ll_handle > 0


 	
end if
 



end event

event ue_set_treeviewitem_to_success(integer ai_testcaseid); 
treeviewitem ltvi_1
long         ll_handle
long         ll_handle1

ll_handle = of_find_tvhandle_by_testcaseId( ai_testcaseId )

if ll_handle > 0 then
	tv_testcases.getitem( ll_handle, ltvi_1)
	
	ltvi_1.pictureindex = 2
	ltvi_1.selectedpictureindex = 2
	
	tv_testcases.setitem( ll_handle, ltvi_1)
	
	
	// Loop same level siblings, if they are OK
	// set the parent is OK.
	
	
	// Forward check
	ll_handle1 = ll_handle	
	
	do 
		ll_handle1 = tv_testcases.finditem( NextTreeItem! , ll_handle1 )
		
		if ll_handle1 < 0 then exit
		
		tv_testcases.getitem( ll_handle1, ltvi_1)

		if ltvi_1.pictureindex <> 2 then return
 
 
	loop while ll_handle1 > 0	
	
	// Backward check
	ll_handle1 = ll_handle	
	
	do 
		ll_handle1 = tv_testcases.finditem( PreviousTreeItem! , ll_handle1 )
		
		if ll_handle1 < 0 then exit
		
		tv_testcases.getitem( ll_handle1, ltvi_1)

		if ltvi_1.pictureindex <> 2 then return
 
 
	loop while ll_handle1 > 0		
	
	// All checked, should set parents node to test passed.
	ll_handle = tv_testcases.finditem( ParentTreeItem!	 , ll_handle )
	
 	if ll_handle > 0 then
		tv_testcases.getitem( ll_handle, ltvi_1)

		ltvi_1.pictureindex = 2
		ltvi_1.selectedpictureindex = 2
		
		tv_testcases.setitem( ll_handle, ltvi_1)
	else
		return
	end if
 
 
 // Do the same thing to the parent level.
 
	// Forward check
	ll_handle1 = ll_handle	
	
	do 
		ll_handle1 = tv_testcases.finditem( NextTreeItem! , ll_handle1 )
		
		if ll_handle1 < 0 then exit
		
		tv_testcases.getitem( ll_handle1, ltvi_1)

		if ltvi_1.pictureindex <> 2 then return
 
 
	loop while ll_handle1 > 0	
	
	// Backward check
	ll_handle1 = ll_handle	
	
	do 
		ll_handle1 = tv_testcases.finditem( PreviousTreeItem! , ll_handle1 )
		
		if ll_handle1 < 0 then exit
		
		tv_testcases.getitem( ll_handle1, ltvi_1)

		if ltvi_1.pictureindex <> 2 then return
 
 
	loop while ll_handle1 > 0		
	
	// All checked, should set parents node to test passed.
	ll_handle = tv_testcases.finditem( ParentTreeItem!	 , ll_handle )
	
 	if ll_handle > 0 then
		tv_testcases.getitem( ll_handle, ltvi_1)

		ltvi_1.pictureindex = 2
		ltvi_1.selectedpictureindex = 2
		
		tv_testcases.setitem( ll_handle, ltvi_1)
	else 
		return
		
	end if
	
	
	
end if
 



end event

event ue_run_testmethod();string	ls_testclassname
test		lnv_test
long		ll_startcpu
long		ll_endcpu
decimal{3}  ldc_cpu
				
lnv_test = inv_lm.of_GetCurrentTest();
				
				
st_status.text = ls_TestClassName + " Test Case Loaded..."

inv_testResult = create n_pbunit_TestResult
inv_testResult.initialize(this)
st_status.text = ls_TestClassName + " Test Result Initialized..."

uo_progress.of_setMaximum(lnv_test.countTestCases())

ll_StartCPU = CPU ();
lnv_test.run(inv_testResult)
st_status.text = ls_TestClassName + " Test Run Started..."
this.setPosition(ToTop!)

if inv_testResult.shouldStop() then
//				if false then
	st_status.text = ls_TestClassName + " Stopped"
else
	ll_EndCPU = CPU ();
	ldc_CPU = (ll_EndCPU - ll_StartCPU)/1000.000;
	st_status.text = ls_TestClassName + " Finished: " + string(ldc_CPU) + " seconds."



	if inv_testResult.numberoffailures( ) > 0 or inv_testResult.numberoferrors( ) > 0 then
		this.event ue_set_treeviewitem_to_fail( il_TestID )
		ib_AllTestPassed = false
	else

			this.event ue_set_treeviewitem_to_success( il_TestID )
 
	end if

	
	
end if
end event

event ue_reset_to_ready();	
	
	cb_run.text = "&Run"
	ib_InProgress = false;
	
	cb_runall.enabled = True
	ib_RunAllMode = False
end event

event ue_reload_target();//if isvalid(inv_lm) then destroy( inv_lm )

//inv_lm = create n_pbunit_LibraryManager

//this.of_settarget( "" )

String currentTarget 
currentTarget = this.is_TargetFile

//MessageBox("Called reload target", currentTarget)

//destroy inv_lm
inv_lm.self_destruct()
destroy inv_lm
inv_lm = create n_pbunit_LibraryManager

//inv_lm.StartPBUnit ("");

this.of_settarget( currentTarget )
This.Event ue_target() 
	
//inv_LM.of_setdwshare( dw_libraries, inv_LM.ii_librarydatastore )
//inv_LM.of_setdwshare( dw_tests, inv_LM.ii_testdatastore);
//inv_LM.of_setdwshare( dw_unfiltered_tests, inv_LM.ii_unfilteredtestdatastore);

 

end event

public subroutine addfailure (testresult anv_result, test anv_test, string as_errormessage);String	ls_error

st_failures.text = string(inv_testResult.numberOfFailures())
ls_error = "Failure: " + anv_test.toString() + " : " + as_errorMessage
lb_1.addItem(ls_error)


dw_result.setitem( il_row, "failure_message", as_errorMessage )

// For app's return code
gl_returncode = 1
end subroutine

public subroutine starttest (testresult anv_testresult, test anv_test);st_status.text = "Running: " + anv_test.toString() 



il_row = dw_result.insertrow( 0 )
 
dw_result.setItem(il_row, 'target_name', is_TargetFile)
end subroutine

public subroutine endtest (testresult anv_testresult, test anv_test);st_runs.text = string(inv_testResult.numberOfTestsRun())
if not inv_testResult.wasSuccessful() then
	uo_progress.of_setFillColor(RGB(255, 0, 0))
end if
uo_progress.of_increment()

string ls_success
if inv_testResult.wasSuccessful() then 
	ls_success = KEYWORD_TRUE
else
	ls_success = KEYWORD_FALSE
end if


// This block of code could be done by testresult object.
// As a testRunner, window can just call that object to get
// xml result back.
// The challenge is, how to keep the xml result between each 
// testresult. Where to create this datastore? 
dw_result.setitem( il_row, "suite_name", is_CurrentTestClassName )
dw_result.setitem( il_row, 'case_name', anv_test.toString() )
dw_result.setitem( il_row, "case_time", inv_testResult.NumberOfSeconds ( )  )
dw_result.setitem( il_row, "executed", KEYWORD_TRUE )
dw_result.setitem( il_row, "success",  ls_success  )
dw_result.setitem( il_row, "asserts", inv_testResult.numberofasserts( )  )

 
end subroutine

private subroutine reset ();cb_show.enabled = false
cb_run.text = "&Stop"
//cb_find.enabled = false

uo_progress.of_reset()
uo_progress.of_setFillColor(RGB(0, 255, 0))
st_runs.text = "0"
st_failures.text = "0"
st_errors.text = "0"

ib_InProgress = false;

// reset dw only if it's not in run all mode. because each test should clear 
// if cb_runall.Enabled then
if	Not ib_RunAllMode then
	dw_result.reset()
	lb_1.reset()
end if
end subroutine

public subroutine adderror (testresult anv_result, test anv_test, string as_errormessage);String	ls_error

st_errors.text = string(inv_testResult.numberOfErrors())
ls_error = "Error: " + anv_test.toString() + " : " + as_errorMessage
lb_1.addItem(ls_error)

end subroutine

public subroutine setupresize ();_resize = create n_pbunit_WindowResizeService
_resize.of_setOrigSize(workspaceWidth(), workspaceHeight())
_resize.of_setMinSize(workspaceWidth(), workspaceHeight())

//_resize.of_setOrigSize(1, 1)
//_resize.of_setMinSize(1 , 1)


//_resize.of_register(cb_run, _resize. )
//_resize.of_register(cb_runall, _resize.FIXEDRIGHT)
 

_resize.of_register(gb_3, _resize.SCALERIGHT)
_resize.of_register(uo_progress, _resize.SCALERIGHT)

_resize.of_register(gb_2, _resize.SCALERIGHTBOTTOM)
_resize.of_register(lb_1, _resize.SCALERIGHT)
_resize.of_register(cb_show, _resize.FIXEDRIGHT)
_resize.of_register(cb_reload_target, _resize.FIXEDRIGHT)
_resize.of_register(dw_result, _resize.SCALERIGHTBOTTOM )

  

_resize.of_register(tv_testcases, _resize.SCALEBOTTOM )
_resize.of_register(st_status, _resize.SCALE )



end subroutine

private function test gettest (string as_classname);Test	lnv_test

lnv_test = create using as_className
return lnv_test.suite()
end function

public function integer of_get_target_from_dialog (ref string as_target);/*

return code: 0 - user selected cancel.
             1 - A target file has been selected.
*/
long  ll_retcode

// Pop-up openfile dialog
string ls_filename_withpath, 	ls_filename
ll_RetCode = GetFileOpenName ( "Select PB Target File", &
	ls_filename_withpath, ls_filename, "PBT", "pbt Files (*.pbt), *.pbt"    )

if  ll_RetCode = 1 then
	as_target = ls_filename_withpath
end if

return ll_RetCode
end function

public function long of_get_target_from_reg (ref string as_target);/*
	-1 - read reg failure
	0 - no record in reg
	1 - success
*/
string 	ls_target
long		ll_rc

m_pbunit_main  lm_menu
lm_menu = this.menuID
lm_menu.m_file.m_recenttargets.m_recenttarget1.text = ""
lm_menu.m_file.m_recenttargets.m_recenttarget2.text = ""
lm_menu.m_file.m_recenttargets.m_recenttarget3.text = ""
lm_menu.m_file.m_recenttargets.m_recenttarget4.text = ""
lm_menu.m_file.m_recenttargets.m_recenttarget5.text = ""

 
ll_rc = RegistryGet( REG_RECENT_TARGET , "File1", RegString!, ls_target)

if ll_rc > 0 then
	if trim(ls_target) = "" then
		ll_rc = 0
	else
		as_target = ls_target
		
		// add into menu
 		lm_menu.m_file.m_recenttargets.m_recenttarget1.text = ls_target
		
	end if
end if


 
// try to get other recent target, those actions won't effect return code
// because we already got one.
if RegistryGet( REG_RECENT_TARGET , "File2", RegString!, ls_target) > 0 then
	if trim(ls_target) <> "" then
		// add into menu
 		lm_menu.m_file.m_recenttargets.m_recenttarget2.text = ls_target
	end if
end if

if RegistryGet( REG_RECENT_TARGET , "File3", RegString!, ls_target) > 0 then
	if trim(ls_target) <> "" then
		// add into menu
 		lm_menu.m_file.m_recenttargets.m_recenttarget3.text = ls_target
	end if
end if

if RegistryGet( REG_RECENT_TARGET , "File4", RegString!, ls_target) > 0 then
	if trim(ls_target) <> "" then
		// add into menu
 		lm_menu.m_file.m_recenttargets.m_recenttarget4.text = ls_target
	end if
end if


if RegistryGet( REG_RECENT_TARGET , "File5", RegString!, ls_target) > 0 then
	if trim(ls_target) <> "" then
		// add into menu
 		lm_menu.m_file.m_recenttargets.m_recenttarget5.text = ls_target
	end if
end if

return ll_rc
end function

public subroutine of_settarget (string as_target);is_TargetFile = as_target
end subroutine

public subroutine of_add_new_recent_target ();
// shift over old items, 4->5, 3->4, 2->3,1-2

// add new target to item 1
end subroutine

public subroutine of_save_target_to_reg (string as_target);
//RegistrySet( &
// REG_RECENT_TARGET, &
// "File1", RegString!, as_target)
//
//return
//


// shift over old items, 4->5, 3->4, 2->3,1-2 ,
// check if there are same before moving
string ls_target1
string ls_target2
string ls_target3
string ls_target4
string ls_target5

m_pbunit_main lm_menu

lm_menu = this.MenuID

RegistryGet( REG_RECENT_TARGET , "File5", RegString!, ls_target5)
RegistryGet( REG_RECENT_TARGET , "File4", RegString!, ls_target4)
RegistryGet( REG_RECENT_TARGET , "File3", RegString!, ls_target3)
RegistryGet( REG_RECENT_TARGET , "File2", RegString!, ls_target2)
RegistryGet( REG_RECENT_TARGET , "File1", RegString!, ls_target1)

if as_target = ls_target1 then return

if as_target = ls_target2 then 
	of_shift_all_recent_targets_down(1)
elseif as_target = ls_target3 then 
	of_shift_all_recent_targets_down(2)
elseif as_target = ls_target4 then 
	of_shift_all_recent_targets_down(3)
elseif as_target = ls_target5 then 
	of_shift_all_recent_targets_down(4)
else
	of_shift_all_recent_targets_down(5)
end if


RegistrySet( REG_RECENT_TARGET, "File1", RegString!, as_target)
// update menu
lm_menu.m_file.m_recenttargets.m_recenttarget1.text = as_target
 



// add new target to item 1
end subroutine

public subroutine of_shift_all_recent_targets_down (integer ai_bound);string ls_target1
string ls_target2
string ls_target3
string ls_target4
string ls_target5

m_pbunit_main lm_menu

lm_menu = this.MenuID

RegistryGet( REG_RECENT_TARGET , "File5", RegString!, ls_target5)
RegistryGet( REG_RECENT_TARGET , "File4", RegString!, ls_target4)
RegistryGet( REG_RECENT_TARGET , "File3", RegString!, ls_target3)
RegistryGet( REG_RECENT_TARGET , "File2", RegString!, ls_target2)
RegistryGet( REG_RECENT_TARGET , "File1", RegString!, ls_target1)

if aI_bound = 4 then  // (included bound)

	if ls_target4 <> ls_target5 then
		RegistrySet( REG_RECENT_TARGET, "File5", RegString!, ls_target4)
		// update menu
		lm_menu.m_file.m_recenttargets.m_recenttarget5.text = ls_target4
	 
	end if
end if

if aI_bound >= 3 then
	
	if ls_target3 <> ls_target4 then
		RegistrySet( REG_RECENT_TARGET, "File4", RegString!, ls_target3)
		// update menu
		lm_menu.m_file.m_recenttargets.m_recenttarget4.text = ls_target3
	 
	end if
end if

if aI_bound >= 2 then
	if ls_target2 <> ls_target3 then
		RegistrySet( REG_RECENT_TARGET, "File3", RegString!, ls_target2)
		// update menu
		lm_menu.m_file.m_recenttargets.m_recenttarget3.text = ls_target2
	 
	end if
end if

if aI_bound >= 1 then
	if ls_target1 <> ls_target2 then
		RegistrySet( REG_RECENT_TARGET, "File2", RegString!, ls_target1)
		// update menu
		lm_menu.m_file.m_recenttargets.m_recenttarget2.text = ls_target1
	 
	end if
end if

end subroutine

public function integer of_find_tvhandle_by_testcaseid (integer ai_testcaseid);// find tvhandle by testId
int i, j
for i = 1 to UpperBound(il_TVHandle_TestID_Ref)  
	if	il_TVHandle_TestID_Ref[i] = ai_testcaseId then
		for j = i  to UpperBound(il_TVHandle_TestMethodName_Ref)   
			if	il_TVHandle_TestMethodName_Ref[j] = inv_objectservice.of_get_current_test_method_name( ) then
				return j
			end if
		next
		

	end if
next

return 0
end function

on w_pbunit.create
if this.MenuName = "m_pbunit_main" then this.MenuID = create m_pbunit_main
this.cb_reload_target=create cb_reload_target
this.tv_testcases=create tv_testcases
this.dw_unfiltered_tests=create dw_unfiltered_tests
this.cb_runall=create cb_runall
this.dw_result=create dw_result
this.st_errors=create st_errors
this.st_6=create st_6
this.cb_show=create cb_show
this.cb_run=create cb_run
this.st_status=create st_status
this.lb_1=create lb_1
this.st_failures=create st_failures
this.st_4=create st_4
this.st_runs=create st_runs
this.st_3=create st_3
this.uo_progress=create uo_progress
this.gb_3=create gb_3
this.gb_2=create gb_2
this.Control[]={this.cb_reload_target,&
this.tv_testcases,&
this.dw_unfiltered_tests,&
this.cb_runall,&
this.dw_result,&
this.st_errors,&
this.st_6,&
this.cb_show,&
this.cb_run,&
this.st_status,&
this.lb_1,&
this.st_failures,&
this.st_4,&
this.st_runs,&
this.st_3,&
this.uo_progress,&
this.gb_3,&
this.gb_2}
end on

on w_pbunit.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_reload_target)
destroy(this.tv_testcases)
destroy(this.dw_unfiltered_tests)
destroy(this.cb_runall)
destroy(this.dw_result)
destroy(this.st_errors)
destroy(this.st_6)
destroy(this.cb_show)
destroy(this.cb_run)
destroy(this.st_status)
destroy(this.lb_1)
destroy(this.st_failures)
destroy(this.st_4)
destroy(this.st_runs)
destroy(this.st_3)
destroy(this.uo_progress)
destroy(this.gb_3)
destroy(this.gb_2)
end on

event open;Integer			i
String			lastTest
 
inv_lm = create n_pbunit_LibraryManager

//MessageBox("stringparm",Message.stringparm);

if len(Message.stringparm) > 0 then
	is_targetFile = Message.stringparm
	//MessageBox("inside if", is_targetFile)
	gb_commandline = True
end if

IF THIS.Event ue_PreOpen () THEN
	
//	inv_LM.of_setdwshare( dw_libraries, inv_LM.ii_librarydatastore )
//	inv_LM.of_setdwshare( dw_tests, inv_LM.ii_testdatastore);
//	inv_LM.of_setdwshare( dw_unfiltered_tests, inv_LM.ii_unfilteredtestdatastore);
//	This.Event ue_Library ( 0 );
	
ELSE
	Close (THIS);
END IF


end event

event close;
DESTROY	inv_lm;

end event

event closequery;if trim(is_TargetFile) <> "" then
	of_save_target_to_reg( is_TargetFile )
end if
end event

event resize;If IsValid (_resize) and This.windowstate <> minimized! Then
	_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
End If

end event

type cb_reload_target from u_pbunit_cb within w_pbunit
boolean visible = false
integer x = 2190
integer y = 920
integer width = 366
integer height = 96
integer taborder = 60
string text = "R&eload target"
end type

event clicked;call super::clicked;//parent.event ue_show()
end event

type tv_testcases from treeview within w_pbunit
integer x = 27
integer y = 24
integer width = 1431
integer height = 1948
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
string picturename[] = {"question.png","passed.png","failed.png"}
long picturemaskcolor = 12632256
long statepicturemaskcolor = 536870912
end type

event selectionchanged;/*	
	ue_Object
*/
LONG	ll_ID = 0, ll_Row = 0;

treeviewitem ltvi_1


 
IF newhandle  > 1   THEN
	 
 	cb_Run.Enabled = true;
 	this.getitem( newhandle, ltvi_1)
	ll_ID = ltvi_1.data
	 
	is_CurrentTestClassName = il_TVHandle_TestCaseName_Ref [ newhandle ]
	inv_objectservice.of_set_current_test_method_name( il_TVHandle_TestMethodName_Ref [ newhandle ] )
else
	cb_Run.Enabled = false;
	is_CurrentTestClassName = ""
	inv_objectservice.of_set_current_test_method_name( "" )
END IF

//il_ObjectRow = ll_Row;
il_TestID = ll_ID;

 

end event

type dw_unfiltered_tests from datawindow within w_pbunit
boolean visible = false
integer x = 110
integer y = 60
integer width = 270
integer height = 200
integer taborder = 40
string title = "none"
string dataobject = "d_pbunit_testlist"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_runall from u_pbunit_cb within w_pbunit
integer x = 1947
integer y = 72
integer width = 352
integer height = 96
integer taborder = 30
string text = "R&un All"
boolean default = true
end type

type dw_result from datawindow within w_pbunit
integer x = 1509
integer y = 1056
integer width = 1435
integer height = 876
integer taborder = 60
string title = "none"
string dataobject = "d_pbunit_testresult"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_errors from statictext within w_pbunit
integer x = 2683
integer y = 300
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "0"
long bordercolor = 4194304
boolean focusrectangle = false
end type

type st_6 from statictext within w_pbunit
integer x = 2446
integer y = 300
integer width = 242
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Errors:"
long bordercolor = 4194304
boolean focusrectangle = false
end type

type cb_show from u_pbunit_cb within w_pbunit
integer x = 2592
integer y = 920
integer width = 352
integer height = 96
integer taborder = 50
boolean enabled = false
string text = "S&how"
end type

event clicked;call super::clicked;//parent.event ue_show()
end event

type cb_run from u_pbunit_cb within w_pbunit
integer x = 1545
integer y = 72
integer width = 352
integer height = 96
integer taborder = 20
boolean enabled = false
string text = "&Run"
boolean default = true
end type

event clicked;call super::clicked;//parent.event ue_run()
end event

type st_status from statictext within w_pbunit
integer x = 23
integer y = 2004
integer width = 2944
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Ready"
boolean border = true
long bordercolor = 4194304
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type lb_1 from listbox within w_pbunit
integer x = 1509
integer y = 480
integer width = 1435
integer height = 400
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if selectedIndex() > 0 then
	cb_show.enabled = true
else
	cb_show.enabled = false
end if
end event

event doubleclicked;if selectedIndex() > 0 then
	parent.event ue_show()
end if
end event

type st_failures from statictext within w_pbunit
integer x = 2185
integer y = 300
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "0"
long bordercolor = 4194304
boolean focusrectangle = false
end type

type st_4 from statictext within w_pbunit
integer x = 1975
integer y = 300
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Failures:"
long bordercolor = 4194304
boolean focusrectangle = false
end type

type st_runs from statictext within w_pbunit
integer x = 1801
integer y = 300
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "0"
long bordercolor = 4194304
boolean focusrectangle = false
end type

type st_3 from statictext within w_pbunit
integer x = 1550
integer y = 300
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Runs:"
long bordercolor = 4194304
boolean focusrectangle = false
end type

type uo_progress from u_pbunit_progressbar within w_pbunit
integer x = 1541
integer y = 184
integer width = 1390
integer height = 92
boolean border = true
long backcolor = 76585128
borderstyle borderstyle = stylelowered!
end type

on uo_progress.destroy
call u_pbunit_progressbar::destroy
end on

event constructor;call super::constructor;of_setFillStyle(LEFTRIGHT)
of_setDisplayStyle(PCTCOMPLETE)
of_setFillColor(RGB(0, 255, 0))
of_setAutoReset(false)
of_setStep(1)
end event

type gb_3 from groupbox within w_pbunit
integer x = 1490
integer y = 16
integer width = 1481
integer height = 376
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_pbunit
integer x = 1486
integer y = 416
integer width = 1486
integer height = 1552
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Failures"
end type

