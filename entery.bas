
#macro isNotNull (arr1,arr2, item1, item2)
	if item1 <> 6 then
		if item1 = 0 then
			arr1 = "sad"
		elseif item1 = 1 then
			arr1 = "angry"
		elseif item1 = 2 then
			arr1 = "worried"
		elseif item1 = 3 then
			arr1 = "bored"
		elseif item1 = 4 then
			arr1 = "happy"
		elseif item1 = 5 then
			arr1 = "relaxed"
		EndIf
		'arr1 = item1
		arr2 = item2
	else
		arr1 = "null"
		arr2 = -1
	EndIf
#EndMacro

type feelingRateDate
	dim rate as LONG
	dim dt as string
End Type



type record
	dim action as STRING
	dim thought as STRING
	dim as string feeling(5)
	dim as long rate(5)
End Type

'APPEND TO the STRING array the STRING item
SUB sAppend(arr() AS STRING , Item AS STRING)
	REDIM PRESERVE arr(LBOUND(arr) TO UBOUND(arr) + 1) AS STRING
	arr(UBOUND(arr)) = Item
END SUB
'APPEND TO the long array the long item
SUB nAppend(arr() as feelingRateDate , Item AS long, item2 as string)
	REDIM PRESERVE arr(LBOUND(arr) TO UBOUND(arr) + 1) AS feelingRateDate
	arr(UBOUND(arr)).rate = Item
	arr(UBOUND(arr)).dt = Item2
	
END SUB
