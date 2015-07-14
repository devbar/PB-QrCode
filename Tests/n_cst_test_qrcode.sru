HA$PBExportHeader$n_cst_test_qrcode.sru
forward
global type n_cst_test_qrcode from testcase
end type
end forward

global type n_cst_test_qrcode from testcase
event ue_createantilogtable ( )
event ue_createalphanumencdict ( )
event ue_createcapacitytable ( )
event ue_createcapacityecctable ( )
event ue_createalignmenttable ( )
event ue_getencodingmode ( )
event ue_plaintexttobinary ( ) throws throwable
event ue_dectobin ( )
event ue_isutf8 ( )
event ue_createinterleavedata ( ) throws throwable
event ue_sortpolynomsbyexponent ( )
event ue_multiplyalphapolynoms ( ) throws throwable
event ue_getglueexponents ( )
event ue_calculatemessagepolynom ( )
event ue_bintodec ( )
event ue_calculategeneratorpolynom ( ) throws throwable
event ue_calculateeccwords ( ) throws throwable
event ue_createqrcode ( ) throws throwable
event ue_getversion ( )
event ue_getformatstring ( )
end type
global n_cst_test_qrcode n_cst_test_qrcode

event ue_createantilogtable();//////////////////////////////////////////////////////////////////////////////
// Description: 
// Test Antilog intitialization
// 
// Author: 
// B.Kemner, 25.06.2015 
// 

long				ll_count
s_antilog		lstra_galoisFeld[]
n_cst_qrcoder	lnv_qrcoder

lnv_qrcoder = create n_cst_qrcoder
ll_count = lnv_qrcoder.of_createAntilogTable(ref lstra_galoisFeld)

this.assertEqual(256, upperBound(lstra_galoisFeld))

this.assertEqual(0, lstra_galoisFeld[1].ExponentAlpha)
this.assertEqual(1, lstra_galoisFeld[1].IntegerValue)

this.assertEqual(255, lstra_galoisFeld[256].ExponentAlpha)
this.assertEqual(1, lstra_galoisFeld[256].IntegerValue)

destroy n_cst_qrcoder
end event

event ue_createalphanumencdict();//////////////////////////////////////////////////////////////////////////////
// Description: 
// Test Alphanumeric Dictionary intitialization
// 
// Author: 
// B.Kemner, 25.06.2015 
// 

long					ll_count
s_alphanumentry	lstra_alphaNumDict[]
n_cst_qrcoder		lnv_qrcoder

lnv_qrcoder = create n_cst_qrcoder
ll_count = lnv_qrcoder.of_createAlphaNumEncDict(ref lstra_alphaNumDict)

this.assertEqual(45, upperBound(lstra_alphaNumDict))
this.assertEqual('0', lstra_alphaNumDict[1].character)
this.assertEqual(0, lstra_alphaNumDict[1].index)
this.assertEqual(':', lstra_alphaNumDict[45].character)
this.assertEqual(44, lstra_alphaNumDict[45].index)

destroy n_cst_qrcoder
end event

event ue_createcapacitytable();


long				ll_count
s_versioninfo	lstra_capacityTable[]
n_cst_qrcoder	lnv_qrcoder

lnv_qrcoder = create n_cst_qrcoder
lnv_qrcoder.of_createCapacityTable(ref lstra_capacityTable)

this.assertEqual(40, upperBound(lstra_capacityTable))
this.assertEqual(1, lstra_capacityTable[1].version)
this.assertEqual(40, lstra_capacityTable[40].version)

destroy n_cst_qrcoder
end event

event ue_createcapacityecctable();//////////////////////////////////////////////////////////////////////////////
// Description: 
// Test creating ECC capacity table
// 
// Author: 
// B.Kemner, 25.06.2015 
// 

long					ll_count
s_eccinfo			lstra_eccInfo[]
n_cst_qrcoder		lnv_qrcoder

lnv_qrcoder = create n_cst_qrcoder
lnv_qrcoder.of_createCapacityEccTable(ref lstra_eccInfo)

this.assertEqual(160, upperBound(lstra_eccInfo))

this.assertEqual(1, lstra_eccInfo[1].BlocksInGroup1)
this.assertEqual(0, lstra_eccInfo[1].BlocksInGroup2)
this.assertEqual(19, lstra_eccInfo[1].CodewordsInGroup1)
this.assertEqual(0, lstra_eccInfo[1].CodewordsInGroup2)
this.assertEqual(7, lstra_eccInfo[1].ECCPerBlock)
this.assertEqual('L', lstra_eccInfo[1].ecclevel)
this.assertEqual(19, lstra_eccInfo[1].TotalDataCodewords)
this.assertEqual(1, lstra_eccInfo[1].Version)

this.assertEqual(20, lstra_eccInfo[160].BlocksInGroup1)
this.assertEqual(61, lstra_eccInfo[160].BlocksInGroup2)
this.assertEqual(15, lstra_eccInfo[160].CodewordsInGroup1)
this.assertEqual(16, lstra_eccInfo[160].CodewordsInGroup2)
this.assertEqual(30, lstra_eccInfo[160].ECCPerBlock)
this.assertEqual('H', lstra_eccInfo[160].ecclevel)
this.assertEqual(1276, lstra_eccInfo[160].TotalDataCodewords)
this.assertEqual(40, lstra_eccInfo[160].Version)

destroy n_cst_qrcoder	

end event

event ue_createalignmenttable();//////////////////////////////////////////////////////////////////////////////
// Description: 
// Test creating Alignment table
// 
// Author: 
// B.Kemner, 25.06.2015 
// 

long						ll_count
s_alignmentpattern	lstra_align[]
n_cst_qrcoder			lnv_qrcoder

lnv_qrcoder = create n_cst_qrcoder
lnv_qrcoder.of_createAlignmentPatternTable(ref lstra_align)

this.assertEqual(40, upperBound(lstra_align))

this.assertEqual(1, lstra_align[1].Version)

this.assertEqual(2, lstra_align[2].version)
this.assertEqual(4, lstra_align[2].patternPositions[1].x)
this.assertEqual(4, lstra_align[2].patternPositions[1].y)
this.assertEqual(16, lstra_align[2].patternPositions[4].x)
this.assertEqual(16, lstra_align[2].patternPositions[4].y)

this.assertEqual(40, lstra_align[40].version)
this.assertEqual(4, lstra_align[40].patternPositions[1].x)
this.assertEqual(4, lstra_align[40].patternPositions[1].y)
this.assertEqual(168, lstra_align[40].patternPositions[49].x)
this.assertEqual(168, lstra_align[40].patternPositions[49].y)

destroy n_cst_qrcoder	

end event

event ue_getencodingmode();//////////////////////////////////////////////////////////////////////////////
// Description: 
// Tests to get the correct encoding mode
// 
// Author: 
// B.Kemner, 26.06.2015 
// 

integer			li_encoding
n_cst_qrcoder	lnv_qrcoder

lnv_qrcoder = create n_cst_qrcoder

li_encoding = lnv_qrcoder.of_getEncodingMode("0815")
this.assertEqual(lnv_qrcoder.ENCODINGMODE_NUMERIC, li_encoding)

li_encoding = lnv_qrcoder.of_getEncodingMode("0815-000")
this.assertEqual(lnv_qrcoder.ENCODINGMODE_ALPHA, li_encoding)

li_encoding = lnv_qrcoder.of_getEncodingMode("Hello World")
this.assertEqual(lnv_qrcoder.ENCODINGMODE_BYTE, li_encoding)

li_encoding = lnv_qrcoder.of_getEncodingMode("~t~r~nasdjkhaksd~t")
this.assertEqual(lnv_qrcoder.ENCODINGMODE_BYTE, li_encoding)

li_encoding = lnv_qrcoder.of_getEncodingMode("0815HelloWorld")
this.assertEqual(lnv_qrcoder.ENCODINGMODE_BYTE, li_encoding)

li_encoding = lnv_qrcoder.of_getEncodingMode("HELLO06667")
this.assertEqual(lnv_qrcoder.ENCODINGMODE_ALPHA, li_encoding)

li_encoding = lnv_qrcoder.of_getEncodingMode("HelloW06667sdfhskdhfkshd")
this.assertEqual(lnv_qrcoder.ENCODINGMODE_BYTE, li_encoding)

li_encoding = lnv_qrcoder.of_getEncodingMode("HelloW06667sdfhsk~tdhfkshd")
this.assertEqual(lnv_qrcoder.ENCODINGMODE_BYTE, li_encoding)


end event

event ue_plaintexttobinary();//////////////////////////////////////////////////////////////////////////////
// Description: 
// Method to call plaintext to binary
// 
// Author: 
// B.Kemner, 26.06.2015 
// 

n_cst_qrcoder	lnv_qrcoder

lnv_qrcoder = create n_cst_qrcoder

this.assertEqual("0011100001100001011101001011", lnv_qrcoder.of_plaintextToBinary("A123B", lnv_qrcoder.ENCODINGMODE_ALPHA, false))
this.assertEqual("00011110110111001000", lnv_qrcoder.of_plaintextToBinary("123456", lnv_qrcoder.ENCODINGMODE_NUMERIC, false))
this.assertEqual("01100001", lnv_qrcoder.of_plaintextToBinary("a", lnv_qrcoder.ENCODINGMODE_BYTE, false))
this.assertEqual("011000010110001001100011001100010011001000110011", lnv_qrcoder.of_plaintextToBinary("abc123", lnv_qrcoder.ENCODINGMODE_BYTE, false))

destroy lnv_qrcoder
end event

event ue_dectobin();n_cst_qrcoder	lnv_qrcoder

lnv_qrcoder = create n_cst_qrcoder

this.assertEqual("101", lnv_qrcoder.of_decToBin(5))
this.assertEqual("000101", lnv_qrcoder.of_decToBin(5,6))

end event

event ue_isutf8();//////////////////////////////////////////////////////////////////////////////
// Description: 
// Test for the of_isUTF8 method
// 
// Author: 
// B.Kemner, 27.06.2015 
// 

n_cst_qrcoder lnv_qrcoder

lnv_qrcoder = create n_cst_qrcoder

this.assertEqual(false, lnv_qrcoder.of_isUTF8(lnv_qrcoder.ENCODINGMODE_BYTE, "abc123"))
this.assertEqual(true, lnv_qrcoder.of_isUTF8(lnv_qrcoder.ENCODINGMODE_BYTE, "$$HEX23$$a303721f2000b303bd03c903c103771fb603c9032000001fc003781f2000c403741fbd032000ba03791fc803b703$$ENDHEX$$"))
end event

event ue_createinterleavedata();long				ll_version
string			ls_interleaveData
n_cst_qrcoder	lnv_qrcoder

lnv_qrcoder = create n_cst_qrcoder

ll_version = 0
ls_interleaveData = ""
ls_interleaveData = lnv_qrcoder.of_getInterLeaveData("ABC123", lnv_qrcoder.ecclevel_m, false, ref ll_version)
this.assertEqual("0010000000110001110011010100001110100001011101000000000011101100000100011110110000010001111011000001000111101100000100011110110000000010010111011000000011011110011111000000110100001000001001000100000110111011", &
	ls_interleaveData)

ll_version = 0
ls_interleaveData = ""
ls_interleaveData = lnv_qrcoder.of_getInterLeaveData("123", lnv_qrcoder.ecclevel_m, false, ref ll_version)
this.assertEqual("0001000000001100011110110000000011101100000100011110110000010001111011000001000111101100000100011110110000010001111011000001000100011100010100111011100110011111001010111101010111100011011011010000111001110000", &
	ls_interleaveData)


ll_version = 0
ls_interleaveData = ""
ls_interleaveData = lnv_qrcoder.of_getInterLeaveData("Hello World", lnv_qrcoder.ecclevel_m, false, ref ll_version)
this.assertEqual("0100000010110100100001100101011011000110110001101111001000000101011101101111011100100110110001100100000011101100000100011110110001000000111111000111000101000001110101011000111100100110110101001111010000110011", &
	ls_interleaveData)
	
ll_version = 0
ls_interleaveData = ""
ls_interleaveData = lnv_qrcoder.of_getInterLeaveData("http://www.devbar.de", lnv_qrcoder.ecclevel_m, false, ref ll_version)
this.assertEqual("01000001010001101000011101000111010001110000001110100010111100101111011101110111011101110111001011100110010001100101011101100110001001100001011100100010111001100100011001010000111011000001000111101100000100011110110000010001000101001101100000111011100101010001100110001001101011010111011110001000101110100011100100111111111010101101110011000100001101110000000", &
	ls_interleaveData)
end event

event ue_sortpolynomsbyexponent();s_polynomitem	lstr_itemAdd, lstr_itemEmpty
s_polynom		lstr_testPolynom
n_cst_qrcoder	lnv_qrcoder

lnv_qrcoder = create n_cst_qrcoder

lstr_itemAdd.exponent = 15
lstr_testPolynom.items[upperBound(lstr_testPolynom.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lstr_itemAdd.exponent = 32
lstr_testPolynom.items[upperBound(lstr_testPolynom.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lstr_itemAdd.exponent = 1
lstr_testPolynom.items[upperBound(lstr_testPolynom.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lstr_itemAdd.exponent = 2
lstr_testPolynom.items[upperBound(lstr_testPolynom.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lstr_itemAdd.exponent = 55
lstr_testPolynom.items[upperBound(lstr_testPolynom.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lstr_itemAdd.exponent = 55
lstr_testPolynom.items[upperBound(lstr_testPolynom.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lstr_itemAdd.exponent = 16
lstr_testPolynom.items[upperBound(lstr_testPolynom.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lnv_qrcoder.of_sortPolynomsByExponent(ref lstr_testPolynom)

this.assertEqual(55, lstr_testPolynom.items[1].exponent)
this.assertEqual(55, lstr_testPolynom.items[2].exponent)
this.assertEqual(32, lstr_testPolynom.items[3].exponent)
this.assertEqual(16, lstr_testPolynom.items[4].exponent)
this.assertEqual(15, lstr_testPolynom.items[5].exponent)
this.assertEqual(2, lstr_testPolynom.items[6].exponent)
this.assertEqual(1, lstr_testPolynom.items[7].exponent)


destroy lnv_qrcoder
end event

event ue_multiplyalphapolynoms();//////////////////////////////////////////////////////////////////////////////
// Description: 
// Test polynom multiplication
// 
// Author: 
// B.Kemner, 03.07.2015 
// 

s_polynomitem	lstr_itemAdd, lstr_itemEmpty
s_polynom		lstr_basePolynom, lstr_multiPolynom, lstr_result, lstr_empty
n_cst_qrcoder	lnv_qrcoder

lnv_qrcoder = create n_cst_qrcoder

lstr_itemAdd.coefficient = 0
lstr_itemAdd.exponent = 1
lstr_basePolynom.items[upperBound(lstr_basePolynom.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lstr_itemAdd.coefficient = 0
lstr_itemAdd.exponent = 0
lstr_basePolynom.items[upperBound(lstr_basePolynom.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lstr_itemAdd.coefficient = 0
lstr_itemAdd.exponent = 1
lstr_multiPolynom.items[upperBound(lstr_multiPolynom.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lstr_itemAdd.coefficient = 1
lstr_itemAdd.exponent = 0
lstr_multiPolynom.items[upperBound(lstr_multiPolynom.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lstr_result = lnv_qrcoder.of_multiplyAlphaPolynoms(lstr_basePolynom, lstr_multiPolynom)

this.assertEqual(3, upperBound(lstr_result.items))
this.assertEqual(0, lstr_result.items[1].coefficient)
this.assertEqual(2, lstr_result.items[1].exponent)
this.assertEqual(25, lstr_result.items[2].coefficient)
this.assertEqual(1, lstr_result.items[2].exponent)
this.assertEqual(1, lstr_result.items[3].coefficient)
this.assertEqual(0, lstr_result.items[3].exponent)

lstr_basePolynom = lstr_empty
lstr_multiPolynom = lstr_empty

lstr_itemAdd.coefficient = 0
lstr_itemAdd.exponent = 2
lstr_basePolynom.items[upperBound(lstr_basePolynom.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lstr_itemAdd.coefficient = 25
lstr_itemAdd.exponent = 1
lstr_basePolynom.items[upperBound(lstr_basePolynom.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lstr_itemAdd.coefficient = 1
lstr_itemAdd.exponent = 0
lstr_basePolynom.items[upperBound(lstr_basePolynom.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lstr_itemAdd.coefficient = 0
lstr_itemAdd.exponent = 1
lstr_multiPolynom.items[upperBound(lstr_multiPolynom.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lstr_itemAdd.coefficient = 2
lstr_itemAdd.exponent = 0
lstr_multiPolynom.items[upperBound(lstr_multiPolynom.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lstr_result = lnv_qrcoder.of_multiplyAlphaPolynoms(lstr_basePolynom, lstr_multiPolynom)

this.assertEqual(4, upperBound(lstr_result.items))
this.assertEqual(0, lstr_result.items[1].coefficient)
this.assertEqual(3, lstr_result.items[1].exponent)
this.assertEqual(198, lstr_result.items[2].coefficient)
this.assertEqual(2, lstr_result.items[2].exponent)
this.assertEqual(199, lstr_result.items[3].coefficient)
this.assertEqual(1, lstr_result.items[3].exponent)
this.assertEqual(3, lstr_result.items[4].coefficient)
this.assertEqual(0, lstr_result.items[4].exponent)

destroy lnv_qrcoder
end event

event ue_getglueexponents();long				lla_exponents[]
s_polynomitem	lstr_itemAdd, lstr_itemEmpty
s_polynom		lstr_polynoms
n_cst_qrcoder 	lnv_qrcoder

lnv_qrcoder = create n_cst_qrcoder

lstr_itemAdd.coefficient = 0
lstr_itemAdd.exponent = 2
lstr_polynoms.items[upperBound(lstr_polynoms.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lstr_itemAdd.coefficient = 0
lstr_itemAdd.exponent = 1
lstr_polynoms.items[upperBound(lstr_polynoms.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lstr_itemAdd.coefficient = 1
lstr_itemAdd.exponent = 1
lstr_polynoms.items[upperBound(lstr_polynoms.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lstr_itemAdd.coefficient = 1
lstr_itemAdd.exponent = 0
lstr_polynoms.items[upperBound(lstr_polynoms.items)+1] = lstr_itemAdd
lstr_itemAdd = lstr_itemEmpty

lnv_qrcoder.of_getGlueExponents(lstr_polynoms, ref lla_exponents)

this.assertEqual(1, lla_exponents[1])

destroy lnv_qrcoder
end event

event ue_calculatemessagepolynom();string			ls_bitString
n_cst_qrcoder	lnv_qrcoder
s_polynom		lstr_polynom

lnv_qrcoder = create n_cst_qrcoder

ls_bitString = "00100000001100011100110101000011101000010111010000000000111011000001000111101100000100011110110000010001111011000001000111101100"
lstr_polynom = lnv_qrcoder.of_calculateMessagePolynom(ls_bitString)

this.assertEqual(32, lstr_polynom.items[1].coefficient)
this.assertEqual(15, lstr_polynom.items[1].exponent)

this.assertEqual(49, lstr_polynom.items[2].coefficient)
this.assertEqual(14, lstr_polynom.items[2].exponent)

this.assertEqual(205, lstr_polynom.items[3].coefficient)
this.assertEqual(13, lstr_polynom.items[3].exponent)

this.assertEqual(67, lstr_polynom.items[4].coefficient)
this.assertEqual(12, lstr_polynom.items[4].exponent)

this.assertEqual(161, lstr_polynom.items[5].coefficient)
this.assertEqual(11, lstr_polynom.items[5].exponent)

this.assertEqual(116, lstr_polynom.items[6].coefficient)
this.assertEqual(10, lstr_polynom.items[6].exponent)

this.assertEqual(0, lstr_polynom.items[7].coefficient)
this.assertEqual(9, lstr_polynom.items[7].exponent)

this.assertEqual(236, lstr_polynom.items[8].coefficient)
this.assertEqual(8, lstr_polynom.items[8].exponent)

this.assertEqual(17, lstr_polynom.items[9].coefficient)
this.assertEqual(7, lstr_polynom.items[9].exponent)

this.assertEqual(236, lstr_polynom.items[10].coefficient)
this.assertEqual(6, lstr_polynom.items[10].exponent)

this.assertEqual(17, lstr_polynom.items[11].coefficient)
this.assertEqual(5, lstr_polynom.items[11].exponent)

this.assertEqual(236, lstr_polynom.items[12].coefficient)
this.assertEqual(4, lstr_polynom.items[12].exponent)

this.assertEqual(17, lstr_polynom.items[13].coefficient)
this.assertEqual(3, lstr_polynom.items[13].exponent)

this.assertEqual(236, lstr_polynom.items[14].coefficient)
this.assertEqual(2, lstr_polynom.items[14].exponent)

this.assertEqual(17, lstr_polynom.items[15].coefficient)
this.assertEqual(1, lstr_polynom.items[15].exponent)

this.assertEqual(236, lstr_polynom.items[16].coefficient)
this.assertEqual(0, lstr_polynom.items[16].exponent)

destroy lnv_qrcoder
end event

event ue_bintodec();long				ll_result
n_cst_qrcoder	lnv_qrcoder

lnv_qrcoder = create n_cst_qrcoder
ll_result = lnv_qrcoder.of_binToDec("000101")
this.assertEqual(5, ll_result)

ll_result = lnv_qrcoder.of_binToDec("100100")
this.assertEqual(36, ll_result)

ll_result = lnv_qrcoder.of_binToDec("100101")
this.assertEqual(37, ll_result)

destroy lnv_qrcoder
end event

event ue_calculategeneratorpolynom();s_polynom		lstr_result
n_cst_qrcoder 	lnv_qrcoder

lnv_qrcoder = create n_cst_qrcoder
lstr_result = lnv_qrcoder.of_calculateGeneratorPolynom(10)

this.assertEqual(0, lstr_result.items[1].coefficient)
this.assertEqual(10, lstr_result.items[1].exponent)

this.assertEqual(251, lstr_result.items[2].coefficient)
this.assertEqual(9, lstr_result.items[2].exponent)

this.assertEqual(67, lstr_result.items[3].coefficient)
this.assertEqual(8, lstr_result.items[3].exponent)

this.assertEqual(46, lstr_result.items[4].coefficient)
this.assertEqual(7, lstr_result.items[4].exponent)

this.assertEqual(61, lstr_result.items[5].coefficient)
this.assertEqual(6, lstr_result.items[5].exponent)

this.assertEqual(118, lstr_result.items[6].coefficient)
this.assertEqual(5, lstr_result.items[6].exponent)

this.assertEqual(70, lstr_result.items[7].coefficient)
this.assertEqual(4, lstr_result.items[7].exponent)

this.assertEqual(64, lstr_result.items[8].coefficient)
this.assertEqual(3, lstr_result.items[8].exponent)

this.assertEqual(94, lstr_result.items[9].coefficient)
this.assertEqual(2, lstr_result.items[9].exponent)

this.assertEqual(32, lstr_result.items[10].coefficient)
this.assertEqual(1, lstr_result.items[10].exponent)

this.assertEqual(45, lstr_result.items[11].coefficient)
this.assertEqual(0, lstr_result.items[11].exponent)

destroy lnv_qrcoder


end event

event ue_calculateeccwords();string			lsa_result[]
n_cst_qrcoder	lnv_qrcoder
s_eccinfo		lstr_eccinfo

lnv_qrcoder = create n_cst_qrcoder

lstr_eccinfo.BlocksInGroup1 = 1
lstr_eccinfo.BlocksInGroup2 = 0
lstr_eccinfo.CodeWordsInGroup1 = 16
lstr_eccinfo.CodeWordsInGroup2 = 0
lstr_eccinfo.ECCPerBlock = 10
lstr_eccinfo.ECCLevel = lnv_qrcoder.Ecclevel_m
lstr_eccinfo.TotalDataCodewords = 16
lstr_eccinfo.Version = 1

lnv_qrcoder.of_calculateeccwords(&
	"00100000001100011100110101000011101000010111010000000000111011000001000111101100000100011110110000010001111011000001000111101100", &
	lstr_eccinfo, &
	ref lsa_result)

this.assertEqual("00000010", lsa_result[1])
this.assertEqual("01011101", lsa_result[2])
this.assertEqual("10000000", lsa_result[3])
this.assertEqual("11011110", lsa_result[4])
this.assertEqual("01111100", lsa_result[5])
this.assertEqual("00001101", lsa_result[6])
this.assertEqual("00001000", lsa_result[7])
this.assertEqual("00100100", lsa_result[8])
this.assertEqual("01000001", lsa_result[9])
this.assertEqual("10111011", lsa_result[10])

destroy lnv_qrcoder
end event

event ue_createqrcode();long				ll_count
s_bitarray		lstra_matrix[]
n_cst_qrcoder	lnv_qrcoder
n_cst_qrcode	lnv_qrcode

lnv_qrcoder = create n_cst_qrcoder

lnv_qrcode = lnv_qrcoder.of_createQrCode("ABC123", n_cst_qrcoder.ECCLEVEL_M)
ll_count = lnv_qrcode.of_getModulMatrix(ref lstra_matrix)

this.assertEqual("00000000000000000000000000000", f_printQrMatrixLine(lstra_matrix, 1))
this.assertEqual("00000000000000000000000000000", f_printQrMatrixLine(lstra_matrix, 2))
this.assertEqual("00000000000000000000000000000", f_printQrMatrixLine(lstra_matrix, 3))
this.assertEqual("00000000000000000000000000000", f_printQrMatrixLine(lstra_matrix, 4))
this.assertEqual("00001111111001100011111110000", f_printQrMatrixLine(lstra_matrix, 5))
this.assertEqual("00001000001010010010000010000", f_printQrMatrixLine(lstra_matrix, 6))
this.assertEqual("00001011101001001010111010000", f_printQrMatrixLine(lstra_matrix, 7))
this.assertEqual("00001011101000010010111010000", f_printQrMatrixLine(lstra_matrix, 8))
this.assertEqual("00001011101010001010111010000", f_printQrMatrixLine(lstra_matrix, 9))
this.assertEqual("00001000001001001010000010000", f_printQrMatrixLine(lstra_matrix, 10))
this.assertEqual("00001111111010101011111110000", f_printQrMatrixLine(lstra_matrix, 11))
this.assertEqual("00000000000001011000000000000", f_printQrMatrixLine(lstra_matrix, 12))
this.assertEqual("00001010101000110000100100000", f_printQrMatrixLine(lstra_matrix, 13))
this.assertEqual("00000011010100100010000000000", f_printQrMatrixLine(lstra_matrix, 14))
this.assertEqual("00000110111001101000101100000", f_printQrMatrixLine(lstra_matrix, 15))
this.assertEqual("00000001110100100010010100000", f_printQrMatrixLine(lstra_matrix, 16))
this.assertEqual("00000100101010001010110100000", f_printQrMatrixLine(lstra_matrix, 17))
this.assertEqual("00000000000010010101011000000", f_printQrMatrixLine(lstra_matrix, 18))
this.assertEqual("00001111111001010111000010000", f_printQrMatrixLine(lstra_matrix, 19))
this.assertEqual("00001000001000111101110010000", f_printQrMatrixLine(lstra_matrix, 20))
this.assertEqual("00001011101010110111011010000", f_printQrMatrixLine(lstra_matrix, 21))
this.assertEqual("00001011101001000011000100000", f_printQrMatrixLine(lstra_matrix, 22))
this.assertEqual("00001011101010101000110010000", f_printQrMatrixLine(lstra_matrix, 23))
this.assertEqual("00001000001000100011000110000", f_printQrMatrixLine(lstra_matrix, 24))
this.assertEqual("00001111111011101010101010000", f_printQrMatrixLine(lstra_matrix, 25))
this.assertEqual("00000000000000000000000000000", f_printQrMatrixLine(lstra_matrix, 26))
this.assertEqual("00000000000000000000000000000", f_printQrMatrixLine(lstra_matrix, 27))
this.assertEqual("00000000000000000000000000000", f_printQrMatrixLine(lstra_matrix, 28))
this.assertEqual("00000000000000000000000000000", f_printQrMatrixLine(lstra_matrix, 29))

lnv_qrcode = lnv_qrcoder.of_createQrCode("http://www.devbar.de", n_cst_qrcoder.ECCLEVEL_M)
ll_count = lnv_qrcode.of_getModulMatrix(ref lstra_matrix)

this.assertEqual("000000000000000000000000000000000", f_printQrMatrixLine(lstra_matrix, 1))
this.assertEqual("000000000000000000000000000000000", f_printQrMatrixLine(lstra_matrix, 2))
this.assertEqual("000000000000000000000000000000000", f_printQrMatrixLine(lstra_matrix, 3))
this.assertEqual("000000000000000000000000000000000", f_printQrMatrixLine(lstra_matrix, 4))
this.assertEqual("000011111110111110110011111110000", f_printQrMatrixLine(lstra_matrix, 5))
this.assertEqual("000010000010000100000010000010000", f_printQrMatrixLine(lstra_matrix, 6))
this.assertEqual("000010111010010000001010111010000", f_printQrMatrixLine(lstra_matrix, 7))
this.assertEqual("000010111010110101110010111010000", f_printQrMatrixLine(lstra_matrix, 8))
this.assertEqual("000010111010101011111010111010000", f_printQrMatrixLine(lstra_matrix, 9))
this.assertEqual("000010000010100101001010000010000", f_printQrMatrixLine(lstra_matrix, 10))
this.assertEqual("000011111110101010101011111110000", f_printQrMatrixLine(lstra_matrix, 11))
this.assertEqual("000000000000100110011000000000000", f_printQrMatrixLine(lstra_matrix, 12))
this.assertEqual("000010001011100110000111110010000", f_printQrMatrixLine(lstra_matrix, 13))
this.assertEqual("000011110101111001111100110100000", f_printQrMatrixLine(lstra_matrix, 14))
this.assertEqual("000010010111111110111001111000000", f_printQrMatrixLine(lstra_matrix, 15))
this.assertEqual("000001000001001100101011001100000", f_printQrMatrixLine(lstra_matrix, 16))
this.assertEqual("000000001111100001100010011110000", f_printQrMatrixLine(lstra_matrix, 17))
this.assertEqual("000010111100111010111000100100000", f_printQrMatrixLine(lstra_matrix, 18))
this.assertEqual("000000100011101111111011111000000", f_printQrMatrixLine(lstra_matrix, 19))
this.assertEqual("000000000101001101000111011100000", f_printQrMatrixLine(lstra_matrix, 20))
this.assertEqual("000011001010101011001111111000000", f_printQrMatrixLine(lstra_matrix, 21))
this.assertEqual("000000000000101001111000101000000", f_printQrMatrixLine(lstra_matrix, 22))
this.assertEqual("000011111110100000001010110000000", f_printQrMatrixLine(lstra_matrix, 23))
this.assertEqual("000010000010010010101000111100000", f_printQrMatrixLine(lstra_matrix, 24))
this.assertEqual("000010111010111101101111101110000", f_printQrMatrixLine(lstra_matrix, 25))
this.assertEqual("000010111010011010010110011110000", f_printQrMatrixLine(lstra_matrix, 26))
this.assertEqual("000010111010011111101111000100000", f_printQrMatrixLine(lstra_matrix, 27))
this.assertEqual("000010000010001101010001111100000", f_printQrMatrixLine(lstra_matrix, 28))
this.assertEqual("000011111110100011010010001110000", f_printQrMatrixLine(lstra_matrix, 29))
this.assertEqual("000000000000000000000000000000000", f_printQrMatrixLine(lstra_matrix, 30))
this.assertEqual("000000000000000000000000000000000", f_printQrMatrixLine(lstra_matrix, 31))
this.assertEqual("000000000000000000000000000000000", f_printQrMatrixLine(lstra_matrix, 32))
this.assertEqual("000000000000000000000000000000000", f_printQrMatrixLine(lstra_matrix, 33))

destroy lnv_qrcoder
end event

event ue_getversion();long 				ll_version
n_cst_qrcoder	lnv_qrcoder

lnv_qrcoder = create n_cst_qrcoder

ll_version = lnv_qrcoder.of_getVersion(20, n_cst_qrcoder.ENCODINGMODE_BYTE, n_cst_qrcoder.ECCLEVEL_M)
this.assertEqual(2, ll_version)

ll_version = lnv_qrcoder.of_getVersion(6, n_cst_qrcoder.ENCODINGMODE_ALPHA, n_cst_qrcoder.ECCLEVEL_M)
this.assertEqual(1, ll_version)

destroy lnv_qrcoder
end event

event ue_getformatstring();string			ls_result
n_cst_qrcode	lnv_qrcode

lnv_qrcode = create n_cst_qrcode
ls_result = lnv_qrcode.of_getFormatString(n_cst_qrcoder.ECCLEVEL_M, 4)

this.assertEqual("100010111111001", ls_result)

destroy lnv_qrcode

end event

on n_cst_test_qrcode.create
call super::create
end on

on n_cst_test_qrcode.destroy
call super::destroy
end on

