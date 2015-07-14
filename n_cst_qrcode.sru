HA$PBExportHeader$n_cst_qrcode.sru
forward
global type n_cst_qrcode from nonvisualobject
end type
end forward

global type n_cst_qrcode from nonvisualobject
end type
global n_cst_qrcode n_cst_qrcode

type variables
private:

long				il_version
s_qr_rectangle	istra_blockedModules[]

public:

s_bitarray		istra_moduleMatrix[]
end variables

forward prototypes
public subroutine of_placefinderpatterns ()
public subroutine of_reserveseperatorareas ()
public subroutine of_placetimingpatterns ()
public subroutine of_placedarkmodule ()
public subroutine of_reserveversionareas ()
public subroutine of_placealignmentpatterns (s_point astra_alignment[])
public function boolean of_intersects (s_qr_rectangle astr_rectangle1, s_qr_rectangle astr_rectangle2)
public subroutine of_placedatawords (string as_interleavedata)
public function boolean of_isblocked (s_qr_rectangle astr_rectangle, s_qr_rectangle astra_rectangle[])
public function boolean of_pattern (long al_index, long al_x, long al_y)
public function long of_maskcode ()
public subroutine of_init (long al_version)
public subroutine of_setmodulmatrixvalue (long al_x, long al_y, boolean ab_flag)
public function boolean of_xor (boolean ab_a, boolean ab_b)
public function boolean of_getmodulmatrixvalue (long al_x, long al_y)
public function long of_score (n_cst_qrcode anv_qrcode)
public function string of_dectobin (long al_dec, long al_padleftupto)
public function string of_trimstart (string as_trim, character ac_trimchar)
protected function long of_bitwisexor (long al_value1, long al_value2)
public function boolean of_getbit (long al_decimal, unsignedinteger ai_bit)
public function string of_getformatstring (character ac_ecclevel, long al_maskversion)
public subroutine of_init (long al_version, string as_interleavedata, s_point astra_alignmentpatternlocations[], character ac_ecclevel)
public subroutine of_placeformat (string as_formatstring)
public function string of_getversionstring (long al_version)
public subroutine of_placeversion (string as_versionstring)
public subroutine of_addquietzone ()
public function long of_getmodulmatrix (ref s_bitarray rstra_modulematrix[])
end prototypes

public subroutine of_placefinderpatterns ();long				ll_size, ll_index, ll_x, ll_y
long				lla_locations[]
s_qr_rectangle	lstr_rectangle, lstr_empty

ll_size = upperBound(istra_moduleMatrix)

lla_locations[1] = 0
lla_locations[2] = 0
lla_locations[3] = ll_size -7
lla_locations[4] = 0
lla_locations[5] = 0
lla_locations[6] = ll_size -7					 

for ll_index = 0 to 5 step 2
	for ll_x = 0 to 6
		for ll_y = 0 to 6
			if not (((ll_x = 1 or ll_x = 5) and ll_y > 0 and ll_y < 6) or (ll_x > 0 and ll_x < 6 and (ll_y = 1 or ll_y = 5))) then
				istra_moduleMatrix[ll_y + lla_locations[ll_index +2] +1].bits[ll_x + lla_locations[ll_index+1] +1] = true
			end if
		next
	next
	lstr_rectangle = lstr_empty
	lstr_rectangle.x = lla_locations[ll_index+1]
	lstr_rectangle.y = lla_locations[ll_index+2]
	lstr_rectangle.width = 7
	lstr_rectangle.height = 7
	istra_blockedModules[upperBound(istra_blockedModules) +1] = lstr_rectangle
next
end subroutine

public subroutine of_reserveseperatorareas ();long					ll_index, ll_size
s_qr_rectangle 	lstr_rectangle, lstr_empty

ll_size = upperBound(istra_moduleMatrix)
ll_index = upperBound(istra_blockedModules)

ll_index++
lstr_rectangle = lstr_empty
lstr_rectangle.x = 7
lstr_rectangle.y = 0
lstr_rectangle.width = 1
lstr_rectangle.height = 8
istra_blockedModules[ll_index] = lstr_rectangle

ll_index++
lstr_rectangle = lstr_empty
lstr_rectangle.x = 0
lstr_rectangle.y = 7
lstr_rectangle.width = 7
lstr_rectangle.height = 1
istra_blockedModules[ll_index] = lstr_rectangle

ll_index++
lstr_rectangle = lstr_empty
lstr_rectangle.x = 0
lstr_rectangle.y = ll_size -8
lstr_rectangle.width = 8
lstr_rectangle.height = 1
istra_blockedModules[ll_index] = lstr_rectangle

ll_index++
lstr_rectangle = lstr_empty
lstr_rectangle.x = 7
lstr_rectangle.y = ll_size -7
lstr_rectangle.width = 1
lstr_rectangle.height = 7
istra_blockedModules[ll_index] = lstr_rectangle

ll_index++
lstr_rectangle = lstr_empty
lstr_rectangle.x = ll_size -8
lstr_rectangle.y = 0
lstr_rectangle.width = 1
lstr_rectangle.height = 8
istra_blockedModules[ll_index] = lstr_rectangle

ll_index++
lstr_rectangle = lstr_empty
lstr_rectangle.x = ll_size -7
lstr_rectangle.y = 7
lstr_rectangle.width = 7
lstr_rectangle.height = 1
istra_blockedModules[ll_index] = lstr_rectangle
end subroutine

public subroutine of_placetimingpatterns ();long 				ll_size, ll_index
s_qr_rectangle	lstr_rectangle, lstr_empty

ll_size = upperBound(istra_moduleMatrix)
for ll_index = 8 to (ll_size -8)
	if mod(ll_index, 2) = 0 then
		istra_moduleMatrix[7].bits[ll_index+1] = true
		istra_moduleMatrix[ll_index+1].bits[7] = true
	end if
next

lstr_rectangle = lstr_empty
lstr_rectangle.x = 6
lstr_rectangle.y = 8
lstr_rectangle.width = 1
lstr_rectangle.height = ll_size -16
istra_blockedModules[upperBound(istra_blockedModules) +1] = lstr_rectangle

lstr_rectangle = lstr_empty
lstr_rectangle.x = 8
lstr_rectangle.y = 6
lstr_rectangle.width = ll_size -16
lstr_rectangle.height = 1
istra_blockedModules[upperBound(istra_blockedModules) +1] = lstr_rectangle	
end subroutine

public subroutine of_placedarkmodule ();s_qr_rectangle	lstr_rectangle

istra_moduleMatrix[(4 * il_version) + 10].bits[9] = true

lstr_rectangle.x = 8
lstr_rectangle.y = 4 * il_version + 9
lstr_rectangle.width = 1
lstr_rectangle.height = 1
istra_blockedModules[upperBound(istra_blockedModules) +1] = lstr_rectangle
end subroutine

public subroutine of_reserveversionareas ();long				ll_index, ll_size
s_qr_rectangle	lstr_rectangle, lstr_empty

ll_size = upperBound(istra_moduleMatrix)
ll_index = upperBound(istra_blockedModules)

ll_index++
lstr_rectangle = lstr_empty
lstr_rectangle.x = 8
lstr_rectangle.y = 0
lstr_rectangle.width = 1
lstr_rectangle.height = 6
istra_blockedModules[ll_index] = lstr_rectangle

ll_index++
lstr_rectangle = lstr_empty
lstr_rectangle.x = 8
lstr_rectangle.y = 7
lstr_rectangle.width = 1
lstr_rectangle.height = 1
istra_blockedModules[ll_index] = lstr_rectangle

ll_index++
lstr_rectangle = lstr_empty
lstr_rectangle.x = 0
lstr_rectangle.y = 8
lstr_rectangle.width = 6
lstr_rectangle.height = 1
istra_blockedModules[ll_index] = lstr_rectangle

ll_index++
lstr_rectangle = lstr_empty
lstr_rectangle.x = 7
lstr_rectangle.y = 8
lstr_rectangle.width = 2
lstr_rectangle.height = 1
istra_blockedModules[ll_index] = lstr_rectangle

ll_index++
lstr_rectangle = lstr_empty
lstr_rectangle.x = ll_size -8
lstr_rectangle.y = 8
lstr_rectangle.width = 8
lstr_rectangle.height = 1
istra_blockedModules[ll_index] = lstr_rectangle

ll_index++
lstr_rectangle = lstr_empty
lstr_rectangle.x = 8
lstr_rectangle.y = ll_size -7
lstr_rectangle.width = 1
lstr_rectangle.height = 7
istra_blockedModules[ll_index] = lstr_rectangle
                
if il_version >= 7 then
	
	ll_index++
	lstr_rectangle = lstr_empty
	lstr_rectangle.x = ll_size -11
	lstr_rectangle.y = 0
	lstr_rectangle.width = 3
	lstr_rectangle.height = 6
	istra_blockedModules[ll_index] = lstr_rectangle
	
	ll_index++
	lstr_rectangle = lstr_empty
	lstr_rectangle.x = 0
	lstr_rectangle.y = ll_size -11
	lstr_rectangle.width = 6
	lstr_rectangle.height = 3
	istra_blockedModules[ll_index] = lstr_rectangle
end if

end subroutine

public subroutine of_placealignmentpatterns (s_point astra_alignment[]);long 				ll_index, ll_count, ll_index2, ll_count2, ll_x, ll_y
boolean			lb_blocked
s_qr_rectangle	lstr_rectangle, lstr_rectangle2, lstr_empty

ll_count = upperBound(astra_alignment)
for ll_index = 1 to ll_count
	
	lb_blocked = false
	lstr_rectangle = lstr_empty
	lstr_rectangle.x = astra_alignment[ll_index].x
	lstr_rectangle.y = astra_alignment[ll_index].y
	lstr_rectangle.width = 5
	lstr_rectangle.height = 5
	
	ll_count2 = upperBound(istra_blockedModules)
	for ll_index2 = 1 to ll_count2
		if of_intersects(lstr_rectangle, istra_blockedModules[ll_index2]) then
			lb_blocked = true
			exit
		end if
	next
	
	if lb_blocked then continue
	
	for ll_x = 0 to 4
		for ll_y = 0 to 4
			if (ll_y = 0 or ll_y = 4 or ll_x = 0 or ll_x = 4 or (ll_x = 2 and ll_y = 2)) then			
				istra_moduleMatrix[astra_alignment[ll_index].y + ll_y +1].bits[astra_alignment[ll_index].x + ll_x +1] = true;
			end if
		next
	next
	
	lstr_rectangle2 = lstr_empty
	lstr_rectangle2.x = astra_alignment[ll_index].x
	lstr_rectangle2.y = astra_alignment[ll_index].y
	lstr_rectangle2.width = 5
	lstr_rectangle2.height = 5
	istra_blockedModules[upperBound(istra_blockedModules) +1] = lstr_rectangle2
next
end subroutine

public function boolean of_intersects (s_qr_rectangle astr_rectangle1, s_qr_rectangle astr_rectangle2);return &
	astr_rectangle2.X < astr_rectangle1.X + astr_rectangle1.Width and &
	astr_rectangle1.X < astr_rectangle2.X + astr_rectangle2.Width and &
	astr_rectangle2.Y < astr_rectangle1.Y + astr_rectangle1.Height and &
	astr_rectangle1.Y < astr_rectangle2.Y + astr_rectangle2.Height
end function

public subroutine of_placedatawords (string as_interleavedata);long				ll_size, ll_len, ll_index, ll_x, ll_y, ll_yMod, ll_dataWordPointer = 1
boolean			lb_up = true, lba_datawords[]
s_qr_rectangle	lstr_rectangle, lstr_empty

ll_len = len(as_interleavedata)
for ll_index = ll_len to 1 step -1
	lba_datawords[ll_index] = mid(as_interleavedata, ll_index, 1) = "1"
next

ll_size = upperBound(istra_moduleMatrix)
for ll_x = (ll_size -1) to 0 step -2
	if ll_x = 7 or ll_x = 6 then
		ll_x = 5
	end if
	
	for ll_yMod = 1 to ll_size		
		ll_y = 0
		if lb_up then
			ll_y = ll_size - ll_yMod
			
			lstr_rectangle = lstr_empty
			lstr_rectangle.x = ll_x
			lstr_rectangle.y = ll_y
			lstr_rectangle.width = 1
			lstr_rectangle.height = 1
			
			if ll_dataWordPointer <= ll_len and (not of_isBlocked(lstr_rectangle, istra_blockedModules)) then
				istra_moduleMatrix[ll_y+1].bits[ll_x+1] = lba_dataWords[ll_dataWordPointer]
				ll_dataWordPointer++
			end if
			
			lstr_rectangle = lstr_empty
			lstr_rectangle.x = ll_x -1
			lstr_rectangle.y = ll_y
			lstr_rectangle.width = 1
			lstr_rectangle.height = 1
			
			if ll_dataWordPointer <= ll_len and ll_x > 0 and (not of_isBlocked(lstr_rectangle, istra_blockedModules)) then
				istra_moduleMatrix[ll_y+1].bits[ll_x] = lba_dataWords[ll_dataWordPointer]
				ll_dataWordPointer++
			end if
		else
			ll_y = ll_yMod -1
			
			lstr_rectangle = lstr_empty
			lstr_rectangle.x = ll_x
			lstr_rectangle.y = ll_y
			lstr_rectangle.width = 1
			lstr_rectangle.height = 1
			
			if ll_dataWordPointer <= ll_len and (not of_isBlocked(lstr_rectangle, istra_blockedModules)) then
				istra_moduleMatrix[ll_y+1].bits[ll_x+1] = lba_dataWords[ll_dataWordPointer]
				ll_dataWordPointer++
			end if
			
			lstr_rectangle = lstr_empty
			lstr_rectangle.x = ll_x -1
			lstr_rectangle.y = ll_y
			lstr_rectangle.width = 1
			lstr_rectangle.height = 1
			
			if ll_dataWordPointer <= ll_len and ll_x > 0 and (not of_isBlocked(lstr_rectangle, istra_blockedModules)) then
				istra_moduleMatrix[ll_y+1].bits[ll_x] = lba_dataWords[ll_dataWordPointer]
				ll_dataWordPointer++
			end if
		end if
	next
	
	lb_up = not lb_up
next
end subroutine

public function boolean of_isblocked (s_qr_rectangle astr_rectangle, s_qr_rectangle astra_rectangle[]);long		ll_index, ll_count
boolean	lb_blocked = false

ll_count = upperBound(astra_rectangle)
for ll_index = 1 to ll_count
	if of_intersects(astra_rectangle[ll_index], astr_rectangle) then
		lb_blocked = true
	end if
next

return lb_blocked
end function

public function boolean of_pattern (long al_index, long al_x, long al_y);boolean	lb_null

setNull(lb_null)

if al_index < 1 or al_index > 8 then return lb_null

choose case al_index
	case 1
		return mod((al_x + al_y), 2) = 0
	case 2
		return mod(al_y, 2) = 0
	case 3
		return mod(al_y, 3) = 0
	case 4
		return mod(al_x + al_y, 3) = 0
	case 5
		return mod(long(al_y / 2) + long(al_x / 3), 2) = 0
	case 6
		return (mod(al_x * al_y, 2) + mod(al_x * al_y, 3)) = 0
	case 7
		return mod(mod(al_x * al_y, 2) + mod(al_x * al_y, 3), 2) = 0
	case 8
		return mod(mod(al_x + al_y, 2) + mod(al_x * al_y, 3), 2) = 0
end choose

return lb_null

end function

public function long of_maskcode ();long				ll_resultPatternScore = 0, ll_size, ll_patternIndex, ll_y, ll_x, ll_score
long				ll_resultPatternIndex = -1
boolean			lb_temp
n_cst_qrcode	lnv_qrcodeTemp
s_qr_rectangle	lstr_rectangle, lstr_empty

ll_size = upperBound(istra_moduleMatrix)
for ll_patternIndex = 1 to 8
	lnv_qrcodeTemp = create n_cst_qrcode
	lnv_qrcodeTemp.of_init(il_version)
	for ll_y = 1 to ll_size
		for ll_x = 1 to ll_size
			lnv_qrcodeTemp.of_setModulMatrixValue(ll_y, ll_x, istra_moduleMatrix[ll_x].bits[ll_y])
		next
	next
	
	for ll_x = 1 to ll_size
		for ll_y = 1 to ll_size
			lstr_rectangle = lstr_empty
			lstr_rectangle.x = ll_x -1
			lstr_rectangle.y = ll_y -1
			lstr_rectangle.width = 1
			lstr_rectangle.height = 1
			
			if not of_isBlocked(lstr_rectangle, istra_blockedModules) then
				lb_temp = lnv_qrcodeTemp.of_getModulMatrixValue(ll_y, ll_x)
				lnv_qrcodeTemp.of_setModulMatrixValue(ll_y, ll_x, of_xor(lb_temp, of_pattern(ll_patternIndex, ll_x -1, ll_y -1)))
			end if
		next
	next
	
	ll_score = of_score(lnv_qrcodeTemp)
	if ll_resultPatternIndex < 0 or ll_resultPatternScore > ll_score then
		ll_resultPatternIndex = ll_patternIndex
		ll_resultPatternScore = ll_score
	end if
next

for ll_x = 1 to ll_size
	for ll_y = 1 to ll_size
		lstr_rectangle = lstr_empty
		lstr_rectangle.x = ll_x -1
		lstr_rectangle.y = ll_y -1
		lstr_rectangle.width = 1
		lstr_rectangle.height = 1
		
		if not of_isBlocked(lstr_rectangle, istra_blockedModules) then
			istra_moduleMatrix[ll_y].bits[ll_x] = of_xor(istra_moduleMatrix[ll_y].bits[ll_x], of_pattern(ll_resultPatternIndex, ll_x -1, ll_y -1))
		end if
	next
next

return ll_resultPatternIndex -1
end function

public subroutine of_init (long al_version);long	ll_size, ll_index

s_bitarray	lstr_empty

il_version = al_version

ll_size = 21 + (il_version - 1) * 4
istra_moduleMatrix[ll_size] = lstr_empty
for ll_index = 1 to ll_size
	istra_moduleMatrix[ll_index].bits[ll_size] = false
next
end subroutine

public subroutine of_setmodulmatrixvalue (long al_x, long al_y, boolean ab_flag);istra_moduleMatrix[al_x].bits[al_y] = ab_flag
end subroutine

public function boolean of_xor (boolean ab_a, boolean ab_b);if ab_a and ab_b then
	return false
end if

if (not ab_a) and (not ab_b) then
	return false
end if

return true
end function

public function boolean of_getmodulmatrixvalue (long al_x, long al_y);return istra_moduleMatrix[al_x].bits[al_y]
end function

public function long of_score (n_cst_qrcode anv_qrcode);long		ll_score = 0, ll_size, ll_y, ll_modInRow, ll_modInColumn, ll_x
long		ll_blackModules, ll_row, ll_bit, ll_percent
boolean	lb_lastValRow, lb_lastValColumn

ll_size = upperBound(anv_qrcode.istra_moduleMatrix)
for ll_y = 1 to ll_size
	ll_modInRow = 0
	ll_modInColumn = 0
	lb_lastValRow = anv_qrcode.istra_moduleMatrix[ll_y].bits[1]
	lb_lastValColumn = anv_qrcode.istra_moduleMatrix[1].bits[ll_y]
	
	// Penalty 1
	for ll_x = 1 to ll_size
		if anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x] = lb_lastValRow then
			ll_modInRow++
		else
			ll_modInRow = 1
		end if
		
		if ll_modInRow = 5 then
			ll_score += 3
		elseif ll_modInRow > 5 then
			ll_score++
		end if
		
		lb_lastValRow = anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x]
		
		if anv_qrcode.istra_moduleMatrix[ll_x].bits[ll_y] = lb_lastValColumn then
			ll_modInColumn++
		else
			ll_modInColumn = 1
		end if
		
		if ll_modInColumn = 5 then
			ll_score += 3
		elseif ll_modInColumn > 5 then
			ll_score++
		end if
		
		lb_lastValColumn = anv_qrcode.istra_moduleMatrix[ll_x].bits[ll_y]
	next
	
	// Workaround: No idea why, but this is needed to prevent of adding an additional row
	if ll_y = ll_size then exit
next
	
// Penalty 2
for ll_y = 1 to ll_size -1
	for ll_x = 1 to ll_size -1
		if anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x] = anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +1] and &
			anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x] = anv_qrcode.istra_moduleMatrix[ll_y +1].bits[ll_x] and &
			anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x] = anv_qrcode.istra_moduleMatrix[ll_y +1].bits[ll_x +1] then
			ll_score += 3
		end if
	next
next

// Penalty 3
for ll_y = 1 to ll_size
	for ll_x = 1 to ll_size -10
		if (anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x] and &
			(not anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +1]) and &
			anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +2] and &
			anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +3] and &
			anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +4] and &
			(not anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +5]) and &
			anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +6] and &
			(not anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +7]) and &
			(not anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +8]) and &
			(not anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +9]) and &
			(not anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +10])) or &
			((not anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x]) and &
			(not anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +1]) and &
			(not anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +2]) and &
			(not anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +3]) and &
			anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +4] and &
			(not anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +5]) and &
			anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +6] and &
			anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +7] and &
			anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +8] and &
			(not anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +9]) and &
			anv_qrcode.istra_moduleMatrix[ll_y].bits[ll_x +10]) then
			
			ll_score += 40
		end if
		
		if (anv_qrcode.istra_moduleMatrix[ll_x].bits[ll_y] and &
			(not anv_qrcode.istra_moduleMatrix[ll_x +1].bits[ll_y]) and &
			anv_qrcode.istra_moduleMatrix[ll_x +2].bits[ll_y] and &
			anv_qrcode.istra_moduleMatrix[ll_x +3].bits[ll_y] and &
			anv_qrcode.istra_moduleMatrix[ll_x +4].bits[ll_y] and &
			(not anv_qrcode.istra_moduleMatrix[ll_x +5].bits[ll_y]) and &
			anv_qrcode.istra_moduleMatrix[ll_x +6].bits[ll_y] and &
			(not anv_qrcode.istra_moduleMatrix[ll_x +7].bits[ll_y]) and &
			(not anv_qrcode.istra_moduleMatrix[ll_x +8].bits[ll_y]) and &
			(not anv_qrcode.istra_moduleMatrix[ll_x +9].bits[ll_y]) and &
			(not anv_qrcode.istra_moduleMatrix[ll_x +10].bits[ll_y])) or &
			((not anv_qrcode.istra_moduleMatrix[ll_x].bits[ll_y]) and &
			(not anv_qrcode.istra_moduleMatrix[ll_x +1].bits[ll_y]) and &
			(not anv_qrcode.istra_moduleMatrix[ll_x +2].bits[ll_y]) and &
			(not anv_qrcode.istra_moduleMatrix[ll_x +3].bits[ll_y]) and &
			anv_qrcode.istra_moduleMatrix[ll_x +4].bits[ll_y] and &
			(not anv_qrcode.istra_moduleMatrix[ll_x +5].bits[ll_y]) and &
			anv_qrcode.istra_moduleMatrix[ll_x +6].bits[ll_y] and &
			anv_qrcode.istra_moduleMatrix[ll_x +7].bits[ll_y] and &
			anv_qrcode.istra_moduleMatrix[ll_x +8].bits[ll_y] and &
			(not anv_qrcode.istra_moduleMatrix[ll_x +9].bits[ll_y]) and &
			anv_qrcode.istra_moduleMatrix[ll_x +10].bits[ll_y]) then
			
			ll_score += 40
		end if
	next
	
	// Workaround: No idea why, but this is needed to prevent of adding an additional row
	if ll_y = ll_size then exit
next
	
//Penalty 4
ll_blackModules = 0
for ll_row = 1 to upperBound(anv_qrcode.istra_moduleMatrix)
	for ll_bit = 1 to upperBound(anv_qrcode.istra_moduleMatrix[ll_row].bits)
		if anv_qrcode.istra_moduleMatrix[ll_row].bits[ll_bit] then
			ll_blackModules++
		end if
	next
next

ll_percent = long(dec(ll_blackModules) / (upperBound(anv_qrcode.istra_moduleMatrix) ^2) * 100)
if mod(ll_percent, 5) = 0 then
	ll_score += min(abs((ll_percent -55) / 5), (abs((ll_percent -45) / 5)) * 10)
else
	ll_score += min(abs((truncate(ll_percent / 5, 0) -50) / 5), (abs((truncate(ll_percent / 5, 0) + 5) -50) / 5)) * 10
end if

return ll_score



end function

public function string of_dectobin (long al_dec, long al_padleftupto);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Converts a decimal number to a binary string
// 
// Author: 
// B.Kemner, 26.06.2015 
// 

long 		ll_dec, ll_pad, ll_padCount
string	ls_binString

ll_dec = al_dec
do while ll_dec > 0
	ls_binString = string(mod(ll_dec, 2)) + ls_binString
	ll_dec /= 2
loop

if al_padLeftUpTo > 0 and al_padLeftUpTo > len(ls_binString) then
	ll_padCount = al_padLeftUpTo - len(ls_binString)
	for ll_pad = 1 to ll_padCount
		ls_binString = "0" + ls_binString
	next
end if

return ls_binString
end function

public function string of_trimstart (string as_trim, character ac_trimchar);long ll_index, ll_len, ll_mid = 1

ll_len = len(as_trim)
for ll_index = 1 to ll_len
	if mid(as_trim, ll_index, 1) = ac_trimchar then
		ll_mid++
	else
		exit
	end if
next

if ll_mid > 1 then
	return mid(as_trim, ll_mid)
else
	return as_trim
end if




end function

protected function long of_bitwisexor (long al_value1, long al_value2);//////////////////////////////////////////////////////////////////////////////
// Description: 
// This method combines two value with the XOR operator.
// (On the basis of PFC)
//
// Arguments: 
// 	al_value1	long	First value to combine
//		al_value2	long	Second value to combine
// 
// Returns: 
//		The XOR value
//

Integer     li_Cnt
Long        ll_Result
Boolean     lb_Value1[32], lb_Value2[32]

// Check for nulls
If IsNull(al_Value1) Or IsNull(al_Value2) Then
   SetNull(ll_Result)
   Return ll_Result
End If

// Get all bits for both values
For li_Cnt = 1 To 32
   lb_Value1[li_Cnt] = of_getbit(al_Value1, li_Cnt)
   lb_Value2[li_Cnt] = of_getbit(al_Value2, li_Cnt)
Next

// Perform the XOR
For li_Cnt = 1 To 32
   If (lb_Value1[li_Cnt] And Not lb_Value2[li_Cnt]) Or &
      (Not lb_Value1[li_Cnt] And lb_Value2[li_Cnt]) Then
      ll_Result = ll_Result + (2^(li_Cnt - 1))
   End If
Next

Return ll_Result
end function

public function boolean of_getbit (long al_decimal, unsignedinteger ai_bit);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Returns the bit of the position
// 
// Arguments: 
// 	al_decimal	long		Base value
//		ai_bit		integer	Position
//
//	Returns
//		true = 1
//		fale = 0
// 

Boolean lb_null

// Check parameters
If IsNull(al_decimal) or IsNull(ai_bit) then
   SetNull(lb_null)
   Return lb_null
End If

// Assumption ai_bit is the nth bit counting right to left with
// the leftmost bit being bit one.
// al_decimal is a binary number as a base 10 long.
If Int(Mod(al_decimal / (2 ^(ai_bit - 1)), 2)) > 0 Then
   Return True
End If

Return False
end function

public function string of_getformatstring (character ac_ecclevel, long al_maskversion);string	ls_generator = "10100110111";
string 	ls_mask = "101010000010010";
string	ls_fstr, ls_fstrecc, ls_fstreccNew, ls_resultMask
long		ll_index

if ac_ecclevel = n_cst_qrcoder.ECCLEVEL_L then
	ls_fstr = "01"
elseif ac_ecclevel = n_cst_qrcoder.ECCLEVEL_M then
	ls_fstr = "00"
elseif ac_ecclevel = n_cst_qrcoder.ECCLEVEL_Q then	
	ls_fstr = "11"
else
	ls_fstr = "10"
end if

ls_fstr += of_decToBin(al_maskversion, 3)
ls_fstrecc = of_trimStart(left(ls_fstr + fill('0', 15), 15), '0')

do while len(ls_fstrecc) > 10
	ls_generator = left(ls_generator + fill('0', len(ls_fstrecc)), len(ls_fstrecc))
	ls_fstreccNew = ""
	for ll_index = 1 to len(ls_fstrecc)
		ls_fstreccNew += string(of_bitwiseXor(long(mid(ls_fstrecc, ll_index, 1)), long(mid(ls_generator, ll_index, 1))))		
	next
	ls_fstrecc = of_trimStart(ls_fstreccNew, '0')
loop

ls_fstrecc = right(fill('0', 10) + ls_fstrecc, 10)
ls_fstr += ls_fstrecc


for ll_index = 1 to len(ls_fstr)
	ls_resultMask += string(of_bitwiseXor(long(mid(ls_fstr, ll_index, 1)), long(mid(ls_mask, ll_index, 1))))
next

return ls_resultMask
end function

public subroutine of_init (long al_version, string as_interleavedata, s_point astra_alignmentpatternlocations[], character ac_ecclevel);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Initialization
// 
// Author: 
// B.Kemner, 26.06.2015 
// 

long 		ll_maskVersion
string	ls_formatString, ls_versionString

of_init(al_version)

of_placeFinderPatterns()
of_reserveSeperatorAreas()
of_placeAlignmentPatterns(astra_alignmentPatternLocations);
of_placeTimingPatterns()
of_placeDarkModule()
of_reserveVersionAreas()
of_placeDataWords(as_interleavedata)

ll_maskVersion = of_maskCode()
ls_formatString = of_getFormatString(ac_ecclevel, ll_maskVersion)
of_placeFormat(ls_formatString)

if al_version > 7 then
	ls_versionString = of_getVersionString(al_version)
	of_placeVersion(ls_versionString)
end if

of_addQuietZone()
end subroutine

public subroutine of_placeformat (string as_formatstring);long		ll_size, ll_index, ll_strPointer
long		lla_mods[15,4]
s_point	lstr_p1, lstr_p2, lstr_empty

ll_size = upperBound(istra_moduleMatrix)
as_formatstring = reverse(as_formatstring)

lla_mods[1,1] = 8
lla_mods[1,2] = 0
lla_mods[1,3] = ll_size -1
lla_mods[1,4] = 8

lla_mods[2,1] = 8
lla_mods[2,2] = 1
lla_mods[2,3] = ll_size -2
lla_mods[2,4] = 8

lla_mods[3,1] = 8
lla_mods[3,2] = 2
lla_mods[3,3] = ll_size -3
lla_mods[3,4] = 8

lla_mods[4,1] = 8
lla_mods[4,2] = 3
lla_mods[4,3] = ll_size -4
lla_mods[4,4] = 8

lla_mods[5,1] = 8
lla_mods[5,2] = 4
lla_mods[5,3] = ll_size -5
lla_mods[5,4] = 8

lla_mods[6,1] = 8
lla_mods[6,2] = 5
lla_mods[6,3] = ll_size -6
lla_mods[6,4] = 8

lla_mods[7,1] = 8
lla_mods[7,2] = 7
lla_mods[7,3] = ll_size -7
lla_mods[7,4] = 8

lla_mods[8,1] = 8
lla_mods[8,2] = 8
lla_mods[8,3] = ll_size -8
lla_mods[8,4] = 8

lla_mods[9,1] = 7
lla_mods[9,2] = 8
lla_mods[9,3] = 8
lla_mods[9,4] = ll_size -7

lla_mods[10,1] = 5
lla_mods[10,2] = 8
lla_mods[10,3] = 8
lla_mods[10,4] = ll_size -6

lla_mods[11,1] = 4
lla_mods[11,2] = 8
lla_mods[11,3] = 8
lla_mods[11,4] = ll_size -5

lla_mods[12,1] = 3
lla_mods[12,2] = 8
lla_mods[12,3] = 8
lla_mods[12,4] = ll_size -4

lla_mods[13,1] = 2
lla_mods[13,2] = 8
lla_mods[13,3] = 8
lla_mods[13,4] = ll_size -3

lla_mods[14,1] = 1
lla_mods[14,2] = 8
lla_mods[14,3] = 8
lla_mods[14,4] = ll_size -2

lla_mods[15,1] = 0
lla_mods[15,2] = 8
lla_mods[15,3] = 8
lla_mods[15,4] = ll_size -1

ll_strPointer = len(as_formatstring)

for ll_index = 1 to 15
	lstr_p1 = lstr_empty
	lstr_p2 = lstr_empty
	
	lstr_p1.x = lla_mods[ll_index,1]
	lstr_p1.y = lla_mods[ll_index,2]

	lstr_p2.x = lla_mods[ll_index,3]
	lstr_p2.y = lla_mods[ll_index,4]

	if mid(as_formatstring, ll_index, 1) = "1" then
		istra_moduleMatrix[lstr_p1.y +1].bits[lstr_p1.x +1] = true
	else
		istra_moduleMatrix[lstr_p1.y +1].bits[lstr_p1.x +1] = false
	end if
	
	if mid(as_formatstring, ll_index, 1) = "1" then
		istra_moduleMatrix[lstr_p2.y +1].bits[lstr_p2.x +1] = true
	else
		istra_moduleMatrix[lstr_p2.y +1].bits[lstr_p2.x +1] = false
	end if
next

end subroutine

public function string of_getversionstring (long al_version);string 	ls_generator = "1111100100101"
string 	ls_result
string	ls_ecc, ls_eccNew
long		ll_index

ls_result = of_decToBin(al_version, 6)
ls_ecc = of_trimStart(ls_result + left(fill('0', 18), 18), '0')

do while len(ls_ecc) > 12
	ls_eccNew = ""
	ls_generator = left(ls_result+ fill('0', len(ls_ecc)), len(ls_ecc))
	for ll_index = 1 to len(ls_ecc)
		ls_eccNew += string(of_bitwiseXor(long(mid(ls_ecc, ll_index, 1)), long(mid(ls_generator, ll_index, 1))))
	next
	
	ls_ecc = of_trimStart(ls_eccNew, '0')
loop

ls_ecc = right(fill('0', 12) + ls_ecc, 12)
ls_result = ls_ecc

return ls_result;
end function

public subroutine of_placeversion (string as_versionstring);long	ll_size, ll_x, ll_y

ll_size = upperBound(istra_moduleMatrix)
as_versionstring = reverse(as_versionstring)

for ll_x = 1 to 6
	for ll_y = 1 to 3
		if mid(as_versionstring, ((ll_x -1) * 3 + (ll_y -1)) +1, 1) = "1" then
			istra_moduleMatrix[ll_y + ll_size -11].bits[ll_x] = true
			istra_moduleMatrix[ll_x].bits[ll_y + ll_size -11] = true
		else
			istra_moduleMatrix[ll_y + ll_size -11].bits[ll_x] = false
			istra_moduleMatrix[ll_x].bits[ll_y + ll_size -11] = false
		end if
		
	next
next
end subroutine

public subroutine of_addquietzone ();long 				ll_index, ll_count, ll_bit, ll_bitCount
boolean			lba_quietpart[4], lba_tempLine[], lba_empty[]
s_bitarray		lstra_moduleMatrix[]

ll_count = upperBound(istra_moduleMatrix)

for ll_index = 1 to 4
	lstra_moduleMatrix[ll_index].bits[upperBound(istra_moduleMatrix) +8] = false
next

for ll_index = 1 to ll_count
	lstra_moduleMatrix[ll_index+4] = istra_moduleMatrix[ll_index]
next

for ll_index = 1 to 4
	lstra_moduleMatrix[upperBound(lstra_moduleMatrix) +1].bits[upperBound(istra_moduleMatrix) +8] = false
next

istra_moduleMatrix = lstra_moduleMatrix
for ll_index = 5 to upperBound(istra_moduleMatrix) -4
	lba_tempLine = lba_quietPart
	for ll_bit = 1 to upperBound(istra_moduleMatrix[ll_index].bits)
		lba_tempLine[upperBound(lba_tempLine) +1] = istra_moduleMatrix[ll_index].bits[ll_bit]
	next
	
	for ll_bit = 1 to 4
		lba_tempLine[upperBound(lba_tempLine) +1] = lba_quietPart[ll_bit]
	next
	
	istra_moduleMatrix[ll_index].bits = lba_tempLine
next
end subroutine

public function long of_getmodulmatrix (ref s_bitarray rstra_modulematrix[]);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Returns the current modul matrix
// 
// Author: 
// B.Kemner, 13.07.2015 
// 

rstra_moduleMatrix = istra_moduleMatrix

return upperBound(istra_moduleMatrix)
end function

on n_cst_qrcode.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_qrcode.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

