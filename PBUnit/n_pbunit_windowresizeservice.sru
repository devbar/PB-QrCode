HA$PBExportHeader$n_pbunit_windowresizeservice.sru
forward
global type n_pbunit_windowresizeservice from nonvisualobject
end type
type os_resize from structure within n_pbunit_windowresizeservice
end type
end forward

type os_resize from structure
	graphicobject		wo_control
	string		s_classname
	string		s_typeof
	boolean		b_scale
	boolean		b_movex
	boolean		b_movey
	boolean		b_scalewidth
	boolean		b_scaleheight
	real		r_x
	real		r_y
	real		r_width
	real		r_height
	integer		i_widthmin
	integer		i_heightmin
	integer		i_movex
	integer		i_movey
	integer		i_scalewidth
	integer		i_scaleheight
end type

global type n_pbunit_windowresizeservice from nonvisualobject
event type integer pfc_resize ( unsignedlong aul_sizetype,  integer ai_newwidth,  integer ai_newheight )
end type
global n_pbunit_windowresizeservice n_pbunit_windowresizeservice

type variables
Public:
// Predefined resize constants.
Constant String FIXEDRIGHT =  'FixedToRight'
Constant String FIXEDBOTTOM = 'FixedToBottom'
Constant String FIXEDRIGHTBOTTOM = 'FixedToRight&Bottom'
Constant String SCALE = 'Scale'
Constant String SCALERIGHT = 'ScaleToRight'
Constant String SCALEBOTTOM = 'ScaleToBottom'
Constant String SCALERIGHTBOTTOM = 'ScaleToRight&Bottom'
Constant String FIXEDRIGHT_SCALEBOTTOM = 'FixedToRight&ScaleToBottom'
Constant String FIXEDBOTTOM_SCALERIGHT = 'FixedToBottom&ScaleToRight'

Protected:

constant string  DRAGOBJECT = 'dragobject!'
constant string  LINE = 'line!'
constant string  OVAL = 'oval!'
constant string  RECTANGLE = 'rectangle!'
constant string  ROUNDRECTANGLE = 'roundrectangle!'
constant string  MDICLIENT = 'mdiclient!'

constant string  ics_dragobject = 'dragobject!'	// Obsoleted in 6.0
constant string  ics_line = 'line!'		// Obsoleted in 6.0
constant string  ics_oval = 'oval!'		// Obsoleted in 6.0
constant string  ics_rectangle = 'rectangle!'	// Obsoleted in 6.0
constant string  ics_roundrectangle = 'roundrectangle!' // Obsoleted in 6.0
constant string ics_mdiclient = 'mdiclient!'	// Obsoleted in 6.0

long 	il_parentminimumwidth=0
long	il_parentminimumheight=0
long	il_parentprevwidth=-1
long	il_parentprevheight=-1

integer	ii_rounding = 5

PRIVATE os_resize	istr_registered[]

end variables

forward prototypes
public function integer of_unregister (windowobject awo_control)
protected function string of_typeof (windowobject awo_control)
public function integer of_register (windowobject awo_control, string as_method)
public function integer of_setminsize (integer ai_minwidth, integer ai_minheight)
public function integer of_SetOrigSize (integer ai_width, integer ai_height)
public function integer of_getminmaxpoints (windowobject awo_control[], ref integer ai_min_x, ref integer ai_min_y, ref integer ai_max_x, ref integer ai_max_y)
protected function integer of_resize (integer ai_newwidth, integer ai_newheight)
protected function integer of_register (windowobject awo_control, boolean ab_scale, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight)
public function integer of_register (windowobject awo_control, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight)
end prototypes

event pfc_resize;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  resize
//
//	Description:
//	Send resize notification to services.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Return of_Resize(ai_newwidth, ai_newheight)
end event

public function integer of_unregister (windowobject awo_control);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_UnRegister	
//
//	Access:  		public
//
//	Arguments:		
//	awo_control		The control to unregister.
//
//	Returns:  		integer
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//
//	Description:  	Unregister a control that was previously registered.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Changed to support for weighted movement and sizing of controls.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer			li_upperbound
integer			li_cnt
integer			li_registered_slot

//Check parameters
If IsNull(awo_control) or (not IsValid(awo_control)) Then
	Return -1
End If

//Confirm that the user object has already been initialized
If il_parentprevheight=-1 And il_parentprevwidth=-1 Then
	Return -1
End If

//Get the current UpperBound
li_upperbound = UpperBound (istr_registered[])

//Find the registered object
li_registered_slot = 0
For li_cnt = 1 to li_upperbound
	If istr_registered[li_cnt].wo_control = awo_control Then
		li_registered_slot = li_cnt
		exit
	End If
Next

//If the control was not previously registered, return
//an error code.
If li_registered_slot = 0 Then
	Return -1
End If

//Unregister the control
SetNull(istr_registered[li_registered_slot].wo_control)
istr_registered[li_registered_slot].s_typeof = ''
istr_registered[li_registered_slot].b_movex = False
istr_registered[li_registered_slot].i_movex = 0
istr_registered[li_registered_slot].b_movey = False
istr_registered[li_registered_slot].i_movey = 0
istr_registered[li_registered_slot].b_scalewidth = False
istr_registered[li_registered_slot].i_scalewidth = 0
istr_registered[li_registered_slot].b_scaleheight = False
istr_registered[li_registered_slot].i_scaleheight = 0

Return 1

end function

protected function string of_typeof (windowobject awo_control);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_TypeOf
//
//	Access:  		protected
//
//	Arguments:		
//	awo_control		The window object for which a type is needed.
//
//	Returns:  		string
//						Describes the type of the object.
//						'!' if an error occurs.
//
//	Description:  	Determines on the type of an object for the purposes of 
//						getting to its attributes.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Changed to use new constants.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(awo_control) or (not IsValid(awo_control)) Then
	Return '!'
End If

//Validate and set typeof value
Choose Case awo_control.TypeOf()
	Case checkbox!, commandbutton!, datawindow!, dropdownlistbox!, &
			dropdownpicturelistbox!, graph!, groupbox!, hscrollbar!, listbox!, &
			picturelistbox!, listview!, multilineedit!, editmask!, picture!, &
			picturebutton!, radiobutton!, richtextedit!, singlelineedit!, statictext!, &
			tab!, treeview!, userobject!, vscrollbar!, omcontrol!, omcustomcontrol!, &
			olecustomcontrol!, omembeddedcontrol!, olecontrol!
		Return DRAGOBJECT
	Case line!
		Return LINE
	Case oval!
		Return OVAL
	Case rectangle!
		Return RECTANGLE
	Case roundrectangle!
		Return ROUNDRECTANGLE
	Case mdiclient!
		Return MDICLIENT
End Choose

Return '!'
end function

public function integer of_register (windowobject awo_control, string as_method);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Register
//
//	Access:  		public
//
//	Arguments:		
//	awo_control		The window object being registered.
//	as_method		The desired resize/move method.
//						Valid values are:
//						 'FixedToRight'
//						 'FixedToBottom'
//						 'FixedToRight&Bottom'
//						 'Scale'
//						 'ScaleToRight'
//						 'ScaleToBottom'
//						 'ScaleToRight&Bottom'
//						 'FixedToRight&ScaleToBottom'
//						 'FixedToBottom&ScaleToRight'
//
//	Returns:  		integer
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//
//	Description:  	Register a control which needs to either be moved or resized
//						when the parent object is resized. 
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	6.0	Changed to use constants for checking resize method.
// 6.0	Changed to support for weighted movement and sizing of controls.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

constant integer FULL_PERCENT= 100
dragobject		ldrg_cntrl
oval				loval_cntrl
line				ln_cntrl
rectangle		lrec_cntrl
roundrectangle	lrrec_cntrl
integer			li_x, li_y, li_width, li_height
integer			li_upperbound
integer			li_cnt
integer			li_slot_available
integer			li_movex, li_movey
integer			li_scalewidth, li_scaleheight
boolean			lb_scale=False

//Check parameters
If IsNull(awo_control) or (not IsValid(awo_control)) or IsNull(as_method) Then
	Return -1
End If

//Translate and finish validating parameteters
Choose Case Lower(as_method)
	Case Lower(FIXEDRIGHT)
		li_movex = FULL_PERCENT
	Case Lower(FIXEDBOTTOM)
		li_movey = FULL_PERCENT
	Case Lower(FIXEDRIGHTBOTTOM)
		li_movex = FULL_PERCENT
		li_movey = FULL_PERCENT
	Case Lower(SCALE)
		lb_scale = True
	Case Lower(SCALERIGHT)
		li_scalewidth = FULL_PERCENT
	Case Lower(SCALEBOTTOM)
		li_scaleheight = FULL_PERCENT
	Case Lower(SCALERIGHTBOTTOM)
		li_scalewidth = FULL_PERCENT
		li_scaleheight = FULL_PERCENT
	Case Lower(FIXEDRIGHT_SCALEBOTTOM)		
		li_movex = FULL_PERCENT
		li_scaleheight = FULL_PERCENT
	Case Lower(FIXEDBOTTOM_SCALERIGHT)	
		li_movey = FULL_PERCENT
		li_scalewidth = FULL_PERCENT
Case Else
		Return -1
End Choose

Return of_Register(awo_control, lb_scale, &
		li_movex, li_movey, li_scalewidth, li_scaleheight)
end function

public function integer of_setminsize (integer ai_minwidth, integer ai_minheight);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetMinSize
//
//	Access:  		public
//
//	Arguments:		
//	ai_minwidth		The minimum width for the parent object.
//	ai_minheight	The minimum height for the parent object.
//
//	Returns:  		integer
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//
//	Description:  	Sets the current object minimum size attributes.
//						Note: the service object needs to be initialized (of_SetOrigSize())
//						prior to	setting the Minimum size of the object.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If	IsNull(ai_minwidth) or IsNull(ai_minheight) Then
	Return -1
End If

//Confirm that the user object has already been initialized
If il_parentprevheight=-1 And il_parentprevwidth=-1 Then
	Return -1
End If

//Set the minimum values for the width and height
il_parentminimumwidth = ai_minwidth
il_parentminimumheight = ai_minheight

Return 1

end function

public function integer of_SetOrigSize (integer ai_width, integer ai_height);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetOrigSize
//
//	Access:  		public
//
//	Arguments:		
//	ai_width			The current width of the parent object.
//	ai_height		The current height of the parent object.
//
//	Returns:  		integer
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//
//	Description:  	Initializes the Resize object by setting the current object
//						size.
//						Note: the service object needs to be initialized (this function)
//						prior to	the registering (of_register()) of objects.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

//Check parameters
If IsNull(ai_width) or IsNull(ai_height) Then
	Return -1
End If

//Set the current width and height
il_parentprevwidth = ai_width
il_parentprevheight = ai_height

Return 1

end function

public function integer of_getminmaxpoints (windowobject awo_control[], ref integer ai_min_x, ref integer ai_min_y, ref integer ai_max_x, ref integer ai_max_y);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetMinMaxPoints
//
//	Access:  		public
//
//	Arguments:		
//	awo_control[]	The control array for whom the Min and Max attributes are needed.
//	ai_min_x			The minimum X point found by looking at the X attributes of all
//							the controls on the control array (by reference).
//	ai_min_y			The minimum Y point found by looking at the X attributes of all
//							the controls on the control array (by reference).
//	ai_max_x			The maximum X point found by adding the X and Width attributes
//							of all the controls on the control array (by reference).
//	ai_max_y			The maximum Y point found by adding the Y and Height attributes
//							of all the controls on the control array (by reference).
//
//	Returns:  		integer
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//
//	Description:  	Determines the four extreme points of the controls within a 
//						control array by looking at the X, Y, Width, Height, BeginX, 
//						BeginY, EndX, EndY attributes.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Changed to use new constants.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

dragobject		ldrg_cntrl
oval				loval_cntrl
line				ln_cntrl
rectangle		lrec_cntrl
roundrectangle	lrrec_cntrl

integer			li_x, li_y, li_width, li_height, li_temp
integer			li_upperbound
integer			li_cnt

//Check arguments
If IsNull(awo_control) or IsNull(awo_control[]) or UpperBound(awo_control[])=0 Then
	Return -1
End If

//Initialize
ai_min_x=32767
ai_min_y=32767
ai_max_x=0
ai_max_y=0

//Get the Control upper bound
li_upperbound = UpperBound (awo_control[])

//Determine position of the right most and bottom most control.
For li_cnt = 1 to li_upperbound
	If IsValid(awo_control[li_cnt]) Then
		Choose Case of_TypeOf(awo_control[li_cnt])
			Case DRAGOBJECT
				//Set a reference to the control.
				ldrg_cntrl = awo_control[li_cnt]
				//Get the position, width, and height of the control.
				li_x = ldrg_cntrl.X
				li_y = ldrg_cntrl.Y
				li_width = ldrg_cntrl.Width
				li_height = ldrg_cntrl.Height
			Case LINE
				ln_cntrl = awo_control[li_cnt]
				li_x = ln_cntrl.BeginX
				li_y = ln_cntrl.BeginY
				li_width = ln_cntrl.EndX
				li_height = ln_cntrl.EndY
				//Correct for lines that may have the End points 
				//before to the Begin points.
				If li_width >= li_x Then
					li_width = li_width - li_x
				Else
					li_temp = li_x
					li_x = li_width
					li_width = li_temp - li_x
				End If	
				If li_height >= li_y Then
					li_height = li_height - li_y
				Else
					li_temp = li_y
					li_y = li_height
					li_height = li_temp - li_y
				End If
			Case OVAL
				loval_cntrl = awo_control[li_cnt]
				li_x = loval_cntrl.X
				li_y = loval_cntrl.Y
				li_width = loval_cntrl.Width
				li_height = loval_cntrl.Height		
			Case RECTANGLE
				lrec_cntrl = awo_control[li_cnt]
				li_x = lrec_cntrl.X
				li_y = lrec_cntrl.Y
				li_width = lrec_cntrl.Width
				li_height = lrec_cntrl.Height		
			Case ROUNDRECTANGLE
				lrrec_cntrl = awo_control[li_cnt]
				li_x = lrrec_cntrl.X
				li_y = lrrec_cntrl.Y
				li_width = lrrec_cntrl.Width
				li_height = lrrec_cntrl.Height
			Case MDICLIENT
				Continue
			Case Else
				//An unknown control type has been encountered
				Return -1
		End Choose
		
		//Determine the Min and Max points
		If li_x < ai_min_x Then ai_min_x = li_x
		If li_y < ai_min_y Then ai_min_y = li_y
		If li_x + li_width > ai_max_x Then ai_max_x = li_x + li_width
		If li_y + li_height > ai_max_y Then ai_max_y = li_y + li_height
		
	End If
Next


Return 1

end function

protected function integer of_resize (integer ai_newwidth, integer ai_newheight);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Resize
//
//	Access:  		protected
//
//	Arguments:		
//	ai_newwidth		The new width of the parent object.
//	ai_newheight	The new height of the parent object.
//
//	Returns:  		integer
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//
//	Description:  	Moves or resizes objects that were registered with the service.
//						Performs the actions that were requested via the
//						of_SetOrigSize() and of_Register functions.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Changed to support for weighted movement and sizing of controls.
// 6.0	Changed to use new constants.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
//Note: For the line control: the width and height variables are
//										used to hold EndX and EndY attributes.
//////////////////////////////////////////////////////////////////////////////

//Temporary controls to get to attributes
dragobject		ldrg_cntrl
oval				loval_cntrl
line				lln_cntrl
rectangle		lrec_cntrl
roundrectangle	lrrec_cntrl

//Local variables
integer			li_upperbound
integer			li_cnt
integer			li_x, li_y, li_width, li_height
integer			li_deltawidth, li_deltaheight
real				lr_ratiowidth, lr_ratioheight
real				lr_move_deltax, lr_move_deltay
real				lr_resize_deltawidth, lr_resize_deltaheight

//Confirm that the user object has already been initialized
If il_parentprevheight=-1 And il_parentprevwidth=-1 Then
	Return -1
End If

//Check the parameters
If IsNull(ai_newwidth) or IsNull(ai_newheight) Then
	return -1
End If

//Prevent the contents of the windows from resizing past the min width/height
If ai_newwidth < il_parentminimumwidth   Then ai_newwidth = il_parentminimumwidth
If ai_newheight < il_parentminimumheight Then ai_newheight = il_parentminimumheight

//Set the deltas/ratios for the width and height as compared to the previous size
li_deltawidth  = ai_newwidth  - il_parentprevwidth 
li_deltaheight = ai_newheight - il_parentprevheight
If il_parentprevwidth=0 Then il_parentprevwidth=1
If il_parentprevheight=0 Then il_parentprevheight=1	
lr_ratiowidth  = ai_newwidth  / il_parentprevwidth
lr_ratioheight = ai_newheight / il_parentprevheight

//Only continue if the size has changed
If li_deltawidth=0 And li_deltaheight=0 Then Return 1

//Set the new previous size
il_parentprevwidth = ai_newwidth
il_parentprevheight = ai_newheight

///////////////////////////////////////////////////////////////////////////////////////////////
// Loop through all registered controls - Moving and resizing as appropriate
///////////////////////////////////////////////////////////////////////////////////////////////

//Loop trough all controls
li_upperbound = UpperBound (istr_registered[])
For li_cnt = 1 to li_upperbound
	
	//Initialize variables
	li_x = 0
	li_y = 0 
	li_width = 0
	li_height = 0
	lr_move_deltax = 0	
	lr_move_deltay = 0
	lr_resize_deltawidth = 0	
	lr_resize_deltaheight = 0	
	SetNull(ldrg_cntrl)
	SetNull(loval_cntrl)
	SetNull(lln_cntrl)
	SetNull(lrec_cntrl)
	SetNull(lrrec_cntrl)
	
	If IsValid(istr_registered[li_cnt].wo_control) Then
		
		//Get attribute information from the appropriate control
		Choose Case istr_registered[li_cnt].s_typeof
			Case DRAGOBJECT 
				ldrg_cntrl = istr_registered[li_cnt].wo_control
				li_x = ldrg_cntrl.X
				li_y = ldrg_cntrl.Y
				li_width = ldrg_cntrl.Width
				li_height = ldrg_cntrl.Height
			Case LINE
				// For the line control, the width and height variables 
				// are used to hold EndX and EndY attributes
				lln_cntrl = istr_registered[li_cnt].wo_control
				li_x = lln_cntrl.BeginX
				li_y = lln_cntrl.BeginY
				li_width = lln_cntrl.EndX
				li_height = lln_cntrl.EndY
			Case OVAL
				loval_cntrl = istr_registered[li_cnt].wo_control
				li_x = loval_cntrl.X
				li_y = loval_cntrl.Y
				li_width = loval_cntrl.Width
				li_height = loval_cntrl.Height		
			Case RECTANGLE
				lrec_cntrl = istr_registered[li_cnt].wo_control
				li_x = lrec_cntrl.X
				li_y = lrec_cntrl.Y
				li_width = lrec_cntrl.Width
				li_height = lrec_cntrl.Height
			Case ROUNDRECTANGLE
				lrrec_cntrl = istr_registered[li_cnt].wo_control			
				li_x = lrrec_cntrl.X
				li_y = lrrec_cntrl.Y
				li_width = lrrec_cntrl.Width
				li_height = lrrec_cntrl.Height				
			Case Else
				Return -1
		End Choose
		
		//Correct for any rounding or moving/resizing of objects trough
		//any other means
		If abs(istr_registered[li_cnt].r_x - li_x) > ii_rounding Then
			istr_registered[li_cnt].r_x = li_x
		End If				
		If abs(istr_registered[li_cnt].r_y - li_y) > ii_rounding Then
			istr_registered[li_cnt].r_y = li_y
		End If		
		If abs(istr_registered[li_cnt].r_width - li_width) > ii_rounding And &
		   li_width > istr_registered[li_cnt].i_widthmin Then
			istr_registered[li_cnt].r_width = li_width
		End If							
		If abs(istr_registered[li_cnt].r_height - li_height) > ii_rounding And &
		   li_height > istr_registered[li_cnt].i_heightmin Then
			istr_registered[li_cnt].r_height = li_height
		End If			
		
		//Define the deltas for this control:  Move and Resize
		If istr_registered[li_cnt].b_scale Then
			lr_move_deltax = (istr_registered[li_cnt].r_x * lr_ratiowidth) - istr_registered[li_cnt].r_x
			lr_move_deltay = (istr_registered[li_cnt].r_y * lr_ratioheight) - istr_registered[li_cnt].r_y
			lr_resize_deltawidth = (istr_registered[li_cnt].r_width * lr_ratiowidth) - istr_registered[li_cnt].r_width
			lr_resize_deltaheight = (istr_registered[li_cnt].r_height * lr_ratioheight) - istr_registered[li_cnt].r_height
		Else
			// Prevent the weighted value from being overriden.
			If istr_registered[li_cnt].b_movex And istr_registered[li_cnt].i_movex = 0 Then
				istr_registered[li_cnt].i_movex = 100
			End If
			If istr_registered[li_cnt].b_movey And istr_registered[li_cnt].i_movey = 0 Then
				istr_registered[li_cnt].i_movey = 100
			End If
			If istr_registered[li_cnt].b_scalewidth And istr_registered[li_cnt].i_scalewidth=0 Then
				istr_registered[li_cnt].i_scalewidth = 100
			End If
			If istr_registered[li_cnt].b_scaleheight And istr_registered[li_cnt].i_scaleheight=0 Then
				istr_registered[li_cnt].i_scaleheight = 100
			End If			
			
			// Support for weighted movement and sizing of controls.
			If istr_registered[li_cnt].b_movex Then 
				lr_move_deltax = li_deltawidth * istr_registered[li_cnt].i_movex / 100
			End If
			If istr_registered[li_cnt].b_movey Then 
				lr_move_deltay = li_deltaheight * istr_registered[li_cnt].i_movey / 100
			End If
			If istr_registered[li_cnt].b_scalewidth Then 
				lr_resize_deltawidth = li_deltawidth * istr_registered[li_cnt].i_scalewidth / 100
			End If
			If istr_registered[li_cnt].b_scaleheight Then 
				lr_resize_deltaheight = li_deltaheight * istr_registered[li_cnt].i_scaleheight /100
			End If
		End If

		//If appropriate move the control along the X and Y attribute.
		If lr_move_deltax <> 0 Or lr_move_deltay <> 0 Then	
			//Save the 'exact' X and Y attributes.
			istr_registered[li_cnt].r_x = istr_registered[li_cnt].r_x + lr_move_deltax		
			istr_registered[li_cnt].r_y = istr_registered[li_cnt].r_y + lr_move_deltay
			Choose Case istr_registered[li_cnt].s_typeof
				Case DRAGOBJECT 
					ldrg_cntrl.Move (istr_registered[li_cnt].r_x, istr_registered[li_cnt].r_y)
				Case LINE
					//X moving
					lln_cntrl.BeginX = istr_registered[li_cnt].r_x
					istr_registered[li_cnt].r_width = istr_registered[li_cnt].r_width + lr_move_deltax					
					lln_cntrl.EndX = istr_registered[li_cnt].r_width
					//Y moving
					lln_cntrl.BeginY = istr_registered[li_cnt].r_y
					istr_registered[li_cnt].r_height = istr_registered[li_cnt].r_height + lr_move_deltay
					lln_cntrl.EndY = istr_registered[li_cnt].r_height					
				Case OVAL
					loval_cntrl.Move (istr_registered[li_cnt].r_x, istr_registered[li_cnt].r_y)					
				Case RECTANGLE
					lrec_cntrl.Move (istr_registered[li_cnt].r_x, istr_registered[li_cnt].r_y)
				Case ROUNDRECTANGLE
					lrrec_cntrl.Move (istr_registered[li_cnt].r_x, istr_registered[li_cnt].r_y)
			End Choose	
		End If /* Move */
		
		//If appropriate Resize the Width And Height of the control.
		//Performing one Resize instead of changing Width and Height individually.
		If lr_resize_deltawidth <> 0 Or lr_resize_deltaheight <> 0 Then		
			//Save the 'exact' Width and Height attributes.
			istr_registered[li_cnt].r_width = istr_registered[li_cnt].r_width + lr_resize_deltawidth	
			istr_registered[li_cnt].r_height = istr_registered[li_cnt].r_height + lr_resize_deltaheight		
			Choose Case istr_registered[li_cnt].s_typeof
				Case DRAGOBJECT 
					ldrg_cntrl.Resize (istr_registered[li_cnt].r_width, istr_registered[li_cnt].r_height)
					li_width = ldrg_cntrl.Width
					li_height = ldrg_cntrl.Height
				Case LINE
					lln_cntrl.EndX = istr_registered[li_cnt].r_width
				Case OVAL
					loval_cntrl.Resize (istr_registered[li_cnt].r_width, istr_registered[li_cnt].r_height)
					li_width = loval_cntrl.Width
					li_height = loval_cntrl.Height					
				Case RECTANGLE
					lrec_cntrl.Resize (istr_registered[li_cnt].r_width, istr_registered[li_cnt].r_height)
					li_width = lrec_cntrl.Width
					li_height = lrec_cntrl.Height				
				Case ROUNDRECTANGLE
					lrrec_cntrl.Resize (istr_registered[li_cnt].r_width, istr_registered[li_cnt].r_height)
					li_width = lrrec_cntrl.Width
					li_height = lrrec_cntrl.Height					
			End Choose		
			
			//Determine if the object does not support the requested Width or Height.
			//Used to determine if the object was resized by any other means.
			If li_width > istr_registered[li_cnt].r_width Then
				istr_registered[li_cnt].i_widthmin = li_width
			Else
				istr_registered[li_cnt].i_widthmin = 0
			End If
			If li_height > istr_registered[li_cnt].r_height Then
				istr_registered[li_cnt].i_heightmin = li_height
			Else
				istr_registered[li_cnt].i_heightmin = 0
			End If					
		End If /* Resize */

	End If /* If IsValid(istr_registered[li_cnt].wo_control) Then */
Next /* For li_cnt = 1 to li_upperbound */

Return 1

end function

protected function integer of_register (windowobject awo_control, boolean ab_scale, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Register
//
//	Access:  		public
//
//	Arguments:		
//	 awo_control		The window object being registered.
//  ab_scale			If the object should be registered as a Scale type.
//  ai_movex			The percentage to move the object along the x axis.
//  ai_movey			The percentage to move the object along the y axis.
//  ai_scalewidth 	The percentage to scale the object along the x axis.
//  ai_scaleheight	The percentage to scale the object along the y axis.
//
//	Returns:  		integer
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//
//	Description:  	Register a control which needs to either be moved or resized
//						when the parent object is resized.  The action taken on this
//						control depends on the four attributes: ai_movex, ai ai_movey,
//						ai_scalewidth, ai_scaleheight.
//						Note: the service object needs to be initialized (of_SetOrigSize())
//						prior to	any registering (this function) of objects.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0    Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

dragobject		ldrg_cntrl
oval				loval_cntrl
line				ln_cntrl
rectangle		lrec_cntrl
roundrectangle	lrrec_cntrl

integer			li_x, li_y, li_width, li_height
integer			li_upperbound
integer			li_cnt
integer			li_slot_available
boolean			lb_movex=False, lb_movey=False
boolean			lb_scalewidth=False, lb_scaleheight=False

//Check parameters
If IsNull(awo_control) or Not IsValid(awo_control) or &
	IsNull(ab_scale) or &
	IsNull(ai_movex) or ai_movex<0 or ai_movex>100 or &
	IsNull(ai_movey) or ai_movey<0 or ai_movey>100 or &
	IsNull(ai_scalewidth) or ai_scalewidth<0 or ai_scalewidth>100 or & 
	IsNull(ai_scaleheight) or ai_scaleheight<0 or ai_scaleheight>100 Then
	Return -1
End If

//Translate parameteters.
If ab_scale Then
	ai_movex = 0
	ai_movey = 0
	ai_scalewidth = 0
	ai_scaleheight = 0
End If
lb_movex = (ai_movex > 0)
lb_movey = (ai_movey > 0)
lb_scalewidth = (ai_scalewidth > 0)
lb_scaleheight = (ai_scaleheight > 0)

//Confirm that the user object has already been initialized
If il_parentprevheight=-1 And il_parentprevwidth=-1 Then
	Return -1
End If

//Get the previous Bound
li_upperbound = UpperBound (istr_registered[])

//Determine if there is an open slot available other than a
//new entry on the array
li_slot_available = 0
For li_cnt = 1 to li_upperbound
	If IsNull(istr_registered[li_cnt].wo_control) Or &
		Not IsValid(istr_registered[li_cnt].wo_control) Then
		If li_slot_available = 0 Then
			//Get the first slot found
			li_slot_available = li_cnt
		End If
	Else
		//Check if control has already been registered
		If istr_registered[li_cnt].wo_control = awo_control Then
			Return -1
		End If
	End If
Next

//If an available slot was not found then create a new entry
If li_slot_available = 0 Then
	li_slot_available = li_upperbound + 1
End If

///////////////////////////////////////////////////////////////////////////////////////
//Register the new object
///////////////////////////////////////////////////////////////////////////////////////

//Validate and set typeof value
Choose Case of_TypeOf(awo_control)
	Case DRAGOBJECT
		//Store a reference to the control
		ldrg_cntrl = awo_control
		//Store the type of the control to speed access to its attributes
		istr_registered[li_slot_available].s_typeof = DRAGOBJECT		
		//Store the position and size of control
		li_x = ldrg_cntrl.X
		li_y = ldrg_cntrl.Y
		li_width = ldrg_cntrl.Width
		li_height = ldrg_cntrl.Height
	Case LINE
		ln_cntrl = awo_control
		istr_registered[li_slot_available].s_typeof = LINE		
		li_x = ln_cntrl.BeginX
		li_y = ln_cntrl.BeginY
		li_width = ln_cntrl.EndX
		li_height = ln_cntrl.EndY
	Case OVAL
		loval_cntrl = awo_control
		istr_registered[li_slot_available].s_typeof = OVAL			
		li_x = loval_cntrl.X
		li_y = loval_cntrl.Y
		li_width = loval_cntrl.Width
		li_height = loval_cntrl.Height		
	Case RECTANGLE
		lrec_cntrl = awo_control
		istr_registered[li_slot_available].s_typeof = RECTANGLE		
		li_x = lrec_cntrl.X
		li_y = lrec_cntrl.Y
		li_width = lrec_cntrl.Width
		li_height = lrec_cntrl.Height		
	Case ROUNDRECTANGLE
		lrrec_cntrl = awo_control
		istr_registered[li_slot_available].s_typeof = ROUNDRECTANGLE				
		li_x = lrrec_cntrl.X
		li_y = lrrec_cntrl.Y
		li_width = lrrec_cntrl.Width
		li_height = lrrec_cntrl.Height		
	Case Else
		//An unknown control type has been encountered
		Return -1
End Choose

//Register the actual object
istr_registered[li_slot_available].wo_control = awo_control
istr_registered[li_slot_available].s_classname = awo_control.ClassName()

//Set the behavior attributes
istr_registered[li_slot_available].b_movex = lb_movex
istr_registered[li_slot_available].i_movex = ai_movex
istr_registered[li_slot_available].b_movey = lb_movey
istr_registered[li_slot_available].i_movey = ai_movey
istr_registered[li_slot_available].b_scalewidth = lb_scalewidth
istr_registered[li_slot_available].i_scalewidth = ai_scalewidth
istr_registered[li_slot_available].b_scaleheight = lb_scaleheight
istr_registered[li_slot_available].i_scaleheight = ai_scaleheight
istr_registered[li_slot_available].b_scale = ab_scale

//Set the initial position/size attributes
istr_registered[li_slot_available].r_x = li_x
istr_registered[li_slot_available].r_y = li_y
istr_registered[li_slot_available].r_width = li_width
istr_registered[li_slot_available].r_height = li_height

Return 1

end function

public function integer of_register (windowobject awo_control, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Register
//
//	Access:  		public
//
//	Arguments:		
//	 awo_control		The window object being registered.
//  ai_movex			The percentage to move the object along the x axis.
//  ai_movey			The percentage to move the object along the y axis.
//  ai_scalewidth 	The percentage to scale the object along the x axis.
//  ai_scaleheight	The percentage to scale the object along the y axis.
//
//	Returns:  		integer
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//
//	Description:  	Register a control which needs to either be moved or resized
//						when the parent object is resized.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0    Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

boolean 		lb_scale=False

Return of_Register (awo_control, lb_scale, ai_movex, ai_movey, &
		ai_scalewidth, ai_scaleheight)

end function

on n_pbunit_windowresizeservice.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_pbunit_windowresizeservice.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_n_cst_resize
//
//	Description:
//	Resize service.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version - Claudio J. Quant
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
end event

