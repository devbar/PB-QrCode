HA$PBExportHeader$n_pbunit_librarymanager.sru
$PBExportComments$Powerbuilder library functions
forward
global type n_pbunit_librarymanager from nonvisualobject
end type
end forward

shared variables
Boolean _InPowerbuilder = true
Boolean	sb_Initialized = false;

String	_s_RegistryPath;
Environment	_env_Environment;

String _CurrentLibraryList, _InitialLibraryList

LONG	_l_CurrentTargetID = 0;
LONG	_l_CurrentLibraryID = 0;
LONG	_l_CurrentTestID = 0;

LONG	_l_TestRow = 0;
LONG	_l_LibraryRow = 0;
LONG	_l_TargetRow = 0;
LONG	_l_FullTestRow = 0;

DataStore	_ds_Targets, _ds_PBLs, _ds_Tests, _ds_Tests_unfiltered;

end variables

global type n_pbunit_librarymanager from nonvisualobject
end type
global n_pbunit_librarymanager n_pbunit_librarymanager

type variables
Private:

CONSTANT	String	is_TargetDWO = 'd_pbunit_TargetList';
CONSTANT	String	is_PBLDWO = 'd_pbunit_LibraryList';
CONSTANT	String	is_TestDWO = 'd_pbunit_TestList';
CONSTANT	String	is_Dollar = "$";
CONSTANT	String	is_Comma = ",";
CONSTANT	String	is_SemiColon = ";";
CONSTANT	String	is_BackSlash = "\";
CONSTANT	String	is_RegistryPathBase = "HKEY_CURRENT_USER\Software\Sybase\PowerBuilder\";
CONSTANT	String	is_TargetPath = "Target"

Boolean	ib_firstcalltosettestdata = true;
DataStore	ids_data;
String	is_CurrentTestObject = "";
String	is_Libraries[]
Test	inv_Test;


string is_libraries_with_path[]

String	is_CurrentTestMethod = "";

Public:

CONSTANT	Integer	ii_TargetDataStore = 1;
CONSTANT	Integer	ii_LibraryDataStore = 2;
CONSTANT	Integer	ii_TestDataStore = 3;
CONSTANT	Integer	ii_UnFilteredTestDataStore = 4;

n_pbunit_objectservice inv_objectservice

 
end variables

forward prototypes
public function integer parselibrarylist (string alibrarylist, ref string alibrarylistarray[])
public function boolean ispbunitlibrary (string alibrary)
public function boolean inpowerbuilder ()
protected subroutine setcurrentlibrarylist (string alibrarylist)
public subroutine updatelibrarylist (string as_newlibraries)
private subroutine inpowerbuilder (boolean aswitch)
protected function string of_replace (string as_string, string as_from, string as_to, boolean ab_all)
protected function string of_replaceall (string as_string, string as_from, string as_to)
protected function long of_separate (string as_fullname, ref string as_path, ref string as_file)
protected function long of_gettargetdata (string as_targetfile, ref string as_appname, ref string as_applib, ref string as_liblist)
protected function long of_parse (string as_line, ref string as_data[], string as_delimiter, boolean ab_skippbunitlibraries)
protected function long of_parse (string as_line, ref string as_array[], string as_delimiter)
protected function string of_extract (string as_quotedstring)
public function long of_setdwshare (datawindow adw, integer ai_type)
public function long of_settargetid (long al_targetid)
public function long of_setlibraryid (long al_libraryid)
public function long of_settestid (long al_testid)
public function string of_getselectedtest ()
protected function long of_setlibrarydata (long al_targetid, string as_path, string as_liblist, string as_appname)
public function long of_setcurrenttest (string as_testtext)
public function long of_resetlibrarylist ()
public function test of_getcurrenttest ()
public function long of_setlibrarylist (string as_addlist, string as_path)
protected subroutine of_filterlibraries (long al_targetid, long al_libraryid, long al_testid)
protected subroutine of_filtertargets (long al_targetid, long al_libraryid, long al_testid)
protected subroutine of_filtertests (long al_targetid, long al_libraryid, long al_testid)
public function long of_gettargetid ()
public function long of_getlibraryid ()
public function long of_gettestid ()
public function long of_findtest (string as_testtext)
private subroutine of_setlibrarylist ()
public function datastore of_gettargetlist ()
protected function long of_settestdata (long al_targetid, long al_libraryid, string as_appname, string as_path, string as_library)
private function boolean of_testlibrary (string as_path, string as_library[], long al_index)
public subroutine of_terminatetest ()
public subroutine of_reset ()
public function long of_settargetdata (string as_targetfile)
public subroutine startpbunit (string as_commandline)
public subroutine of_resettargetlist ()
public function boolean isavalidtestclassname (string as_testobjectname)
public function integer of_get_testcase_count ()
public function string of_get_registrypathbase ()
public subroutine of_restorelibrarylist (string as_librarylist[], string as_path, ref string as_librarylist_with_path[])
public subroutine of_set_current_test_method (string as_methodname)
public function integer of_get_test_method_count_by_object_name (string as_objectname)
public function string of_get_test_method_name (string as_objectname, integer ai_index)
public subroutine self_destruct ()
end prototypes

public function integer parselibrarylist (string alibrarylist, ref string alibrarylistarray[]);String	pbLibrary
Integer	startPos, endPos
String	libraryList[]
Integer	i

startPos = 1
endPos = pos(aLibraryList, ";", startPos) 
do while endPos > 0
	pbLibrary = mid(aLibraryList, startPos, endPos - startPos)
	if isPbUnitLibrary(pbLibrary) then
	else
		i++
		libraryList[i] = pbLibrary
	end if
	startPos = endPos + 1
	endPos = pos(aLibraryList, ";", startPos) 
loop

aLibraryListArray = libraryList
return i
end function

public function boolean ispbunitlibrary (string alibrary);String	ls_Lib
LONG	ll_POS;
boolean	lb_rc;

ls_lib = LOWER ( aLibrary );
ll_POS = LastPOS ( ls_lib, is_BackSlash );
ls_lib = RIGHT ( ls_Lib, LEN ( ls_Lib ) - ll_POS );

lb_rc = ( POS ( ls_Lib, "pbunit" ) > 0 AND POS ( ls_Lib, "pbunittest" ) = 0 );

lb_rc = false;
IF ( POS ( ls_Lib, "pbunit" ) > 0 ) THEN
	IF POS ( ls_Lib, "pbunittest" ) = 0  THEN
		lb_rc = true;
	END IF;
END IF;

return	lb_rc;
return ( POS ( ls_Lib, "pbunit" ) > 0 AND POS ( ls_Lib, "pbunittest" ) = 0 );
return ( NOT ( pos(ls_Lib, "pbunittest") > 0 ) OR ( pos(ls_Lib, "pbunit") > 0 ) );
end function

public function boolean inpowerbuilder ();return _InPowerBuilder
end function

protected subroutine setcurrentlibrarylist (string alibrarylist);
_CurrentLibraryList = aLibraryList
end subroutine

public subroutine updatelibrarylist (string as_newlibraries);
_CurrentLibraryList = _CurrentLibraryList + as_NewLibraries;


end subroutine

private subroutine inpowerbuilder (boolean aswitch);_InPowerBuilder = aSwitch
end subroutine

protected function string of_replace (string as_string, string as_from, string as_to, boolean ab_all);/*
	of_Replace
*/
LONG	ll_Pos;

ll_pos = POS ( as_String, as_From );
IF ll_pos > 0 THEN
	as_String = LEFT ( as_String, ll_pos - 1 ) + as_To + Right ( as_String, LEN ( as_String ) - ll_POS );
	IF ab_all THEN
		return	of_Replace ( as_String, as_from, as_to, ab_all );
	END IF
END IF;
return	as_String;

end function

protected function string of_replaceall (string as_string, string as_from, string as_to);/*
	of_ReplaceAll
*/
RETURN		of_Replace ( as_String, as_From, as_To, true );
end function

protected function long of_separate (string as_fullname, ref string as_path, ref string as_file);/*
	of_Separate
*/
LONG	ll_len, ll_pos;

as_Path = "";
as_File = "";

ll_Len = LEN ( as_FullName )
ll_pos = LastPos ( as_FullName, "\" );
IF ll_pos > 0 THEN
	as_Path = LEFT ( as_FullName, ll_Pos );
END IF
IF ll_Len > ll_pos THEN
	as_File = RIGHT ( as_FullName, ll_Len - ll_pos );
END IF

RETURN		ll_Pos;
end function

protected function long of_gettargetdata (string as_targetfile, ref string as_appname, ref string as_applib, ref string as_liblist);/*
	of_getTargetData
*/
LONG	ll_rc = 0;
LONG	ll_ID;
String	ls_Data, ls_LibList;
String	ls_Parts [];

IF FileExists ( as_TargetFile ) THEN
	ll_ID = FileOpen ( as_TargetFile, LineMode!, Read! )
	IF ll_ID > 0 THEN
		DO WHILE FileRead ( ll_ID, ls_Data ) > 0
			IF of_Parse ( ls_Data, ls_Parts, " ") > 1 THEN
				CHOOSE CASE LOWER ( ls_Parts [ 1 ] )
					CASE "appname"
						as_AppName = of_Extract ( ls_Parts [ 2 ] );
						ll_rc ++;
					CASE "applib"
						as_AppLib = of_Extract ( ls_Parts [ 2 ] );
						ll_rc ++;
					CASE "liblist"
						ls_LibList = of_Extract ( ls_Parts [ 2 ] );
						ls_LibList = of_ReplaceAll ( ls_LibList, is_SemiColon, is_Comma )
						as_LibList = ls_LibList
						ll_rc ++;
				END CHOOSE
			END IF
		LOOP
		FileClose ( ll_ID );
	ELSE
		ll_rc = -2;
	END IF
ELSE
	ll_rc = -1;
END IF
return	ll_rc;
end function

protected function long of_parse (string as_line, ref string as_data[], string as_delimiter, boolean ab_skippbunitlibraries);String	pbLibrary
Integer	startPos, endPos
String	libraryList[]
Integer	i

IF RIGHT ( as_Line, 1 ) <> as_Delimiter THEN
	as_Line = as_Line + as_Delimiter;
END IF
startPos = 1
endPos = pos(as_Line, as_Delimiter, startPos) 
do while endPos > 0
	pbLibrary = mid(as_Line, startPos, endPos - startPos)
	if ab_skippbunitlibraries AND isPbUnitLibrary(pbLibrary) then
	else
		i++
		libraryList[i] = pbLibrary
		if lower(libraryList[i]) = "liblist" then
		// librarylist is a long string, might have space in it.
			i++
			libraryList[i] = trim(mid(as_Line, endPos + 1) )
			exit
		end if
	end if
	
	startPos = endPos + 1
	endPos = pos(as_Line, as_Delimiter, startPos) 
loop

as_Data = libraryList

return i
end function

protected function long of_parse (string as_line, ref string as_array[], string as_delimiter);RETURN		of_parse ( as_line, as_Array, as_Delimiter, false );
end function

protected function string of_extract (string as_quotedstring);LONG	ll_last, ll_first;
STRING	ls_String;

ls_String = as_QuotedString;

ll_first = POS ( ls_String, '"' )
IF ll_first > 0 THEN
	ls_String = RIGHT ( ls_String, LEN ( ls_String ) - ll_first );
	
	ll_last = LastPos ( ls_String, '"' );
	IF ll_last > 0 THEN
		ls_String = LEFT ( ls_String, ll_last - 1 );
	END IF
END IF

return	ls_String;


end function

public function long of_setdwshare (datawindow adw, integer ai_type);/*
	of_setDWShare
*/

LONG	ll_rc = -1;

CHOOSE CASE ai_Type
	CASE ii_TargetDataStore
		ll_rc = _ds_Targets.ShareData ( adw );

	CASE ii_LibraryDataStore
		ll_rc = _ds_PBLs.ShareData ( adw );
		
	CASE ii_TestDataStore
		ll_rc = _ds_Tests.ShareData ( adw );
		
		
	CASE ii_UnFilteredTestDataStore		
		ll_rc = _ds_Tests_unfiltered.ShareData ( adw );
//		MessageBox("adw", adw.RowCount())
//		MessageBox("ds", _ds_Tests_unfiltered.RowCount())
		
 
END CHOOSE

return	ll_rc;
end function

public function long of_settargetid (long al_targetid);/*
	of_setTargetID
*/
LONG	ll_row;
LONG	ll_ID = 0;
String	ls_Filter, ls_find;
String	ls_Path, ls_LibList, ls_AppName;

ll_ID = al_targetID

_l_CurrentTargetID = ll_ID;

_ds_PBLs.SetFilter("");
_ds_PBLs.Filter();

_ds_Tests.SetFilter("");
_ds_Tests.Filter();

_ds_Tests_unfiltered.SetFilter("");
_ds_Tests_unfiltered.Filter();


_l_LibraryRow = 0;
_l_CurrentLibraryID = 0;
_l_TargetRow = 0;

IF ll_ID > 0 THEN
	ls_Find = "TargetID=" + STRING ( ll_ID );
	_l_TargetRow = _ds_Targets . Find ( ls_Find, 1, _ds_Targets.RowCount() );
	IF _l_TargetRow > 0 THEN
		ls_Path = _ds_Targets . Object . Path [ _l_TargetRow ]
		ls_LibList = _ds_Targets . Object . LibList [ _l_TargetRow ]
		ls_AppName = _ds_Targets . Object . AppName [ _l_TargetRow ]
		of_setLibraryData ( ll_ID, ls_Path, ls_LibList, ls_AppName );
	END IF
END IF

RETURN _l_TargetRow;
end function

public function long of_setlibraryid (long al_libraryid);/*
	of_setLibraryID
*/
LONG	ll_row;
LONG	ll_ID = 0;
String	ls_Filter, ls_find;

ll_ID = al_LibraryID;
_l_CurrentLibraryID = ll_ID;

IF ll_ID > 0 THEN
	ls_Find = "LibraryID=" + STRING ( ll_ID );
	_l_LibraryRow = _ds_PBLs . Find ( ls_Find, 1, _ds_PBLs.RowCount() );
ELSE
	_l_LibraryRow = 0;
END IF

ls_Filter = "TargetID=" + String (_l_CurrentTargetID ) + " AND LibraryID=" + String ( ll_ID );
ll_row = _ds_Tests.SetFilter ( ls_Filter );
ll_row = _ds_Tests.Filter();
ll_row = _ds_Tests.RowCount ();

ls_Filter = "LibraryID=" + String ( ll_ID );
ll_row = _ds_Tests.SetFilter ( ls_Filter );
ll_row = _ds_Tests.Filter();
ll_row = _ds_Tests.RowCount ();
_l_TestRow = 0;
_l_CurrentTestID = 0;

RETURN ll_ID;
end function

public function long of_settestid (long al_testid);/*
	of_setTestID
*/
LONG	ll_row;
LONG	ll_ID = 0;
String	ls_Find;

ll_ID = al_testID;
_l_CurrentTestID = ll_ID;

IF ll_ID > 0 THEN
	ls_Find = "TestID=" + STRING ( ll_ID );
//	_l_TestRow = _ds_Tests . Find ( ls_Find, 1, _ds_Tests.RowCount() );
//	is_CurrentTestObject = _ds_Tests.Object.ObjectName [ _l_TestRow ];
//	_l_FullTestRow = _ds_Tests_Unfiltered .Find ( ls_Find, 1, _ds_Tests_Unfiltered.RowCount () );
	_l_TestRow = _ds_Tests_unfiltered . Find ( ls_Find, 1, _ds_Tests.RowCount() );
	is_CurrentTestObject = _ds_Tests_unfiltered.Object.ObjectName [ _l_TestRow ];
	_l_FullTestRow = _ds_Tests_unfiltered .Find ( ls_Find, 1, _ds_Tests_Unfiltered.RowCount () );
ELSE
	_l_TestRow = 0;
	is_CurrentTestObject = "";
	_l_FullTestRow = 0;
END IF

RETURN ll_ID;
end function

public function string of_getselectedtest ();String	ls_Test

IF _l_TestRow > 0 THEN
	
	ls_test = _ds_Tests.Object.DisplayName [ _l_testRow ];
	
END IF

return	ls_test
	
end function

protected function long of_setlibrarydata (long al_targetid, string as_path, string as_liblist, string as_appname);Long		ll_rc;
Long		ll_i, ll_idx;
Long		ll_libs, ll_test, ll_all
String	ls_Libraries[];
String	ls_Find;

ll_idx = of_Parse ( as_LibList, is_Libraries, is_Comma );
FOR ll_i = 1 TO ll_idx
	IF of_TestLibrary ( as_Path, is_Libraries, ll_i ) THEN
		ls_Find = "TargetID=" + String ( al_TargetID) + " AND Path='" + as_Path + "' AND Library='" + is_Libraries [ ll_i ] + "'";
		ll_rc = _ds_PBLs.Find ( ls_Find, 1, _ds_PBLs.RowCount() );
		IF ll_rc = 0 THEN
			ll_rc = _ds_PBLs.InsertRow ( 0 );
			_ds_PBLs . Object . TargetID		[ ll_rc ] = al_TargetID
			_ds_PBLs . Object . LibraryID		[ ll_rc ] = ll_rc
			_ds_PBLs . Object . Path				[ ll_rc ] = as_Path;
			_ds_PBLs . Object . Library			[ ll_rc ] = is_Libraries [ ll_i ];
			_ds_PBLs . Object . AppName			[ ll_rc ] = as_AppName;
			_ds_PBLs . Object . DisplayName	[ ll_rc ] = as_AppName + ":" + is_Libraries [ ll_i ];
		END IF
		of_setTestData ( al_TargetID, ll_rc, as_AppName, as_Path, is_Libraries [ ll_i ] );
	END IF
NEXT;

ll_rc = _ds_PBLs . RowCount ();
ll_test = _ds_Tests.RowCount ();
ll_all = _ds_Tests_unfiltered.RowCount ();

return	ll_rc;
			
end function

public function long of_setcurrenttest (string as_testtext);/*
	of_SetCurrentTest
*/
LONG	ll_row, ll_ID, ll_TargetID, ll_LibraryID;
String	ls_Find, ls_liblist, ls_Path;

IF LOWER ( as_TestText ) = LOWER ( is_CurrentTestObject ) THEN
	ll_row = _l_CurrentTestID;
	
	IF _l_CurrentTestID > 0 THEN
	//ls_Find = "DisplayName='" + as_TestText + "'";
	//ll_row = _ds_Tests_Unfiltered . Find ( ls_Find, 1, _ds_Tests_Unfiltered.RowCount() );
	//IF ll_row > 0 THEN
	//	ll_ID = _ds_Tests_Unfiltered.Object.TestID [ ll_row ];
	//	of_SetTestID (  ll_ID );
	//	
	//	IF _l_FullTestRow > 0 THEN
	//		is_CurrentTestObject = _ds_Tests_Unfiltered.Object.ObjectName [ _l_FullTestRow ];
	//		ll_TargetID = _ds_Tests_Unfiltered.Object.TargetID [ _l_FullTestRow ];
	//		ll_LibraryID = _ds_Tests_Unfiltered.Object.LibraryID [ _l_FullTestRow ];
	//		of_SetTargetID ( ll_TargetID );
	//		of_SetLibraryID ( ll_LibraryID );
	//	END IF
	//	
//		of_SetLibraryList ();
		if  NOT isValid(findClassDefinition(is_CurrentTestObject, is_Libraries )) then
			ll_row = -99
	//	ELSE
	//		inv_test = create using is_CurrentTestObject
		END IF
//		THIS.of_ResetLibraryList ();
	ELSE
		ll_Row = 0;
	END IF
ELSE
	ll_Row = -100
END IF

return	ll_row
end function

public function long of_resetlibrarylist ();
_CurrentLibraryList = _InitialLibraryList;
RETURN		SetLibraryList ( _CurrentLibraryList );
end function

public function test of_getcurrenttest ();of_terminatetest();

of_SetLibraryList ();

ClassDefinition cd_def

cd_def = findClassDefinition(is_CurrentTestObject)

if  NOT isValid(cd_def)  then
	THIS.of_ResetLibraryList ();
	return	inv_test;
ELSE
 
	inv_test = create using is_CurrentTestObject
  
	return	inv_test.Suite(   )
  
 
 
END IF


end function

public function long of_setlibrarylist (string as_addlist, string as_path);/*
	of_SetLibraryList
*/
String	ls_LibList, ls_Libraries [];
LONG	ll_i, ll_idx, ll_rc;

ll_idx = of_Parse ( as_AddList, ls_Libraries, is_Comma );
ls_LibList = ""
FOR ll_i = 1 TO ll_IDX
	IF ll_i > 1 THEN
		ls_LibList = ls_LibList + is_Comma;
	END IF
	ls_LibList = ls_LibList + as_Path + ls_Libraries [ ll_i ];
NEXT

_CurrentLibraryList = _InitialLibraryList + ',' + ls_LibList;
ll_rc =	SetLibraryList ( _CurrentLibraryList );
return	ll_rc;
end function

protected subroutine of_filterlibraries (long al_targetid, long al_libraryid, long al_testid);/*
	of_FilterLibraries
*/
String	ls_Filter = "TargetID=";
String	ls_Find = " AND LibraryID=";

ls_Filter = ls_Filter + String ( al_TargetID );
_ds_PBLs.SetFilter ( ls_Filter );
_ds_PBLs.Filter();

IF _ds_PBLs.RowCount () > 0 THEN
	ls_Find = ls_Filter + ls_Find + String ( al_LibraryID );
	_l_LibraryRow = _ds_PBLs.Find ( ls_Find, 1, _ds_PBLs.RowCount()  );
	IF _l_LibraryRow > 0 THEN
		_l_CurrentLibraryID = al_LibraryID;
	ELSE
		_l_CurrentLibraryID = 0;
	END IF
ELSE
	_l_LibraryRow = 0;
	_l_CurrentLibraryID = 0;
END IF

end subroutine

protected subroutine of_filtertargets (long al_targetid, long al_libraryid, long al_testid);/*
	of_FilterTargets
*/
String	ls_Filter = "TargetID=";
String	ls_Find = " AND LibraryID=";

ls_Find = ls_Filter + String ( al_TargetID );
//_ds_Targets.SetFilter ( ls_Filter );
//_ds_Targets.Filter();

IF _ds_Targets.RowCount () > 0 THEN
//	ls_Find = ls_Filter + ls_Find + String ( al_LibraryID );
	_l_TargetRow = _ds_Targets.Find ( ls_Find, 1, _ds_Targets.RowCount()  );
	IF _l_TargetRow > 0 THEN
		_l_CurrentTargetID = al_LibraryID;
	ELSE
		_l_CurrentTargetID = 0;
	END IF
ELSE
	_l_TargetRow = 0;
	_l_CurrentTargetID = 0;
END IF

end subroutine

protected subroutine of_filtertests (long al_targetid, long al_libraryid, long al_testid);/*
	of_FilterTests
*/
String	ls_Filter1 = "TargetID=";
String	ls_Filter2 = " AND LibraryID=";
String	ls_Find = " AND TestID=";

ls_Filter1 = ls_Filter1 + String ( al_TargetID ) + ls_Filter2 + String ( al_LibraryID );
_ds_Tests.SetFilter ( ls_Filter1 );
_ds_Tests.Filter();
ls_Find = ls_Filter1 + ls_Find + String ( al_TestID );

IF _ds_Tests_Unfiltered.RowCount () > 0 THEN
	_l_FullTestRow = _ds_Tests_Unfiltered.Find ( ls_Find, 1, _ds_Tests.RowCount()  );
END IF

IF _ds_Tests.RowCount () > 0 THEN
	ls_Find = ls_Filter1 + ls_Find + String ( al_TestID );
	_l_TestRow = _ds_Tests.Find ( ls_Find, 1, _ds_Tests.RowCount()  );
	IF _l_TestRow > 0 THEN
		_l_CurrentTestID = al_TestID;
	ELSE
		_l_CurrentTestID = 0;
	END IF
ELSE
	_l_TestRow = 0;
	_l_CurrentTestID = 0;
END IF

end subroutine

public function long of_gettargetid ();/*
	of_GetTargetID
*/
return	_l_CurrentTargetID;
end function

public function long of_getlibraryid ();/*
	of_GetLibraryID
*/
return	_l_CurrentLibraryID;
end function

public function long of_gettestid ();/*
	of_GetTestID
*/
return	_l_CurrentTestID;
end function

public function long of_findtest (string as_testtext);/*
	of_FindTest
*/
LONG	ll_row, ll_Target, ll_Library, ll_Test;
String	ls_Find;

ls_Find = "DisplayName='" + as_TestText;
ll_row = _ds_Tests_unfiltered.Find ( ls_Find, 1, _ds_Tests_unfiltered.RowCount () );
IF ll_Row > 0 THEN
	_l_CurrentTargetID = _ds_Tests_unfiltered.Object.TargetID [ ll_row ];
	_l_CurrentLibraryID = _ds_Tests_unfiltered.Object.LibraryID [ ll_row ];
	_l_CurrentTestID = _ds_Tests_unfiltered.Object.TestID [ ll_row ];
	
	of_SetTargetID ( _l_CurrentTargetID );
	of_SetLibraryID ( _l_CurrentLibraryID );
	of_SetTestID ( _l_CurrentTestID );
END IF

RETURN	ll_Row;

end function

private subroutine of_setlibrarylist ();/*		of_SetLibraryList()		*/

IF _l_TargetRow > 0 THEN
	of_SetLibraryList (	_ds_Targets.Object.LibList [ _l_TargetRow ], &
								_ds_Targets.Object.Path [ _l_TargetRow ] );
END IF

end subroutine

public function datastore of_gettargetlist ();/*
	of_getTargetList		Retrieve list of valid target files from the workstation registry
	
	Returns:	DataStore
	
	03/25/2003	PCY	Initial Version
*/
String	ls_RegistryKeys [];
LONG	ll_rc;
LONG	ll_target, ll_targets;
LONG	ll_row		//, ll_Len, ll_Pos;
String	ls_Key, ls_Path, ls_File;
Long	ll_CPUStart, ll_CPUEnd;

IF _ds_Targets.RowCount() = 0 THEN
	ll_CPUStart = CPU ();
	
	ls_key = _s_RegistryPath + is_BackSlash + is_TargetPath
	ll_rc = RegistryKeys ( ls_key, ls_RegistryKeys );
	IF ll_rc > 0 THEN
		_ds_targets.Reset();
		ll_targets = UpperBound ( ls_RegistryKeys );
		FOR ll_target = 1 TO ll_targets
			ls_Key = ls_RegistryKeys [ ll_Target ];
			//		Convert the $ to back-slashes
			ls_Key = of_ReplaceAll ( ls_Key, is_Dollar, is_BackSlash );
			//		Verify target file exists
			IF FileExists ( ls_Key ) THEN

				of_setTargetData ( ls_Key )
			END IF
		NEXT;
		_ds_Targets.Sort();
	END IF;
	
	ll_CPUEnd = ll_CPUStart + 1 * 1000	//	Let's Wait 5 seconds?
	DO WHILE ll_CPUEnd > CPU ()
	LOOP
	
	IF _ds_targets.RowCount () < 1 THEN
		MessageBox ( "Target Library Selection", "No valid PowerBuilder targets found in registry!" )
	END IF
END IF

return	_ds_targets;
end function

protected function long of_settestdata (long al_targetid, long al_libraryid, string as_appname, string as_path, string as_library);String	ls_data, ls_Lib [1], ls_Objectname, ls_Comment;
//ClassDefinition	lcd_classdefn
Long	ll_row, ll_rows, ll_NewRow;
String	ls_Find;
String	ls_testMethods []

Int		i

ls_Lib[1] = as_Path + as_Library;

ll_rows = ids_data.RowCount ()	//ImportString ( ls_data );



IF ll_rows > 0 THEN
	FOR ll_row = 1 TO ll_rows
		ls_ObjectName = ids_data.Object.ObjectName [ ll_row ];
		ls_Comment = ids_data.Object.Comments [ ll_row ];
//		lcd_ClassDefn = FindClassDefinition ( ls_ObjectName, ls_Lib );
		ls_Find = "LibraryID=" + String ( al_LibraryID ) + " AND TargetID=" + String ( al_TargetID ) + " AND ObjectName='" + ls_ObjectName + "'";
		ll_NewRow = _ds_Tests.Find ( ls_Find, 1, _ds_Tests.RowCount () );
		IF ll_NewRow = 0 THEN


			ll_newRow = _ds_Tests.InsertRow ( 0 );

			_ds_Tests.Object.MethodName 	[ ll_NewRow ] = '';
			
			
			_ds_Tests.Object.LibraryID		[ ll_NewRow ] = al_LibraryID;
			_ds_Tests.Object.Path			[ ll_NewRow ] = as_Path;
			_ds_Tests.Object.AppName		[ ll_NewRow ] = as_AppName;
			_ds_Tests.Object.TargetID		[ ll_NewRow ] = al_TargetID;
			_ds_Tests.Object.Library		[ ll_NewRow ] = as_Library;
			_ds_Tests.Object.TestID			[ ll_NewRow ] = ll_newRow;
			_ds_Tests.Object.ObjectName	[ ll_NewRow ] = ls_ObjectName;
			_ds_Tests.Object.TestName		[ ll_NewRow ] = ls_ObjectName;
			_ds_Tests.Object.Comment		[ ll_NewRow ] = LEFT ( ls_Comment, 255 );
			_ds_Tests.Object.DisplayName	[ ll_NewRow ] = ls_ObjectName + ":" + as_AppName + ":" + as_Library;


			_ds_Tests . RowsCopy ( ll_NewRow, ll_NewRow, Primary!, _ds_Tests_unfiltered, _ds_Tests_unfiltered.RowCount() + 1, Primary! );


			// get method list
			inv_objectservice.of_get_test_method_list( ls_ObjectName, ls_testmethods, is_libraries_with_path)
			
			For i = 1 to UpperBound( ls_testmethods )
				ll_newRow = _ds_Tests.InsertRow ( 0 );
	
				_ds_Tests.Object.MethodName 	[ ll_NewRow ] = ls_testmethods [i];
				
				
				_ds_Tests.Object.LibraryID		[ ll_NewRow ] = al_LibraryID;
				_ds_Tests.Object.Path			[ ll_NewRow ] = as_Path;
				_ds_Tests.Object.AppName		[ ll_NewRow ] = as_AppName;
				_ds_Tests.Object.TargetID		[ ll_NewRow ] = al_TargetID;
				_ds_Tests.Object.Library		[ ll_NewRow ] = as_Library;
				_ds_Tests.Object.TestID			[ ll_NewRow ] = ll_newRow;
				_ds_Tests.Object.ObjectName	[ ll_NewRow ] = ls_ObjectName;
				_ds_Tests.Object.TestName		[ ll_NewRow ] = ls_ObjectName;
				_ds_Tests.Object.Comment		[ ll_NewRow ] = LEFT ( ls_Comment, 255 );
				_ds_Tests.Object.DisplayName	[ ll_NewRow ] = ls_ObjectName + ":" + as_AppName + ":" + as_Library;
	
 	
				_ds_Tests . RowsCopy ( ll_NewRow, ll_NewRow, Primary!, _ds_Tests_unfiltered, _ds_Tests_unfiltered.RowCount() + 1, Primary! );
			Next
		END IF
		
	NEXT
	_ds_Tests.Sort();
	_ds_Tests_unfiltered.Sort();
END IF

return	ll_rows;

end function

private function boolean of_testlibrary (string as_path, string as_library[], long al_index);/*
	of_TestLibrary	Test to see if library should be included in Library List
*/
Boolean	lb_RC = false;

String	ls_data, ls_Objectname, ls_Comment;
String	ls_Lib []
ClassDefinition	lcd_classdefn
Long	ll_row, ll_rows, ll_NewRow;

String   ls_testmethods []

//ls_Lib[1] = as_Path + as_Library [ al_Index ];
FOR ll_Row = UpperBound ( as_Library ) TO 1 STEP -1
	ls_LIB [ ll_row ] = as_Path + as_Library [ ll_row ];
NEXT

ls_data = LibraryDirectory ( ls_Lib [ al_Index], DirUserObject! )
ids_data.Reset();

ll_rows = ids_data.ImportString ( ls_data );

of_restorelibrarylist(as_library,as_path, is_libraries_with_path )

IF ll_rows > 0 THEN
	FOR ll_row = ll_rows TO 1 Step -1
		ls_ObjectName = ids_data.Object.ObjectName [ ll_row ];
		
		// delete non-testcase objects
//		if not this.isavalidtestclassname( ls_ObjectName ) then
		if not inv_objectservice.of_is_a_valid_test_class(ls_ObjectName, is_libraries_with_path) then
			ids_data.deleterow( ll_row )
			continue

		end if
		
		
		ls_Comment = ids_data.Object.Comments [ ll_row ];
		lcd_ClassDefn = FindClassDefinition ( ls_ObjectName, ls_Lib );
		lb_RC = true;
	NEXT
END IF
return	lb_RC;
end function

public subroutine of_terminatetest ();If IsValid ( inv_Test ) THEN
	DESTROY inv_Test;
END IF
return;
end subroutine

public subroutine of_reset ();_ds_Tests.SetFilter ("");
_ds_Tests.Filter ();
//_ds_Tests_unfiltered;


end subroutine

public function long of_settargetdata (string as_targetfile);/*
	of_setTargetData
*/
String	ls_path, ls_file, ls_AppName, ls_appLib, ls_liblist, ls_Display, ls_Find;
Long		ll_rc = 0, ll_row, ll_rows;
LONG	ll_i, ll_idx;
String	ls_Libraries[]

IF FileExists ( as_TargetFile ) THEN
	IF of_Separate ( as_TargetFile, ls_Path, ls_File ) > 0 THEN
		//		Access Target and get Application Name and library list
		IF of_getTargetData ( as_TargetFile, ls_AppName, ls_AppLib, ls_LibList ) > 0 THEN
			IF RIGHT ( ls_Path, 1 ) <> is_BackSlash THEN
				ls_Path = ls_Path + is_BackSlash;
			END IF
			ls_Display = ls_Path + ls_AppLib;
			ls_find='DisplayName="' + ls_Display + '"';
			ll_rows = _ds_Targets.RowCount();
			IF ll_rows > 0 THEN
				ll_row = _ds_Targets.Find ( ls_Find, 1, ll_rows );
			ELSE
				ll_row = 0;
			END IF
			IF ll_row = 0 THEN
				ll_row = _ds_Targets.InsertRow ( 0 );
				_ds_Targets . Object . TargetID		[ ll_row ] = ll_row
				_ds_Targets . Object . Path				[ ll_row ] = ls_Path;
				_ds_Targets . Object . FileName			[ ll_row ] = ls_File;
				_ds_Targets . Object . AppName			[ ll_row ] = ls_AppName;
				_ds_Targets . Object . AppLib			[ ll_row ] = ls_AppLib;
				_ds_Targets . Object . LibList			[ ll_row ] = ls_LibList;
				_ds_Targets . Object . DisplayName	[ ll_row ] = ls_Display;
//				of_setLibraryData ( ll_row, ls_Path, ls_LibList, ls_AppName );
			END IF
			
			ChangeDirectory( ls_path )
			//MessageBox("change dir", GetCurrentDirectory())
			ll_rc = ll_row;
		ELSE
			ll_rc = -1;
		END IF
	ELSE
		ll_rc = -2;
	END IF
ELSE
	ll_rc = -3;
END IF
			
RETURN		ll_rc;
end function

public subroutine startpbunit (string as_commandline);OpenwithParm ( w_PBUnit, as_commandline );
end subroutine

public subroutine of_resettargetlist ();_ds_Targets.reset()


_ds_Tests_unfiltered.reset()
_ds_Tests.reset()
_ds_PBLs.reset()
end subroutine

public function boolean isavalidtestclassname (string as_testobjectname); 

return ( right(as_TestObjectName, 5) = "tests" )
end function

public function integer of_get_testcase_count ();return _ds_Tests_unfiltered.rowcount()
end function

public function string of_get_registrypathbase ();return is_RegistryPathBase
end function

public subroutine of_restorelibrarylist (string as_librarylist[], string as_path, ref string as_librarylist_with_path[]);string ls_libraries[]
int i

for i = 1 to upperbound( as_librarylist )
	ls_libraries[i] = as_path + as_librarylist[i]
next

as_librarylist_with_path = ls_Libraries

return
end subroutine

public subroutine of_set_current_test_method (string as_methodname);is_CurrentTestMethod = as_MethodName
end subroutine

public function integer of_get_test_method_count_by_object_name (string as_objectname);integer li_count
long	  ll_row, ll_start

string  ls_condition

ls_condition = 'objectname="' + as_objectname +'" and methodname <> ""'

do 
	ll_start = ll_row 
	
	ll_row = _ds_Tests_unfiltered.Find( ls_condition, &
		ll_start + 1, _ds_Tests_unfiltered.RowCount() )
		
	if ll_row > ll_start then
		li_count ++

	end if
	
loop while ll_row > ll_start

return li_count
end function

public function string of_get_test_method_name (string as_objectname, integer ai_index);integer li_count
long	  ll_row
long	  ll_start
integer li_index

string  ls_condition
string  ls_methodname

ls_condition = 'objectname="' + as_objectname +'" and methodname <> ""'

do 
	ll_start = ll_row
	
	ll_row = _ds_Tests_unfiltered.Find( ls_condition, &
		ll_start + 1, _ds_Tests_unfiltered.RowCount() )
	
	if ll_row > ll_start then
		li_index ++
		if li_index = ai_index then 
			ls_methodname = _ds_Tests_unfiltered.getitemstring( ll_row, 'methodname')
			return ls_methodname
		
		end if
		
	end if
		
	
loop while ll_row > ll_start

return ls_methodname
end function

public subroutine self_destruct ();sb_initialized = false
//DESTROY _ds_Targets;
//DESTROY _ds_PBLs;
//DESTROY _ds_Tests;
//DESTROY _ds_Tests_Unfiltered;
//
//this.event destructor( )
end subroutine

on n_pbunit_librarymanager.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_pbunit_librarymanager.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_data = CREATE DataStore;
ids_data.DataObject = 'd_pbunit_libraryDirectory';

IF NOT sb_Initialized THEN
	
	getEnvironment ( _env_Environment );
	_s_RegistryPath = is_RegistryPathBase + String ( _env_Environment . PBMajorRevision ) + '.' + String ( _env_Environment . PBMinorRevision );
	
	_ds_Targets	= CREATE DataStore;
	_ds_Targets.DataObject = is_TargetDWO;
	
	_ds_PBLs		= CREATE DataStore;
	_ds_PBLs.DataObject = is_PBLDWO;
	
	_ds_Tests		= CREATE DataStore;
	_ds_Tests.DataObject = is_TestDWO;
	
	_ds_Tests_Unfiltered		= CREATE DataStore;
	_ds_Tests_Unfiltered.DataObject = is_TestDWO;
	
	_InitialLibraryList = GetLibraryList ();
	_InPowerbuilder = ( SetLibraryList ( _InitialLibraryList ) = -1 );
	
	THIS . setcurrentlibrarylist( _InitialLibraryList );
	
	THIS . UpdateLibraryList ( "pbunit.pbd,pbunitfunc.pbd,pbunitui.pbd" );

	
	sb_initialized = true;
END IF
end event

event destructor;Destroy ids_data;
this.of_terminatetest ();

IF NOT sb_Initialized THEN
	IF IsValid ( _ds_Targets ) 	THEN DESTROY _ds_Targets;
	IF IsValid ( _ds_PBLs     ) 	THEN DESTROY _ds_PBLs;
	IF IsValid ( _ds_Tests     ) 	THEN DESTROY _ds_Tests;
	IF IsValid ( _ds_Tests_Unfiltered     ) 	THEN DESTROY _ds_Tests_Unfiltered;
END IF
end event

