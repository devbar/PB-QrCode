HA$PBExportHeader$n_cst_qrcoder.sru
forward
global type n_cst_qrcoder from nonvisualobject
end type
end forward

global type n_cst_qrcoder from nonvisualobject
end type
global n_cst_qrcoder n_cst_qrcoder

type variables
public:

constant char ECCLEVEL_L = 'L'
constant char ECCLEVEL_M = 'M'
constant char ECCLEVEL_Q = 'Q'
constant char ECCLEVEL_H = 'H'

constant int ENCODINGMODE_NUMERIC = 1
constant int ENCODINGMODE_ALPHA = 2
constant int ENCODINGMODE_BYTE = 4
constant int ENCODINGMODE_KANJI = 8
constant int ENCODINGMODE_ECI = 7

private: 

char ica_alphanumEncTable[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', ' ', '$', '%', '*', '+', '-', '.', '/', ':' }
long ila_capacityBaseValues[] = { 41, 25, 17, 10, 34, 20, 14, 8, 27, 16, 11, 7, 17, 10, 7, 4, 77, 47, 32, 20, 63, 38, 26, 16, 48, 29, 20, 12, 34, 20, 14, 8, 127, 77, 53, 32, 101, 61, 42, 26, 77, 47, 32, 20, 58, 35, 24, 15, 187, 114, 78, 48, 149, 90, 62, 38, 111, 67, 46, 28, 82, 50, 34, 21, 255, 154, 106, 65, 202, 122, 84, 52, 144, 87, 60, 37, 106, 64, 44, 27, 322, 195, 134, 82, 255, 154, 106, 65, 178, 108, 74, 45, 139, 84, 58, 36, 370, 224, 154, 95, 293, 178, 122, 75, 207, 125, 86, 53, 154, 93, 64, 39, 461, 279, 192, 118, 365, 221, 152, 93, 259, 157, 108, 66, 202, 122, 84, 52, 552, 335, 230, 141, 432, 262, 180, 111, 312, 189, 130, 80, 235, 143, 98, 60, 652, 395, 271, 167, 513, 311, 213, 131, 364, 221, 151, 93, 288, 174, 119, 74, 772, 468, 321, 198, 604, 366, 251, 155, 427, 259, 177, 109, 331, 200, 137, 85, 883, 535, 367, 226, 691, 419, 287, 177, 489, 296, 203, 125, 374, 227, 155, 96, 1022, 619, 425, 262, 796, 483, 331, 204, 580, 352, 241, 149, 427, 259, 177, 109, 1101, 667, 458, 282, 871, 528, 362, 223, 621, 376, 258, 159, 468, 283, 194, 120, 1250, 758, 520, 320, 991, 600, 412, 254, 703, 426, 292, 180, 530, 321, 220, 136, 1408, 854, 586, 361, 1082, 656, 450, 277, 775, 470, 322, 198, 602, 365, 250, 154, 1548, 938, 644, 397, 1212, 734, 504, 310, 876, 531, 364, 224, 674, 408, 280, 173, 1725, 1046, 718, 442, 1346, 816, 560, 345, 948, 574, 394, 243, 746, 452, 310, 191, 1903, 1153, 792, 488, 1500, 909, 624, 384, 1063, 644, 442, 272, 813, 493, 338, 208, 2061, 1249, 858, 528, 1600, 970, 666, 410, 1159, 702, 482, 297, 919, 557, 382, 235, 2232, 1352, 929, 572, 1708, 1035, 711, 438, 1224, 742, 509, 314, 969, 587, 403, 248, 2409, 1460, 1003, 618, 1872, 1134, 779, 480, 1358, 823, 565, 348, 1056, 640, 439, 270, 2620, 1588, 1091, 672, 2059, 1248, 857, 528, 1468, 890, 611, 376, 1108, 672, 461, 284, 2812, 1704, 1171, 721, 2188, 1326, 911, 561, 1588, 963, 661, 407, 1228, 744, 511, 315, 3057, 1853, 1273, 784, 2395, 1451, 997, 614, 1718, 1041, 715, 440, 1286, 779, 535, 330, 3283, 1990, 1367, 842, 2544, 1542, 1059, 652, 1804, 1094, 751, 462, 1425, 864, 593, 365, 3517, 2132, 1465, 902, 2701, 1637, 1125, 692, 1933, 1172, 805, 496, 1501, 910, 625, 385, 3669, 2223, 1528, 940, 2857, 1732, 1190, 732, 2085, 1263, 868, 534, 1581, 958, 658, 405, 3909, 2369, 1628, 1002, 3035, 1839, 1264, 778, 2181, 1322, 908, 559, 1677, 1016, 698, 430, 4158, 2520, 1732, 1066, 3289, 1994, 1370, 843, 2358, 1429, 982, 604, 1782, 1080, 742, 457, 4417, 2677, 1840, 1132, 3486, 2113, 1452, 894, 2473, 1499, 1030, 634, 1897, 1150, 790, 486, 4686, 2840, 1952, 1201, 3693, 2238, 1538, 947, 2670, 1618, 1112, 684, 2022, 1226, 842, 518, 4965, 3009, 2068, 1273, 3909, 2369, 1628, 1002, 2805, 1700, 1168, 719, 2157, 1307, 898, 553, 5253, 3183, 2188, 1347, 4134, 2506, 1722, 1060, 2949, 1787, 1228, 756, 2301, 1394, 958, 590, 5529, 3351, 2303, 1417, 4343, 2632, 1809, 1113, 3081, 1867, 1283, 790, 2361, 1431, 983, 605, 5836, 3537, 2431, 1496, 4588, 2780, 1911, 1176, 3244, 1966, 1351, 832, 2524, 1530, 1051, 647, 6153, 3729, 2563, 1577, 4775, 2894, 1989, 1224, 3417, 2071, 1423, 876, 2625, 1591, 1093, 673, 6479, 3927, 2699, 1661, 5039, 3054, 2099, 1292, 3599, 2181, 1499, 923, 2735, 1658, 1139, 701, 6743, 4087, 2809, 1729, 5313, 3220, 2213, 1362, 3791, 2298, 1579, 972, 2927, 1774, 1219, 750, 7089, 4296, 2953, 1817, 5596, 3391, 2331, 1435, 3993, 2420, 1663, 1024, 3057, 1852, 1273, 784 }
long ila_capacityECCBaseValues[] = { 19, 7, 1, 19, 0, 0, 16, 10, 1, 16, 0, 0, 13, 13, 1, 13, 0, 0, 9, 17, 1, 9, 0, 0, 34, 10, 1, 34, 0, 0, 28, 16, 1, 28, 0, 0, 22, 22, 1, 22, 0, 0, 16, 28, 1, 16, 0, 0, 55, 15, 1, 55, 0, 0, 44, 26, 1, 44, 0, 0, 34, 18, 2, 17, 0, 0, 26, 22, 2, 13, 0, 0, 80, 20, 1, 80, 0, 0, 64, 18, 2, 32, 0, 0, 48, 26, 2, 24, 0, 0, 36, 16, 4, 9, 0, 0, 108, 26, 1, 108, 0, 0, 86, 24, 2, 43, 0, 0, 62, 18, 2, 15, 2, 16, 46, 22, 2, 11, 2, 12, 136, 18, 2, 68, 0, 0, 108, 16, 4, 27, 0, 0, 76, 24, 4, 19, 0, 0, 60, 28, 4, 15, 0, 0, 156, 20, 2, 78, 0, 0, 124, 18, 4, 31, 0, 0, 88, 18, 2, 14, 4, 15, 66, 26, 4, 13, 1, 14, 194, 24, 2, 97, 0, 0, 154, 22, 2, 38, 2, 39, 110, 22, 4, 18, 2, 19, 86, 26, 4, 14, 2, 15, 232, 30, 2, 116, 0, 0, 182, 22, 3, 36, 2, 37, 132, 20, 4, 16, 4, 17, 100, 24, 4, 12, 4, 13, 274, 18, 2, 68, 2, 69, 216, 26, 4, 43, 1, 44, 154, 24, 6, 19, 2, 20, 122, 28, 6, 15, 2, 16, 324, 20, 4, 81, 0, 0, 254, 30, 1, 50, 4, 51, 180, 28, 4, 22, 4, 23, 140, 24, 3, 12, 8, 13, 370, 24, 2, 92, 2, 93, 290, 22, 6, 36, 2, 37, 206, 26, 4, 20, 6, 21, 158, 28, 7, 14, 4, 15, 428, 26, 4, 107, 0, 0, 334, 22, 8, 37, 1, 38, 244, 24, 8, 20, 4, 21, 180, 22, 12, 11, 4, 12, 461, 30, 3, 115, 1, 116, 365, 24, 4, 40, 5, 41, 261, 20, 11, 16, 5, 17, 197, 24, 11, 12, 5, 13, 523, 22, 5, 87, 1, 88, 415, 24, 5, 41, 5, 42, 295, 30, 5, 24, 7, 25, 223, 24, 11, 12, 7, 13, 589, 24, 5, 98, 1, 99, 453, 28, 7, 45, 3, 46, 325, 24, 15, 19, 2, 20, 253, 30, 3, 15, 13, 16, 647, 28, 1, 107, 5, 108, 507, 28, 10, 46, 1, 47, 367, 28, 1, 22, 15, 23, 283, 28, 2, 14, 17, 15, 721, 30, 5, 120, 1, 121, 563, 26, 9, 43, 4, 44, 397, 28, 17, 22, 1, 23, 313, 28, 2, 14, 19, 15, 795, 28, 3, 113, 4, 114, 627, 26, 3, 44, 11, 45, 445, 26, 17, 21, 4, 22, 341, 26, 9, 13, 16, 14, 861, 28, 3, 107, 5, 108, 669, 26, 3, 41, 13, 42, 485, 30, 15, 24, 5, 25, 385, 28, 15, 15, 10, 16, 932, 28, 4, 116, 4, 117, 714, 26, 17, 42, 0, 0, 512, 28, 17, 22, 6, 23, 406, 30, 19, 16, 6, 17, 1006, 28, 2, 111, 7, 112, 782, 28, 17, 46, 0, 0, 568, 30, 7, 24, 16, 25, 442, 24, 34, 13, 0, 0, 1094, 30, 4, 121, 5, 122, 860, 28, 4, 47, 14, 48, 614, 30, 11, 24, 14, 25, 464, 30, 16, 15, 14, 16, 1174, 30, 6, 117, 4, 118, 914, 28, 6, 45, 14, 46, 664, 30, 11, 24, 16, 25, 514, 30, 30, 16, 2, 17, 1276, 26, 8, 106, 4, 107, 1000, 28, 8, 47, 13, 48, 718, 30, 7, 24, 22, 25, 538, 30, 22, 15, 13, 16, 1370, 28, 10, 114, 2, 115, 1062, 28, 19, 46, 4, 47, 754, 28, 28, 22, 6, 23, 596, 30, 33, 16, 4, 17, 1468, 30, 8, 122, 4, 123, 1128, 28, 22, 45, 3, 46, 808, 30, 8, 23, 26, 24, 628, 30, 12, 15, 28, 16, 1531, 30, 3, 117, 10, 118, 1193, 28, 3, 45, 23, 46, 871, 30, 4, 24, 31, 25, 661, 30, 11, 15, 31, 16, 1631, 30, 7, 116, 7, 117, 1267, 28, 21, 45, 7, 46, 911, 30, 1, 23, 37, 24, 701, 30, 19, 15, 26, 16, 1735, 30, 5, 115, 10, 116, 1373, 28, 19, 47, 10, 48, 985, 30, 15, 24, 25, 25, 745, 30, 23, 15, 25, 16, 1843, 30, 13, 115, 3, 116, 1455, 28, 2, 46, 29, 47, 1033, 30, 42, 24, 1, 25, 793, 30, 23, 15, 28, 16, 1955, 30, 17, 115, 0, 0, 1541, 28, 10, 46, 23, 47, 1115, 30, 10, 24, 35, 25, 845, 30, 19, 15, 35, 16, 2071, 30, 17, 115, 1, 116, 1631, 28, 14, 46, 21, 47, 1171, 30, 29, 24, 19, 25, 901, 30, 11, 15, 46, 16, 2191, 30, 13, 115, 6, 116, 1725, 28, 14, 46, 23, 47, 1231, 30, 44, 24, 7, 25, 961, 30, 59, 16, 1, 17, 2306, 30, 12, 121, 7, 122, 1812, 28, 12, 47, 26, 48, 1286, 30, 39, 24, 14, 25, 986, 30, 22, 15, 41, 16, 2434, 30, 6, 121, 14, 122, 1914, 28, 6, 47, 34, 48, 1354, 30, 46, 24, 10, 25, 1054, 30, 2, 15, 64, 16, 2566, 30, 17, 122, 4, 123, 1992, 28, 29, 46, 14, 47, 1426, 30, 49, 24, 10, 25, 1096, 30, 24, 15, 46, 16, 2702, 30, 4, 122, 18, 123, 2102, 28, 13, 46, 32, 47, 1502, 30, 48, 24, 14, 25, 1142, 30, 42, 15, 32, 16, 2812, 30, 20, 117, 4, 118, 2216, 28, 40, 47, 7, 48, 1582, 30, 43, 24, 22, 25, 1222, 30, 10, 15, 67, 16, 2956, 30, 19, 118, 6, 119, 2334, 28, 18, 47, 31, 48, 1666, 30, 34, 24, 34, 25, 1276, 30, 20, 15, 61, 16 }
long ila_alignmentPatternBaseValues[] = { 0, 0, 0, 0, 0, 0, 0, 6, 18, 0, 0, 0, 0, 0, 6, 22, 0, 0, 0, 0, 0, 6, 26, 0, 0, 0, 0, 0, 6, 30, 0, 0, 0, 0, 0, 6, 34, 0, 0, 0, 0, 0, 6, 22, 38, 0, 0, 0, 0, 6, 24, 42, 0, 0, 0, 0, 6, 26, 46, 0, 0, 0, 0, 6, 28, 50, 0, 0, 0, 0, 6, 30, 54, 0, 0, 0, 0, 6, 32, 58, 0, 0, 0, 0, 6, 34, 62, 0, 0, 0, 0, 6, 26, 46, 66, 0, 0, 0, 6, 26, 48, 70, 0, 0, 0, 6, 26, 50, 74, 0, 0, 0, 6, 30, 54, 78, 0, 0, 0, 6, 30, 56, 82, 0, 0, 0, 6, 30, 58, 86, 0, 0, 0, 6, 34, 62, 90, 0, 0, 0, 6, 28, 50, 72, 94, 0, 0, 6, 26, 50, 74, 98, 0, 0, 6, 30, 54, 78, 102, 0, 0, 6, 28, 54, 80, 106, 0, 0, 6, 32, 58, 84, 110, 0, 0, 6, 30, 58, 86, 114, 0, 0, 6, 34, 62, 90, 118, 0, 0, 6, 26, 50, 74, 98, 122, 0, 6, 30, 54, 78, 102, 126, 0, 6, 26, 52, 78, 104, 130, 0, 6, 30, 56, 82, 108, 134, 0, 6, 34, 60, 86, 112, 138, 0, 6, 30, 58, 86, 114, 142, 0, 6, 34, 62, 90, 118, 146, 0, 6, 30, 54, 78, 102, 126, 150, 6, 24, 50, 76, 102, 128, 154, 6, 28, 54, 80, 106, 132, 158, 6, 32, 58, 84, 110, 136, 162, 6, 26, 54, 82, 110, 138, 166, 6, 30, 58, 86, 114, 142, 170 }
long ila_remainderBits[] = { 0, 7, 7, 7, 7, 7, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3, 3, 3, 3, 3, 0, 0, 0, 0, 0, 0 }

s_antilog 				istra_galoisField[]
s_alphaNumEntry 		istra_alphanumEncDict[]
s_versionInfo			istra_capacityTable[]
s_eccInfo 				istra_capacityECCTable[]
s_alignmentPattern	istra_alignmentPatternTable[]



end variables
forward prototypes
public function boolean of_getbit (long al_decimal, unsignedinteger ai_bit)
public function boolean of_isinarray (any laa_array[], any la_value)
protected function long of_bitwisexor (long al_value1, long al_value2)
public subroutine of_createcapacityecctable (ref s_eccinfo rstra_capacityecctable[])
public subroutine of_createcapacitytable (ref s_versioninfo rstr_capacitytable[])
public function long of_createantilogtable (ref s_antilog rstra_galoisfield[])
public function long of_createalphanumencdict (ref s_alphanumentry rstra_alphanumdict[])
public function long of_createalignmentpatterntable (ref s_alignmentpattern rstra_alignmentpatterntable[])
public function integer of_getencodingmode (string as_plaintext)
public function string of_plaintexttobinarybyte (string as_plaintext, boolean ab_utf8bom)
public function string of_plaintexttobinaryalpha (string as_plaintext, boolean ab_utf8bom)
public function string of_plaintexttobinarynumeric (string as_plaintext, boolean ab_utf8bom)
public function string of_plaintexttobinary (string as_plaintext, integer li_encoding, boolean ab_utf8bom) throws throwable
public function string of_dectobin (long al_dec, long al_padleftupto)
public function string of_dectobin (long al_dec)
public function long of_getalphanumeencindexbychar (string as_search)
public function boolean of_isvalidiso (string as_plaintext)
public function boolean of_isutf8 (integer ai_encoding, string as_plaintext)
public function long of_getdatalength (integer ai_encoding, string as_plaintext, string as_codedtext)
public function long of_getversion (long al_length, integer ai_encoding, character ac_ecclevel)
public function long of_getcountindicatorlength (long al_version, integer ai_encoding)
public function n_cst_qrcode of_createqrcode (string as_plaintext, character ac_ecclevel, boolean ab_utf8bom) throws throwable
public function n_cst_qrcode of_createqrcode (string as_plaintext, character ac_ecclevel) throws throwable
public function boolean of_geteccinfo (long al_version, character ac_ecclevel, ref s_eccinfo rstr_eccinfo)
public function string of_repeatestring (string as_string, long al_repeat)
public function long of_binarystringtoblocklist (string as_bitstring, ref string rsa_blocklist[])
public function string of_getinterleavedata (string as_plaintext, character ac_ecclevel, boolean ab_utf8bom, ref long rl_version) throws throwable
public function s_polynom of_calculatemessagepolynom (string as_bitstring)
public function long of_bintodec (string as_binstring)
public function long of_shrinkalphaexp (long al_alphaexp)
public function s_polynom of_multiplyalphapolynoms (s_polynom lstr_polynombase, s_polynom lstr_polynommultiplier) throws throwable
public function s_polynom of_calculategeneratorpolynom (long al_eccwords) throws throwable
public function long of_getglueexponents (s_polynom lstr_polynom, ref long rla_exponents[])
public function long of_getalphaexpfromintval (long al_val)
public function long of_getintvalfromalphaexp (long al_alphaexp)
public subroutine of_sortpolynomsbyexponent (ref s_polynom rstr_polynom)
public function long of_calculateeccwords (string as_bitstring, s_eccinfo astr_eccinfo, ref string rsa_eccwords[]) throws throwable
public function s_polynom of_converttoalphanotation (s_polynom astr_polynom)
public function s_polynom of_multiplygeneratorpolynombyleadterm (s_polynom astr_genpolynom, s_polynomitem astr_leadterm, long al_lowerexponentby)
public function s_polynom of_converttodecnotation (s_polynom astr_polynom)
public function s_polynom of_xorpolynoms (s_polynom astr_messagepolynom, s_polynom astr_respolynom)
public function s_alignmentPattern of_getalignmentpattern (long al_version)
end prototypes

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

public function boolean of_isinarray (any laa_array[], any la_value);long ll_index, ll_count

ll_count = upperBound(laa_array)
for ll_index = 1 to ll_count
	if laa_array[ll_index] = la_value then
		return true
	end if
next

return false
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

public subroutine of_createcapacityecctable (ref s_eccinfo rstra_capacityecctable[]);long 			ll_index
s_eccInfo	lstr_item, lstr_itemEmpty

for ll_index = 0 to (4 * 6 * 40) -1 step 24
	
	lstr_item = lstr_itemEmpty	
	lstr_item.Version = (ll_index + 24) / 24
	lstr_item.ecclevel = ECCLEVEL_L
	lstr_item.TotalDataCodewords = ila_capacityECCBaseValues[ll_index+1]
	lstr_item.ECCPerBlock = ila_capacityECCBaseValues[ll_index+2]
	lstr_item.BlocksInGroup1 = ila_capacityECCBaseValues[ll_index+3]
	lstr_item.CodewordsInGroup1 = ila_capacityECCBaseValues[ll_index+4]
	lstr_item.BlocksInGroup2  = ila_capacityECCBaseValues[ll_index+5]
	lstr_item.CodewordsInGroup2 = ila_capacityECCBaseValues[ll_index+6]	
	rstra_capacityEccTable[upperBound(rstra_capacityEccTable)+1] = lstr_item

	lstr_item = lstr_itemEmpty
	lstr_item.Version = (ll_index + 24) / 24
	lstr_item.ecclevel = ECCLEVEL_M
	lstr_item.TotalDataCodewords = ila_capacityECCBaseValues[ll_index+7]
	lstr_item.ECCPerBlock = ila_capacityECCBaseValues[ll_index+8]
	lstr_item.BlocksInGroup1 = ila_capacityECCBaseValues[ll_index+9]
	lstr_item.CodewordsInGroup1 = ila_capacityECCBaseValues[ll_index+10]
	lstr_item.BlocksInGroup2  = ila_capacityECCBaseValues[ll_index+11]
	lstr_item.CodewordsInGroup2 = ila_capacityECCBaseValues[ll_index+12]	
	rstra_capacityEccTable[upperBound(rstra_capacityEccTable)+1] = lstr_item
	
	lstr_item = lstr_itemEmpty
	lstr_item.Version = (ll_index + 24) / 24
	lstr_item.ecclevel = ECCLEVEL_Q
	lstr_item.TotalDataCodewords = ila_capacityECCBaseValues[ll_index+13]
	lstr_item.ECCPerBlock = ila_capacityECCBaseValues[ll_index+14]
	lstr_item.BlocksInGroup1 = ila_capacityECCBaseValues[ll_index+15]
	lstr_item.CodewordsInGroup1 = ila_capacityECCBaseValues[ll_index+16]
	lstr_item.BlocksInGroup2  = ila_capacityECCBaseValues[ll_index+17]
	lstr_item.CodewordsInGroup2 = ila_capacityECCBaseValues[ll_index+18]	
	rstra_capacityEccTable[upperBound(rstra_capacityEccTable)+1] = lstr_item
	
	lstr_item = lstr_itemEmpty
	lstr_item.Version = (ll_index + 24) / 24
	lstr_item.ecclevel = ECCLEVEL_H
	lstr_item.TotalDataCodewords = ila_capacityECCBaseValues[ll_index+19]
	lstr_item.ECCPerBlock = ila_capacityECCBaseValues[ll_index+20]
	lstr_item.BlocksInGroup1 = ila_capacityECCBaseValues[ll_index+21]
	lstr_item.CodewordsInGroup1 = ila_capacityECCBaseValues[ll_index+22]
	lstr_item.BlocksInGroup2  = ila_capacityECCBaseValues[ll_index+23]
	lstr_item.CodewordsInGroup2 = ila_capacityECCBaseValues[ll_index+24]	
	rstra_capacityEccTable[upperBound(rstra_capacityEccTable)+1] = lstr_item	
next
end subroutine

public subroutine of_createcapacitytable (ref s_versioninfo rstr_capacitytable[]);long 							ll_index
s_versionInfo				lstr_item, lstr_itemEmpty

for ll_index = 0 to (16 * 40) -1 step 16
	lstr_item = lstr_itemEmpty
	lstr_item.Version = (ll_index + 16) / 16		
	
	lstr_item.Details[1].ErrorCorrectionLevel = ECCLEVEL_L
	lstr_item.Details[1].CapacityDict[1].Encoding = ENCODINGMODE_NUMERIC
	lstr_item.Details[1].CapacityDict[1].Capacity = ila_capacityBaseValues[ll_index+1]
	lstr_item.Details[1].CapacityDict[2].Encoding = ENCODINGMODE_ALPHA
	lstr_item.Details[1].CapacityDict[2].Capacity = ila_capacityBaseValues[ll_index+2]
	lstr_item.Details[1].CapacityDict[3].Encoding = ENCODINGMODE_BYTE
	lstr_item.Details[1].CapacityDict[3].Capacity = ila_capacityBaseValues[ll_index+3]
	lstr_item.Details[1].CapacityDict[4].Encoding = ENCODINGMODE_KANJI
	lstr_item.Details[1].CapacityDict[4].Capacity = ila_capacityBaseValues[ll_index+4]
	
	lstr_item.Details[2].ErrorCorrectionLevel = ECCLEVEL_M
	lstr_item.Details[2].CapacityDict[1].Encoding = ENCODINGMODE_NUMERIC
	lstr_item.Details[2].CapacityDict[1].Capacity = ila_capacityBaseValues[ll_index+5]
	lstr_item.Details[2].CapacityDict[2].Encoding = ENCODINGMODE_ALPHA
	lstr_item.Details[2].CapacityDict[2].Capacity = ila_capacityBaseValues[ll_index+6]
	lstr_item.Details[2].CapacityDict[3].Encoding = ENCODINGMODE_BYTE
	lstr_item.Details[2].CapacityDict[3].Capacity = ila_capacityBaseValues[ll_index+7]
	lstr_item.Details[2].CapacityDict[4].Encoding = ENCODINGMODE_KANJI
	lstr_item.Details[2].CapacityDict[4].Capacity = ila_capacityBaseValues[ll_index+8]
	
	lstr_item.Details[3].ErrorCorrectionLevel = ECCLEVEL_Q
	lstr_item.Details[3].CapacityDict[1].Encoding = ENCODINGMODE_NUMERIC
	lstr_item.Details[3].CapacityDict[1].Capacity = ila_capacityBaseValues[ll_index+9]
	lstr_item.Details[3].CapacityDict[2].Encoding = ENCODINGMODE_ALPHA
	lstr_item.Details[3].CapacityDict[2].Capacity = ila_capacityBaseValues[ll_index+10]
	lstr_item.Details[3].CapacityDict[3].Encoding = ENCODINGMODE_BYTE
	lstr_item.Details[3].CapacityDict[3].Capacity = ila_capacityBaseValues[ll_index+11]
	lstr_item.Details[3].CapacityDict[4].Encoding = ENCODINGMODE_KANJI
	lstr_item.Details[3].CapacityDict[4].Capacity = ila_capacityBaseValues[ll_index+12]

	lstr_item.Details[4].ErrorCorrectionLevel = ECCLEVEL_H
	lstr_item.Details[4].CapacityDict[1].Encoding = ENCODINGMODE_NUMERIC
	lstr_item.Details[4].CapacityDict[1].Capacity = ila_capacityBaseValues[ll_index+13]
	lstr_item.Details[4].CapacityDict[2].Encoding = ENCODINGMODE_ALPHA
	lstr_item.Details[4].CapacityDict[2].Capacity = ila_capacityBaseValues[ll_index+14]
	lstr_item.Details[4].CapacityDict[3].Encoding = ENCODINGMODE_BYTE
	lstr_item.Details[4].CapacityDict[3].Capacity = ila_capacityBaseValues[ll_index+15]
	lstr_item.Details[4].CapacityDict[4].Encoding = ENCODINGMODE_KANJI
	lstr_item.Details[4].CapacityDict[4].Capacity = ila_capacityBaseValues[ll_index+16]
	
	rstr_capacitytable[upperBound(rstr_capacitytable)+1] = lstr_item
next
end subroutine

public function long of_createantilogtable (ref s_antilog rstra_galoisfield[]);//////////////////////////////////////////////////////////////////////////////
// Description: 
// This method create the Antilog table
// 
// Arguments: 
// 	rstra_galoisfield 	antilog[]	The resulted table
// 
// Returns: 
//		The count of entries
//

long			ll_gfItem, ll_index
s_antilog	lstr_item, lstr_empty

for ll_index = 0 to 255
	ll_gfItem = 2 ^ ll_index
	
	if ll_index > 7 then
		ll_gfItem = rstra_galoisField[ll_index].IntegerValue *2
	end if
	
	if ll_gfItem > 255 then
		ll_gfItem = of_bitwiseXor(ll_gfItem, 285)
	end if
	
	lstr_item.IntegerValue = ll_gfItem
	lstr_item.ExponentAlpha = ll_index
	rstra_galoisField[upperBound(rstra_galoisField)+1] = lstr_item
	lstr_item = lstr_empty
next

return upperBound(rstra_galoisfield)
end function

public function long of_createalphanumencdict (ref s_alphanumentry rstra_alphanumdict[]);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Initialize Alphanumeric Dictionary
// 
// Author: 
// B.Kemner, 25.06.2015 
// 

long					ll_index, ll_count
s_alphaNumEntry	lstra_emptyDict[], lstr_emptyItem, lstr_item

ll_count = upperBound(ica_alphanumEncTable)
for ll_index = 1 to ll_count
	lstr_item.Character = ica_alphanumEncTable[ll_index]
	lstr_item.Index = ll_index -1
	rstra_alphanumdict[upperBound(rstra_alphanumdict)+1] = lstr_item
	lstr_item = lstr_emptyItem
next

return upperBound(rstra_alphanumdict)
end function

public function long of_createalignmentpatterntable (ref s_alignmentpattern rstra_alignmentpatterntable[]);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Creates the aligment table
// 
// Author: 
// B.Kemner, 26.06.2015 
// 

long 		ll_index, ll_x, ll_y, ll_item
s_point	lstr_point, lstr_pointEmpty
s_point	lstra_points[], lstra_pointsEmpty[]

for ll_index = 0 to (7 * 40) -1 step 7
	lstra_points = lstra_pointsEmpty
	for ll_x = 0 to 6
		if ila_alignmentPatternBaseValues[ll_index + ll_x + 1] <> 0 then			
			for ll_y = 0 to 6
				if ila_alignmentPatternBaseValues[ll_index + ll_y + 1] <> 0 then
					lstr_point = lstr_pointEmpty
					lstr_point.x = ila_alignmentPatternBaseValues[ll_index + ll_x + 1] -2
					lstr_point.y = ila_alignmentPatternBaseValues[ll_index + ll_y + 1] -2
					
					if not of_isInArray(lstra_points, lstr_point) then
						lstra_points[upperBound(lstra_points)+1] = lstr_point
					end if
				end if
			next
		end if
	next
	
	ll_item = upperBound(rstra_alignmentpatterntable) +1
	rstra_alignmentpatterntable[ll_item].Version = (ll_index + 7) / 7
	rstra_alignmentpatterntable[ll_item].PatternPositions = lstra_points
next

return upperBound(rstra_alignmentpatterntable)
end function

public function integer of_getencodingmode (string as_plaintext);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Finds the Encoding for the string
// 
// Author: 
// B.Kemner, 26.06.2015 
// 

constant string	lcs_numeric = "0123456789"

long					ll_charIndex, ll_charCount
long					ll_alphaIndex, ll_alphaCount
integer				li_encoding
boolean				lb_alphaFound
character			lc_currentChar

ll_alphaCount = upperBound(ica_alphanumEncTable)

ll_charCount = len(as_plaintext)
for ll_charIndex = 1 to ll_charCount
	lc_currentChar = mid(as_plaintext, ll_charIndex, 1)
	
	// Check if all chars are numbers
	if li_encoding = 0 or li_encoding = ENCODINGMODE_NUMERIC then
		if pos(lcs_numeric, lc_currentChar) > 0 then 
			li_encoding = ENCODINGMODE_NUMERIC
		else
			li_encoding = 0
		end if
	end if
	
	// Check if all chars are in alpha numeric table
	if li_encoding = 0 or li_encoding = ENCODINGMODE_ALPHA then		
		lb_alphaFound = false
		for ll_alphaIndex = 1 to ll_alphaCount
			if ica_alphanumEncTable[ll_alphaIndex] = lc_currentChar then
				lb_alphaFound = true
				exit
			end if
		next
		
		if lb_alphaFound then
			li_encoding = ENCODINGMODE_ALPHA
		else
			li_encoding = 0
		end if		
	end if	
	
	// Fallback to Byte encoding if there was not match
	if li_encoding = 0 then
		li_encoding = ENCODINGMODE_BYTE
		exit
	end if
next

return li_encoding
end function

public function string of_plaintexttobinarybyte (string as_plaintext, boolean ab_utf8bom);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Converts the plaintext (byte) to a binary string
// 
// Author: 
// B.Kemner, 26.06.2015 
// 

string 	ls_codeText
long		ll_item, ll_itemCount
byte		lba_codeBytes[], lba_bom[] = {239, 187, 191}

if of_isValidIso(as_plaintext) then
	lba_codeBytes = GetByteArray(blob(as_plaintext,EncodingANSI!))
else
	if ab_utf8bom then
		lba_codeBytes = GetByteArray(blob(lba_bom) + blob(as_plaintext,EncodingUTF8!))		
	else
		lba_codeBytes = GetByteArray(blob(as_plaintext,EncodingUTF8!))
	end if
end if

ll_itemCount = upperBound(lba_codeBytes)
for ll_item = 1 to ll_itemCount
	ls_codeText += of_decToBin(lba_codeBytes[ll_item], 8)
next

return ls_codeText
end function

public function string of_plaintexttobinaryalpha (string as_plaintext, boolean ab_utf8bom);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Converts the (alphanumeric) plaintext to a binary string
// 
// Author: 
// B.Kemner, 26.06.2015 
//

string 	ls_codeText, ls_token
long		ll_dec

do while len(as_plaintext) >= 2
	ls_token = left(as_plaintext, 2)
	ll_dec = of_getAlphaNumeEncIndexByChar(mid(ls_token, 1, 1)) * 45 + of_getAlphaNumeEncIndexByChar(mid(ls_token, 2, 1))
	ls_codeText += of_decToBin(ll_dec, 11)
	as_plaintext = mid(as_plaintext, 3)
loop


if len(as_plaintext) > 0 then
	ls_codeText += of_decToBin(of_getAlphaNumeEncIndexByChar(as_plaintext),6)
end if

return ls_codeText
end function

public function string of_plaintexttobinarynumeric (string as_plaintext, boolean ab_utf8bom);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Converts the (numeric) plaintext to a binary string
// 
// Author: 
// B.Kemner, 26.06.2015 
// 

string	ls_codeText
long		ll_dec

do while len(as_plaintext) >= 3	
	ll_dec = long(left(as_plaintext,3))
	ls_codeText += of_decToBin(ll_dec, 10)
	as_plaintext = mid(as_plaintext,4)
loop
	
if len(as_plaintext) = 2 then
	ll_dec = long(left(as_plaintext, len(as_plaintext)))
	ls_codeText += of_decToBin(ll_dec, 7)
elseif len(as_plaintext) = 1 then
	ll_dec = long(left(as_plaintext, len(as_plaintext)))
	ls_codeText += of_decToBin(ll_dec, 4)
end if

return ls_codeText
end function

public function string of_plaintexttobinary (string as_plaintext, integer li_encoding, boolean ab_utf8bom) throws throwable;//////////////////////////////////////////////////////////////////////////////
// Description: 
// Converts the plaintext to binary data related to the encoding
// 
// Author: 
// B.Kemner, 26.06.2015 
//

choose case li_encoding
	case ENCODINGMODE_NUMERIC
		return of_plainTextToBinaryNumeric(as_plaintext, ab_utf8bom)
	case ENCODINGMODE_ALPHA
		return of_plainTextToBinaryAlpha(as_plaintext, ab_utf8bom)
	case ENCODINGMODE_BYTE
		return of_plainTextToBinaryByte(as_plaintext, ab_utf8bom)
	case else
		Throwable exception
		exception = create Throwable
		exception.Text = "Unknown Encoding passed"
		throw exception
end choose

return ""
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

public function string of_dectobin (long al_dec);return of_decToBin(al_dec, 0)
end function

public function long of_getalphanumeencindexbychar (string as_search);long ll_item, ll_itemCount

ll_itemCount = upperBound(istra_alphanumEncDict)
for ll_item = 1 to ll_itemCount
	if istra_alphanumEncDict[ll_item].character = as_search then
		return istra_alphanumEncDict[ll_item].index
	end if
next

return -1
end function

public function boolean of_isvalidiso (string as_plaintext);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Checks if the values is ANSI "convertable"
// 
// Author: 
// B.Kemner, 26.06.2015 
// 

return as_plaintext = string(blob(as_plaintext, EncodingANSI!), EncodingANSI!)
end function

public function boolean of_isutf8 (integer ai_encoding, string as_plaintext);return ai_encoding = ENCODINGMODE_BYTE and not of_isValidIso(as_plaintext)
end function

public function long of_getdatalength (integer ai_encoding, string as_plaintext, string as_codedtext);if of_isUtf8(ai_encoding, as_codedtext) then
	return len(as_codedtext) / 8
else
	return len(as_plaintext)
end if
end function

public function long of_getversion (long al_length, integer ai_encoding, character ac_ecclevel);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Checks for the version to use
// 
// Author: 
// B.Kemner, 27.06.2015 
// 

long 	ll_version, ll_capIndex, ll_capCount, ll_detailIndex, ll_detailCount, ll_dictIndex, ll_dictCount

setNull(ll_version)

ll_capCount = upperBound(istra_capacityTable)
for ll_capIndex = 1 to ll_capCount
	ll_detailCount = upperBound(istra_capacityTable[ll_capIndex].details)
	for ll_detailIndex = 1 to ll_detailCount
		if istra_capacityTable[ll_capIndex].details[ll_detailIndex].errorcorrectionlevel = ac_ecclevel then
			ll_dictCount = upperBound(istra_capacityTable[ll_capIndex].details[ll_detailIndex].capacitydict)
			for ll_dictIndex = 1 to ll_dictCount
				if istra_capacityTable[ll_capIndex].details[ll_detailIndex].capacitydict[ll_dictIndex].encoding = ai_encoding then
					if istra_capacityTable[ll_capIndex].details[ll_detailIndex].capacitydict[ll_dictIndex].capacity >= al_length then
						if isNull(ll_version) or &
							istra_capacityTable[ll_capIndex].version < ll_version then
							ll_version = istra_capacityTable[ll_capIndex].version
						end if
					end if
				end if
			next 
		end if			
	next 
next

return ll_version
end function

public function long of_getcountindicatorlength (long al_version, integer ai_encoding);if al_version < 10 then
	if ai_encoding = ENCODINGMODE_NUMERIC then
		return 10
	elseif ai_encoding = ENCODINGMODE_ALPHA then
		return 9
	else
		return 8
	end if
elseif al_version < 27 then
	if ai_encoding = ENCODINGMODE_NUMERIC then
		return 12
	elseif ai_encoding = ENCODINGMODE_ALPHA then
		return 11
	elseif ai_encoding = ENCODINGMODE_BYTE then
		return 16
	else
		return 10
	end if
else
	if ai_encoding = ENCODINGMODE_NUMERIC then
		return 14
	elseif ai_encoding = ENCODINGMODE_ALPHA then
		return 13
	elseif ai_encoding = ENCODINGMODE_BYTE then
		return 16
	else
		return 12
	end if
end if
end function

public function n_cst_qrcode of_createqrcode (string as_plaintext, character ac_ecclevel, boolean ab_utf8bom) throws throwable;string				ls_interleaveData
long					ll_version
n_cst_qrcode 		lnv_qrcode

ls_interleaveData = of_getInterleaveData(as_plaintext, ac_ecclevel, ab_utf8bom, ref ll_version)

lnv_qrcode = create n_cst_qrcode
lnv_qrcode.of_init(ll_version, ls_interleaveData, of_getAlignmentPattern(ll_version).patternPositions, ac_ecclevel)

return lnv_qrcode
end function

public function n_cst_qrcode of_createqrcode (string as_plaintext, character ac_ecclevel) throws throwable;return of_createQrCode(as_plaintext, ac_ecclevel, false)
end function

public function boolean of_geteccinfo (long al_version, character ac_ecclevel, ref s_eccinfo rstr_eccinfo);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Retrieves the ECC info field for version and level
// 
// Author: 
// B.Kemner, 29.06.2015 
// 
// Arguments: 
// al_version 	long			Version
//	ac_ecclevel	character	ECC Level
// 
// Returns: 
// 	TRUE = found
//		FALSE = not found
//

long ll_eccIndex, ll_eccCount

ll_eccCount = upperBound(istra_capacityECCTable)
for ll_eccIndex = 1 to ll_eccCount
	if istra_capacityECCTable[ll_eccIndex].version = al_version and istra_capacityECCTable[ll_eccIndex].ecclevel = ac_ecclevel then
		rstr_eccinfo = istra_capacityECCTable[ll_eccIndex]
		return true
	end if
next

return false
end function

public function string of_repeatestring (string as_string, long al_repeat);long		ll_index
string	ls_result

for ll_index = 1 to al_repeat
	ls_result += as_string
next

return ls_result
end function

public function long of_binarystringtoblocklist (string as_bitstring, ref string rsa_blocklist[]);long	ll_item = 1, ll_itemCount

ll_itemCount = len(as_bitString)
do
	rsa_blocklist[upperBound(rsa_blocklist) +1] = left(as_bitString, 8)
	as_bitstring = mid(as_bitstring, 9)
	ll_item += 8
loop until ll_item > ll_itemCount or len(as_bitstring) = 0
					 
return upperBound(rsa_blocklist)
end function

public function string of_getinterleavedata (string as_plaintext, character ac_ecclevel, boolean ab_utf8bom, ref long rl_version) throws throwable;integer				li_encoding
long					ll_dataInputLength, ll_dataLength, ll_lengthDiff, ll_eccIndex, ll_codeBlockIndex, ll_codeGroupIndex
string				ls_codedText, ls_modIndicator, ls_countIndicator, ls_bitString, ls_bitStr
string				lsa_codeWords[], lsa_eccCodeWords[], lsa_empty[], ls_interleavedData
n_cst_qrcode 		lnv_qrcode
s_eccinfo			lstr_eccinfo
s_codewordBlock	lstra_codeWordWithECC[], lstr_codeWord, lstr_codeWordEmpty

li_encoding = of_getEncodingmode(as_plaintext)
ls_codedText = of_plainTextToBinary(as_plaintext, li_encoding, ab_utf8bom)
ll_dataInputLength = of_getDataLength(li_encoding, as_plaintext, ls_codedText)
rl_version = of_getVersion(ll_dataInputLength, li_encoding, ac_ecclevel)

ls_modIndicator = of_decToBin(li_encoding, 4)
ls_countIndicator = of_decToBin(ll_dataInputLength, of_getCountIndicatorLength(rl_version, li_encoding));
ls_bitString = ls_modIndicator + ls_countIndicator
ls_bitstring += ls_codedText

if not of_getEccInfo(rl_version, ac_ecclevel, ref lstr_eccinfo) then
	Throwable excpEccInfoNoutFound
	excpEccInfoNoutFound = create Throwable
	excpEccInfoNoutFound.Text = "Ecc Info not found"
	throw excpEccInfoNoutFound
end if

ll_dataLength = lstr_eccinfo.TotalDataCodewords * 8
ll_lengthDiff = ll_dataLength - len(ls_bitString)

if ll_lengthDiff > 0 then 
	ls_bitString += of_repeateString('0', min(ll_lengthDiff, 4))
end if
	 
if mod(len(ls_bitString), 8) <> 0 then 
	ls_bitString += of_repeateString('0', 8 - mod(len(ls_bitString),8));
end if
	 
do while len(ls_bitString) < ll_dataLength
	 ls_bitString += "1110110000010001"
loop
	 
if len(ls_bitString) > ll_dataLength then	
	ls_bitString = left(ls_bitString, ll_dataLength)
end if

for ll_eccIndex = 0 to lstr_eccInfo.BlocksInGroup1 -1
	ls_bitStr = mid(ls_bitString, ll_eccIndex * lstr_eccInfo.CodewordsInGroup1 * 8, lstr_eccInfo.CodewordsInGroup1 * 8)
	lstr_codeWord = lstr_codeWordEmpty
	lstr_codeWord.BitString = ls_bitStr
	lstr_codeWord.BlockNumber = ll_eccIndex + 1
	lstr_codeWord.GroupNumber = 1
	
	lsa_codewords = lsa_empty
	of_binaryStringToBlockList(ls_bitStr, ref lsa_codewords)
	lstr_codeWord.CodeWords = lsa_codewords
	
	lsa_eccCodeWords = lsa_empty
	of_calculateEccWords(ls_bitStr, lstr_eccinfo, ref lsa_eccCodeWords)
	lstr_codeWord.EccWords = lsa_eccCodeWords
	
	lstra_codeWordWithECC[upperBound(lstra_codeWordWithECC)+1] = lstr_codeWord
next

ls_bitString = mid(ls_bitString, lstr_eccInfo.BlocksInGroup1 * lstr_eccInfo.CodewordsInGroup1 * 8);

for ll_eccIndex = 0 to lstr_eccInfo.BlocksInGroup2 -1
	ls_bitStr = mid(ls_bitString, ll_eccIndex * lstr_eccInfo.CodewordsInGroup2 * 8, lstr_eccInfo.CodewordsInGroup2 * 8)
	lstr_codeWord = lstr_codeWordEmpty
	lstr_codeWord.BitString = ls_bitStr
	lstr_codeWord.BlockNumber = ll_eccIndex + 1
	lstr_codeWord.GroupNumber = 1
	
	lsa_codewords = lsa_empty
	of_binaryStringToBlockList(ls_bitStr, ref lsa_codewords)
	lstr_codeWord.CodeWords = lsa_codewords
	
	lsa_eccCodeWords = lsa_empty
	of_calculateEccWords(ls_bitStr, lstr_eccinfo, ref lsa_eccCodeWords)
	lstr_codeWord.EccWords = lsa_eccCodeWords
	
	lstra_codeWordWithECC[upperBound(lstra_codeWordWithECC)+1] = lstr_codeWord
next

for ll_codeGroupIndex = 1 to max(lstr_eccInfo.CodewordsInGroup1, lstr_eccInfo.CodewordsInGroup2)
	for ll_codeBlockIndex = 1 to upperBound(lstra_codeWordWithECC) 
		if upperBound(lstra_codeWordWithECC[ll_codeBlockIndex].CodeWords) >= ll_codeGroupIndex then
			ls_interleavedData += lstra_codeWordWithECC[ll_codeBlockIndex].CodeWords[ll_codeGroupIndex]
		end if
	next
next

for ll_codeGroupIndex = 1 to lstr_eccInfo.EccPerBlock
	for ll_codeBlockIndex = 1 to upperBound(lstra_codeWordWithECC) 
		if upperBound(lstra_codeWordWithECC[ll_codeBlockIndex].ECCWords) >= ll_codeGroupIndex then
			ls_interleavedData += lstra_codeWordWithECC[ll_codeBlockIndex].ECCWords[ll_codeGroupIndex]
		end if
	next
next

ls_interleavedData += fill('0', ila_remainderBits[rl_version])

return ls_interleavedData
end function

public function s_polynom of_calculatemessagepolynom (string as_bitstring);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Caclulates the Message ploynom
// 
// Author: 
// B.Kemner, 29.06.2015 
// 
// Arguments: 
// as_bitstrong 	string	Bit-String
// 
// Returns: 
//	Polynom structure
//

long				ll_index
s_polynom		lstr_polynom
s_polynomItem	lstr_polynomItem, lstr_polynomItemEmpty

for ll_index = len(as_bitstring) / 8 to 1 step -1
	lstr_polynomItem = lstr_polynomItemEmpty
	lstr_polynomItem.coefficient = of_binToDec(left(as_bitstring, 8))
	lstr_polynomItem.Exponent = ll_index -1
	lstr_polynom.items[upperBound(lstr_polynom.items) +1] = lstr_polynomItem
	as_bitstring = mid(as_bitstring, 9)
next
				
return lstr_polynom				
end function

public function long of_bintodec (string as_binstring);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Converts a binary string to a long value
// 
// Author: 
// B.Kemner, 29.06.2015 
// 
// Arguments: 
// as_binString	string	Binary string
// 
// Returns: 
//		value for bin string
//

string 	ls_digit
long		ll_counter = 0, ll_result = 0

ls_digit = mid(as_binString, len(as_binstring) - ll_counter, 1)
do while ll_counter < len(as_binstring)
	if ls_digit = "1" then
		ll_result += 2 ^ ll_counter
	end if
	ll_counter++
	ls_digit = mid(as_binString, len(as_binstring) - ll_counter, 1)	
loop

return ll_result

end function

public function long of_shrinkalphaexp (long al_alphaexp);return mod(al_alphaExp, 256) + long(truncate(al_alphaExp / 256, 0))
end function

public function s_polynom of_multiplyalphapolynoms (s_polynom lstr_polynombase, s_polynom lstr_polynommultiplier) throws throwable;//////////////////////////////////////////////////////////////////////////////
// Description: 
// This method is to multiply two polynoms
// 
// Author: 
// B.Kemner, 03.07.2015 
// 

long				ll_itemBase, ll_itemBaseCount, ll_itemMulti, ll_itemMultiCount, lla_exponentsToGlue[]
long				ll_expIndex, ll_expCount, ll_coefficient, ll_resultIndex, ll_resultCount, ll_glueIndex, ll_glueCount
s_polynom 		lstr_result, lstr_result2
s_polynomItem	lstr_item, lstr_itemEmpty, lstra_gluedPolynoms[], lstr_gluedItem

ll_itemBaseCount = upperBound(lstr_polynomBase.items)
for ll_itemBase = 1 to ll_itemBaseCount
	ll_itemMultiCount = upperBound(lstr_polynomMultiplier.items)
	for ll_itemMulti = 1 to ll_itemMultiCount	
		lstr_item = lstr_itemEmpty
		lstr_item.Coefficient = of_shrinkAlphaExp(lstr_polynomBase.items[ll_itemBase].Coefficient + lstr_polynomMultiplier.items[ll_itemMulti].Coefficient)
		lstr_item.Exponent = (lstr_polynomBase.items[ll_itemBase].Exponent + lstr_polynomMultiplier.items[ll_itemMulti].Exponent);
		lstr_result.items[upperBound(lstr_result.items) +1] = lstr_item
	next
next

ll_expCount = of_getGlueExponents(lstr_result, ref lla_exponentsToGlue)
for ll_expIndex = 1 to ll_expCount
	lstr_gluedItem = lstr_itemEmpty
	lstr_gluedItem.exponent = lla_exponentsToGlue[ll_expIndex]
	ll_coefficient = 0
	
	ll_resultCount = upperBound(lstr_result.items)
	for ll_resultIndex = 1 to ll_resultCount
		if lstr_result.items[ll_resultIndex].exponent = lla_exponentsToGlue[ll_expIndex] then
			ll_coefficient = of_bitwiseXor(ll_coefficient, of_getIntValFromAlphaExp(lstr_result.items[ll_resultIndex].coefficient))
		end if
	next
	lstr_gluedItem.coefficient = of_getAlphaExpFromIntVal(ll_coefficient)
	lstra_gluedPolynoms[upperBound(lstra_gluedPolynoms)+1] = lstr_gluedItem
next

ll_resultCount = upperBound(lstr_result.items)
for ll_resultIndex = 1 to ll_resultCount
	if not of_isInArray(lla_exponentsToGlue, lstr_result.items[ll_resultIndex].exponent) then
		lstr_result2.items[upperBound(lstr_result2.items) +1] = lstr_result.items[ll_resultIndex]
	end if
next

ll_glueCount = upperBound(lstra_gluedPolynoms)
for ll_glueIndex = 1 to ll_glueCount
	lstr_result2.items[upperBound(lstr_result2.items)+1] = lstra_gluedPolynoms[ll_glueIndex]
next

of_sortPolynomsByExponent(ref lstr_result2)

return lstr_result2
end function

public function s_polynom of_calculategeneratorpolynom (long al_eccwords) throws throwable;long				ll_index
s_polynom		lstr_generatorPolynom, lstr_multiplierPolynom, lstr_polynomEmpty
s_polynomItem	lstr_ploynomItem, lstr_polynomItemEmpty

lstr_ploynomItem = lstr_polynomItemEmpty
lstr_ploynomItem.Coefficient = 0
lstr_ploynomItem.Exponent = 1
lstr_generatorPolynom.items[upperBound(lstr_generatorPolynom.items) +1] = lstr_ploynomItem

lstr_ploynomItem = lstr_polynomItemEmpty
lstr_ploynomItem.Coefficient = 0
lstr_ploynomItem.Exponent = 0
lstr_generatorPolynom.items[upperBound(lstr_generatorPolynom.items) +1] = lstr_ploynomItem
            
for ll_index = 1 to al_eccWords -1
	lstr_multiplierPolynom = lstr_polynomEmpty
	
	lstr_ploynomItem = lstr_polynomItemEmpty
	lstr_ploynomItem.Coefficient = 0
	lstr_ploynomItem.Exponent = 1
	lstr_multiplierPolynom.items[upperBound(lstr_multiplierPolynom.items) +1] = lstr_ploynomItem
	
	lstr_ploynomItem = lstr_polynomItemEmpty
	lstr_ploynomItem.Coefficient = ll_index
	lstr_ploynomItem.Exponent = 0
	lstr_multiplierPolynom.items[upperBound(lstr_multiplierPolynom.items) +1] = lstr_ploynomItem
	
	lstr_generatorPolynom = of_multiplyAlphaPolynoms(lstr_generatorPolynom, lstr_multiplierPolynom)
next

return lstr_generatorPolynom

end function

public function long of_getglueexponents (s_polynom lstr_polynom, ref long rla_exponents[]);//////////////////////////////////////////////////////////////////////////////
// Description: 
// This is to retrieve the glue exponents
// 
// Author: 
// B.Kemner, 03.07.2015 
//

long	ll_count, ll_group, ll_lastGroup = -1, ll_index, ll_counter

of_sortPolynomsByExponent(ref lstr_polynom)

ll_count = upperBound(lstr_polynom.items)
for ll_index = 1 to ll_count
	ll_group = lstr_polynom.items[ll_index].exponent
	if ll_lastGroup <> ll_group then
		ll_counter = 1
	else
		ll_counter++
	end if
	
	if ll_counter = 2 then
		rla_exponents[upperBound(rla_exponents)+1] = ll_group
	end if
	ll_lastGroup = ll_group
next

return upperBound(rla_exponents)
end function

public function long of_getalphaexpfromintval (long al_val);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Search Alphae Exponent for Value
// 
// Author: 
// B.Kemner, 03.07.2015 
// 

long ll_index, ll_count

ll_count = upperBound(istra_galoisField)
for ll_index = 1 to ll_count
	if istra_galoisField[ll_index].integerValue = al_val then
		return istra_galoisField[ll_index].exponentAlpha
	end if
next

return -1

end function

public function long of_getintvalfromalphaexp (long al_alphaexp);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Gets the Alpha Exp for the integer
// 
// Author: 
// B.Kemner, 03.07.2015 
// 

long	ll_index, ll_count

ll_count = upperBound(istra_galoisField)
for ll_index = 1 to ll_count
	if istra_galoisField[ll_index].ExponentAlpha = al_alphaexp then
		return istra_galoisField[ll_index].integerValue
	end if
next

return -1
end function

public subroutine of_sortpolynomsbyexponent (ref s_polynom rstr_polynom);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Sort Array (Desc)
// 
// Author: 
// B.Kemner, 03.07.2015 
// 

long 				ll_row
boolean 			lb_sorted
s_polynomitem	lstr_help

do 
	lb_sorted = true
	for ll_row = 1 to upperBound(rstr_polynom.items) -1
		if rstr_polynom.items[ll_row].Exponent < rstr_polynom.items[ll_row +1].Exponent then
			lstr_help = rstr_polynom.items[ll_row]
			rstr_polynom.items[ll_row] = rstr_polynom.items[ll_row +1]
			rstr_polynom.items[ll_row +1] = lstr_help
			lb_sorted = false
		end if
	next
loop while not lb_sorted
end subroutine

public function long of_calculateeccwords (string as_bitstring, s_eccinfo astr_eccinfo, ref string rsa_eccwords[]) throws throwable;long 				ll_eccWords, ll_index, ll_genLeadTermFactor, ll_index2
s_polynom		lstr_messagePolynom, lstr_generatorPolynom, lstr_leadTermSource, lstr_polyEmpty, lstr_leadTermSourceHelp
s_polynom		lstr_resPolynom

ll_eccWords = astr_eccinfo.EccPerBlock
lstr_messagePolynom = of_calculateMessagePolynom(as_bitString)
lstr_generatorPolynom = of_calculateGeneratorPolynom(ll_eccWords)

for ll_index = 1 to upperBound(lstr_messagePolynom.items)
	lstr_messagePolynom.items[ll_index].exponent = lstr_messagePolynom.items[ll_index].exponent + ll_eccWords  
next

ll_genLeadTermFactor = lstr_messagePolynom.items[1].exponent - lstr_generatorPolynom.items[1].exponent
for ll_index = 1 to upperBound(lstr_generatorPolynom.items)
	lstr_generatorPolynom.items[ll_index].exponent = lstr_generatorPolynom.items[ll_index].exponent + ll_genLeadTermFactor  
next

lstr_leadTermSource = lstr_messagePolynom
for ll_index = 1 to upperBound(lstr_messagePolynom.items)
	if lstr_leadTermSource.items[1].coefficient = 0 then
		for ll_index2 = 2 to upperBound(lstr_leadTermSource.items)
			lstr_leadTermSourceHelp.items[ll_index2 -1] = lstr_leadTermSource.items[ll_index2] 
		next
		lstr_leadTermSource = lstr_leadTermSourceHelp
	else
		lstr_resPolynom = of_multiplyGeneratorPolynomByLeadTerm(lstr_generatorPolynom, of_ConvertToAlphaNotation(lstr_leadTermSource).items[1], ll_index -1)
		lstr_resPolynom = of_convertToDecNotation(lstr_resPolynom)
		lstr_resPolynom = of_xorPolynoms(lstr_leadTermSource, lstr_resPolynom)
		lstr_leadTermSource = lstr_resPolynom
	end if
next

for ll_index = 1 to upperBound(lstr_leadTermSource.items)
	rsa_eccwords[ll_index] = of_decToBin(lstr_leadTermSource.items[ll_index].coefficient, 8)
next

return upperBound(rsa_eccwords)
end function

public function s_polynom of_converttoalphanotation (s_polynom astr_polynom);long				ll_index, ll_count
s_polynom		lstr_result
s_polynomItem	lstr_item, lstr_empty

for ll_index = 1 to upperBound(astr_polynom.items)
	lstr_item = lstr_empty
	if astr_polynom.items[ll_index].coefficient <> 0 then
		lstr_item.coefficient = of_getAlphaExpFromIntVal(astr_polynom.items[ll_index].coefficient)
	else
		lstr_item.coefficient = 0
	end if
	lstr_item.exponent = astr_polynom.items[ll_index].exponent
	lstr_result.items[upperBound(lstr_result.items) +1] = lstr_item
next

return lstr_result
end function

public function s_polynom of_multiplygeneratorpolynombyleadterm (s_polynom astr_genpolynom, s_polynomitem astr_leadterm, long al_lowerexponentby);long				ll_index
s_polynom		lstr_result
s_polynomItem	lstr_item, lstr_empty

for ll_index = 1 to upperBound(astr_genpolynom.items)
	lstr_item = lstr_empty
	lstr_item.Coefficient = mod(astr_genpolynom.items[ll_index].Coefficient + astr_leadTerm.Coefficient,255);
	lstr_item.Exponent = astr_genpolynom.items[ll_index].Exponent - al_lowerExponentBy;
	lstr_result.items[upperBound(lstr_result.items) +1] = lstr_item
next

return lstr_result
end function

public function s_polynom of_converttodecnotation (s_polynom astr_polynom);long	ll_index, ll_count

ll_count = upperBound(astr_polynom.items)
for ll_index = 1 to ll_count
	astr_polynom.items[ll_index].coefficient = of_getIntValFromAlphaExp(astr_polynom.items[ll_index].Coefficient)
next

return astr_polynom
end function

public function s_polynom of_xorpolynoms (s_polynom astr_messagepolynom, s_polynom astr_respolynom);long				ll_index
s_polynom 		lstr_longPoly, lstr_shortPoly, lstr_result, lstr_result2
s_polynomItem	lstr_item, lstr_empty

if upperBound(astr_messagePolynom.items) >= upperBound(astr_resPolynom.items) then
	lstr_longPoly = astr_messagePolynom
	lstr_shortPoly = astr_resPolynom
else
	lstr_longPoly = astr_resPolynom
	lstr_shortPoly = astr_messagePolynom
end if

for ll_index = 1 to upperBound(lstr_longPoly.items)
	lstr_item = lstr_empty
	if upperBound(lstr_shortPoly.items) >= ll_index then				
		lstr_item.Coefficient = of_bitwiseXor(lstr_longPoly.items[ll_index].Coefficient, lstr_shortPoly.items[ll_index].Coefficient)
	else
		lstr_item.Coefficient = of_bitwiseXor(lstr_longPoly.items[ll_index].Coefficient, 0)
	end if
	lstr_item.Exponent = astr_messagePolynom.items[1].Exponent - (ll_index -1);
	lstr_result.items[upperBound(lstr_result.items) +1] = lstr_item
next

for ll_index = 2 to upperBound(lstr_result.items)
	lstr_result2.items[ll_index -1] = lstr_result.items[ll_index]
next

return lstr_result2
end function

public function s_alignmentPattern of_getalignmentpattern (long al_version);long	ll_index, ll_count

ll_count = upperBound(istra_alignmentPatternTable)
for ll_index = 1 to ll_count
	if istra_alignmentPatternTable[ll_index].version = al_version then
		return istra_alignmentPatternTable[ll_index]
	end if
next

s_alignmentPattern lstr_empty
return lstr_empty
end function

on n_cst_qrcoder.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_qrcoder.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//////////////////////////////////////////////////////////////////////////////
// Description: 
// Initializing
// 
// Author: 
// B.Kemner, 26.06.2015 
// 

of_createAntiLogTable(ref istra_galoisField)
of_createAlphaNumEncDict(ref istra_alphanumEncDict)
of_createCapacityTable(ref istra_capacityTable)
of_createCapacityEccTable(ref istra_capacityECCTable)
of_createAlignmentPatternTable(ref istra_alignmentPatternTable)

return 0
end event

