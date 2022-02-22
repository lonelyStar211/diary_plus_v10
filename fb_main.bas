#include "fltk-c.bi"
#include "sqlite3.bi"
#include "entery.bas"

const database = "diary.db"
const file = ".diary_log.txt"
dim shared as fl_window ptr win
dim shared as fl_window ptr win2
DIM SHARED AS Fl_Text_Editor PTR Editor_text1
DIM SHARED AS Fl_Text_Buffer PTR Buffer_text1
DIM SHARED AS Fl_Text_Editor PTR Editor_text2
DIM SHARED AS Fl_Text_Editor PTR Editor_text3
DIM SHARED AS Fl_Text_Buffer PTR Buffer_text2
DIM SHARED AS Fl_Text_Buffer PTR Buffer_text3
dim shared as fl_choice ptr cho1
dim shared as fl_choice ptr cho2
dim shared as fl_choice ptr cho3
dim shared as fl_choice ptr cho4
dim shared as fl_choice ptr cho5
dim shared as fl_choice ptr cho6
dim shared as Fl_Hor_Value_Slider ptr slid1
dim shared as Fl_Hor_Value_Slider ptr slid2
dim shared as Fl_Hor_Value_Slider ptr slid3
dim shared as Fl_Hor_Value_Slider ptr slid4
dim shared as Fl_Hor_Value_Slider ptr slid5
dim shared as Fl_Hor_Value_Slider ptr slid6
DIM SHARED AS Fl_Button PTR Button_Save
DIM SHARED AS Fl_Button PTR Button_Show
dim shared as sqlite3 ptr db
dim shared as zstring ptr errMsg 'If an error occurs, this pointer will point a the created error message.
redim shared as feelingRateDate sad(any), angry(any), worried(any), happy(any), relaxed(any), bored(any)

'sub create_win2()
	'win2 = fl_windownew(800, 600, "statistic data")
	'Editor_text3 = Fl_Text_EditorNew (10, 10, 780, 580)
	'Buffer_text3 = Fl_Text_BufferNew ()
	'Fl_Text_DisplaySetBuffer (Editor_text3, Buffer_text3)
	'Fl_Text_BufferSetText (Buffer_text3, "")
	'Fl_Text_DisplayWrapMode(editor_text3, WRAP_AT_BOUNDS, 0)
'End Sub

sub create_window()
	'window
	win = fl_windownew(800, 600, "Diary Plus v1.0.0")
	'components
	Editor_text1 = Fl_Text_EditorNew (10, 10, 300, 200)
	Buffer_text1 = Fl_Text_BufferNew ()
	editor_text2 = fl_text_editornew (320, 10, 300, 200)
	buffer_text2 = fl_text_buffernew()
	
	'text_editor 1 and buffer 1
	Fl_Text_DisplaySetBuffer (Editor_text1, Buffer_text1)
	Fl_Text_BufferSetText (Buffer_text1, "please enter here instead of this text how was your day and what happen or what were you doing.")
	Fl_Text_DisplayWrapMode(editor_text1, WRAP_AT_BOUNDS, 0)
	
	fl_text_displaysetbuffer(editor_text2, buffer_text2)
	fl_text_buffersettext(buffer_text2, "please enter here instead of this text what where your thoughts and what where you thinking about.")
	fl_text_displaywrapmode(editor_text2, WRAP_AT_BOUNDS, 0)
	
	'choice items 1 - 7
	cho1 = Fl_ChoiceNew(200,320,128,24,"How did you feel today?:")
	' add item
	Fl_Menu_Add(cho1,"sad")
	Fl_Menu_Add(cho1,"angry")
	Fl_Menu_Add(cho1,"worried")
	Fl_Menu_Add(cho1,"bored")
	Fl_Menu_Add(cho1,"happy")
	Fl_Menu_Add(cho1,"relaxed")
	Fl_Menu_Add(cho1,"-------")
	' insert item
	'Fl_Menu_Insert(cho1,,"bored")
	' select item
	Fl_ChoiceSetValue(cho1,6)
	cho2 = Fl_ChoiceNew(200,350,128,24,"")
	' add item
	Fl_Menu_Add(cho2,"sad")
	Fl_Menu_Add(cho2,"angry")
	Fl_Menu_Add(cho2,"worried")
	Fl_Menu_Add(cho2,"bored")
	Fl_Menu_Add(cho2,"happy")
	Fl_Menu_Add(cho2,"relaxed")
	Fl_Menu_Add(cho2,"-------")
	' select item
	Fl_ChoiceSetValue(cho2,6)
	cho3 = Fl_ChoiceNew(200,380,128,24,"")
	' add item
	Fl_Menu_Add(cho3,"sad")
	Fl_Menu_Add(cho3,"angry")
	Fl_Menu_Add(cho3,"worried")
	Fl_Menu_Add(cho3,"bored")
	Fl_Menu_Add(cho3,"happy")
	Fl_Menu_Add(cho3,"relaxed")
	Fl_Menu_Add(cho3,"-------")
	' select item
	Fl_ChoiceSetValue(cho3,6)
	cho4 = Fl_ChoiceNew(200,410,128,24,"")
	' add item
	Fl_Menu_Add(cho4,"sad")
	Fl_Menu_Add(cho4,"angry")
	Fl_Menu_Add(cho4,"worried")
	Fl_Menu_Add(cho4,"bored")
	Fl_Menu_Add(cho4,"happy")
	Fl_Menu_Add(cho4,"relaxed")
	Fl_Menu_Add(cho4,"-------")
	' select item
	Fl_ChoiceSetValue(cho4,6)
	cho5 = Fl_ChoiceNew(200,440,128,24,"")
	' add item
	Fl_Menu_Add(cho5,"sad")
	Fl_Menu_Add(cho5,"angry")
	Fl_Menu_Add(cho5,"worried")
	Fl_Menu_Add(cho5,"bored")
	Fl_Menu_Add(cho5,"happy")
	Fl_Menu_Add(cho5,"relaxed")
	Fl_Menu_Add(cho5,"-------")
	' select item
	Fl_ChoiceSetValue(cho5,6)
	cho6 = Fl_ChoiceNew(200,470,128,24,"")
	' add item
	Fl_Menu_Add(cho6,"sad")
	Fl_Menu_Add(cho6,"angry")
	Fl_Menu_Add(cho6,"worried")
	Fl_Menu_Add(cho6,"bored")
	Fl_Menu_Add(cho6,"happy")
	Fl_Menu_Add(cho6,"relaxed")
	Fl_Menu_Add(cho6,"-------")
	' select item
	Fl_ChoiceSetValue(cho6,6)
	
	'sliders
	slid1 = Fl_Hor_Value_SliderNew(350,320,180, 20,"")
	Fl_ValuatorSetStep(slid1, 1)
	Fl_ValuatorBounds(slid1 , 1, 100)
	Fl_ValuatorSetValue(slid1 , 50)
	slid2 = Fl_Hor_Value_SliderNew(350,350,180, 20,"")
	Fl_ValuatorSetStep(slid2, 1)
	Fl_ValuatorBounds(slid2 , 1, 100)
	Fl_ValuatorSetValue(slid2 , 50)
	slid3 = Fl_Hor_Value_SliderNew(350,380,180, 20,"")
	Fl_ValuatorSetStep(slid3, 1)
	Fl_ValuatorBounds(slid3 , 1, 100)
	Fl_ValuatorSetValue(slid3 , 50)	
	slid4 = Fl_Hor_Value_SliderNew(350,410,180, 20,"")
	Fl_ValuatorSetStep(slid4, 1)
	Fl_ValuatorBounds(slid4 , 1, 100)
	Fl_ValuatorSetValue(slid4 , 50)	
	slid5 = Fl_Hor_Value_SliderNew(350,440,180, 20,"")
	Fl_ValuatorSetStep(slid5, 1)
	Fl_ValuatorBounds(slid5 , 1, 100)
	Fl_ValuatorSetValue(slid5 , 50)	
	slid6 = Fl_Hor_Value_SliderNew(350,470,180, 20,"Rate between 1 - 100:")
	Fl_ValuatorSetStep(slid6, 1)
	Fl_ValuatorBounds(slid6 , 1, 100)
	Fl_ValuatorSetValue(slid6 , 50)
	
	'button
	Button_Save = Fl_ButtonNew (700, 580, 100, 20, "SAVE")
	Button_Show = Fl_ButtonNew (600, 580, 100, 20, "DATA")
	
	
End Sub

function calc_avg(arr() as feelingRateDate) as LONG
		dim result as LONG
		for i as integer = 1 to ubound(arr)
			result += arr(i).rate
		Next
		result = result / ubound(arr) + 1
		'print "feelings rate: " & ubound(arr)
		return result
End Function

function max_feeling(arr() as feelingRateDate) as string
	if ubound(arr) < 1 then return "no data"
	dim max_feeling_rate_date as feelingRateDate = arr(1)
	for i as INTEGER = 1 to ubound(arr)
		if arr(i).rate > max_feeling_rate_date.rate then
			max_feeling_rate_date = arr(i)
			
		EndIf
	Next
	'print max_feeling_rate_date.dt
	return str(max_feeling_rate_date.rate) & " date: " & max_feeling_rate_date.dt
End Function

function min_feeling(arr() as feelingRateDate) as STRING
	if ubound(arr) < 1 then return "no data"
	dim min_feeling_rate_date as feelingRateDate = arr(1)
	for i as integer = 1 to ubound(arr)
		if arr(i).rate < min_feeling_rate_date.rate then
			min_feeling_rate_date = arr(i)
		EndIf
	Next
	return str(min_feeling_rate_date.rate) & " date: " & min_feeling_rate_date.dt
End Function

FUNCTION callback CDECL (BYVAL NotUsed AS ANY PTR, BYVAL argc AS long, BYVAL argv AS zstring PTR PTR, BYVAL colName AS zstring PTR PTR) AS Long
	DIM AS INTEGER i
	DIM AS STRING text
	? "ARGC:", argc
	FOR i = 0 TO argc - 1
		text = "NULL"
		IF( argv[i] <> 0 ) THEN
			IF *argv[i] <> 0 THEN
				text = *argv[i]
				select case text
					Case "sad"
					nappend sad(), val(*argv[i+6]), *argv[1]
					case "worried"
					nappend worried(), val(*argv[i+6]), *argv[1]
					case "angry"
					nappend angry(), val(*argv[i+6]), *argv[1]
					case "bored"
					nappend bored(), val(*argv[i+6]), *argv[1]
					case "happy"
					nappend happy(), val(*argv[i+6]), *argv[1]
					case "relaxed"
					nappend relaxed(), val(*argv[i+6]), *argv[1]
				End Select
			END IF
		END IF
		PRINT *colName[i], " = '"; text; "'"
	NEXT i
	PRINT
	FUNCTION = 0   
END FUNCTION


'click button save
SUB Button_Save_Event CDECL (widget AS FL_Widget PTR)
	'Callback function for Button
	
	'type entery call
	dim entery as record 
	
	DIM AS STRING text1, text2
	'dim as integer num1
	
	'for log text file
	dim f as long = freefile() 
	
	text1 = *Fl_Text_BufferGetText(buffer_text1)
	text2 = *Fl_Text_BufferGetText(buffer_text2)
	print text1
	print text2
	
	entery.action = *Fl_Text_BufferGetText(buffer_text1)
	entery.thought = *Fl_Text_BufferGetText(buffer_text2)
	
	isnotnull (entery.feeling(0), entery.rate(0) ,Fl_ChoiceGetValue (cho1), Fl_ValuatorGetValue(slid1))
	isnotnull (entery.feeling(1), entery.rate(1) ,Fl_ChoiceGetValue (cho2), Fl_ValuatorGetValue(slid2))
	isnotnull (entery.feeling(2), entery.rate(2) ,Fl_ChoiceGetValue (cho3), Fl_ValuatorGetValue(slid3))
	isnotnull (entery.feeling(3), entery.rate(3) ,Fl_ChoiceGetValue (cho4), Fl_ValuatorGetValue(slid4))
	isnotnull (entery.feeling(4), entery.rate(4) ,Fl_ChoiceGetValue (cho5), Fl_ValuatorGetValue(slid5))
	isnotnull (entery.feeling(5), entery.rate(5) ,Fl_ChoiceGetValue (cho6), Fl_ValuatorGetValue(slid6))
	
	PRINT Fl_ChoiceGetValue (cho1)
	PRINT Fl_ChoiceGetValue (Cho2)
	PRINT Fl_ChoiceGetValue (Cho3)
	PRINT Fl_ChoiceGetValue (Cho4)
	PRINT Fl_ChoiceGetValue (Cho5)
	PRINT Fl_ChoiceGetValue (Cho6)
	
	print Fl_ValuatorGetValue(slid1)
	print Fl_ValuatorGetValue(slid2)
	print Fl_ValuatorGetValue(slid3)
	print Fl_ValuatorGetValue(slid4)
	print Fl_ValuatorGetValue(slid5)
	print Fl_ValuatorGetValue(slid6)
	
	open file for append as #f
	print #f, "Time: " & date & " " & time
	print #f, "Diary: " & entery.action
	print #f, "Toughts: " & entery.thought
	for i as integer = 0 to 5
		print #f, "Feeling num " & i + 1 & ": " &entery.feeling(i) & " ";
		'Next
		'for i as integer = 0 to 5
		print #f, "Felling Rate: " & entery.rate(i)
	Next
	print #f, "--------------------"
	close #f
	
	dim as integer rc = sqlite3_open(database , @db) 'The connection to the test.db database is created.
	
	if (rc <> SQLITE_OK) then
		? "Cannot open database:", sqlite3_errmsg(db)
		sqlite3_close(db)
		end 1
	end if
	
	dim as string cmd
	
	'These SQL statements create a Cars table and fill it with data. The statements must be separated by semicolons.
	cmd = "CREATE TABLE IF NOT EXISTS diary_table1(Id INTEGER PRIMARY KEY AUTOINCREMENT, dt datetime default current_timestamp, diary TEXT, thought TEXT, feel1 TEXT, feel2 TEXT, feel3 TEXT, feel4 TEXT, feel5 TEXT, feel6 TEXT, rate1 INT, rate2 INT,rate3 INT, rate4 INT, rate5 INT, rate6 INT ); " 
	cmd &= "INSERT INTO diary_table1(diary,thought,feel1,feel2,feel3,feel4,feel5,feel6,rate1,rate2,rate3,rate4,rate5,rate6) VALUES('" & entery.action &"','"& entery.thought & "','" & entery.feeling(0)& "','" & entery.feeling(1) & "','" & entery.feeling(2) & "','" & entery.feeling(3) &"' ,'" & entery.feeling(4) & "','" &  entery.feeling(5) & "'," & entery.rate(0) & "," & entery.rate(1) & "," & entery.rate(2) & "," & entery.rate(3) & "," & entery.rate(4) & "," & entery.rate(5) & "); "
	print cmd
	dim as zstring ptr sql = strptr(cmd)
	
	rc = sqlite3_exec(db, sql, 0, 0, @errmsg)
	
	if (rc <> SQLITE_OK ) then
		? "SQL error: ", errmsg
		sqlite3_free(errmsg)     
		sqlite3_close(db)
	end if
	
	sqlite3_close(db)
	
	? "done"
	
END SUB

SUB Button_Show_Event CDECL (widget AS FL_Widget PTR)
	DIM AS INTEGER rc = sqlite3_open(database, @db)
	
	IF (rc <> SQLITE_OK) THEN
		? "Can't open database: ", sqlite3_errmsg(db)
		END 1
	ELSE
		? "Opened database successfully"
	END IF
	
	DIM AS STRING cmd
	
	cmd = "SELECT * from diary_table1;"
	
	DIM AS zstring PTR sql = STRPTR(cmd)
	
	rc = sqlite3_exec (db, sql, @callback, 0, @errmsg)
	
	IF  rc <> SQLITE_OK THEN
		? "SQL error:", *errmsg
	ELSE
		? "Operation done successfully"
	END IF
	sqlite3_close(db)
	? "done"
	dim as long sad_avg = calc_avg(sad())
	dim as long angry_avg = calc_avg(angry())
	dim as long worried_avg = calc_avg(worried())
	dim as long happy_avg = calc_avg(happy())
	dim as long relaxed_avg = calc_avg(relaxed())
	dim as long bored_avg = calc_avg(bored())
	dim as string max_sad = max_feeling(sad())
	dim as string max_worried = max_feeling(worried())
	dim as string max_angry = max_feeling(angry())
	dim as string max_bored = max_feeling(bored())
	dim as string max_happy = max_feeling(happy())
	dim as string max_relaxed = max_feeling(relaxed())
	dim as string min_sad = min_feeling(sad())
	dim as string min_worried = min_feeling(worried())
	dim as string min_angry = min_feeling(angry())
	dim as string min_bored = min_feeling(bored())
	dim as string min_happy = min_feeling(happy())
	dim as string min_relaxed = min_feeling(relaxed())
	win2 = fl_windownew(800, 600, "statistic data")
	Editor_text3 = Fl_Text_EditorNew (10, 10, 780, 580)
	Buffer_text3 = Fl_Text_BufferNew ()
	Fl_Text_DisplaySetBuffer (Editor_text3, Buffer_text3)
	'Fl_Text_BufferSetText (Buffer_text3, "")
	Fl_Text_Bufferappend (Buffer_text3, "SAD FEELING AVG: " & str(sad_avg) & !"\n")
	Fl_Text_Bufferappend (Buffer_text3, "ANGRY FEELING AVG: " & str(angry_avg) & !"\n")
	Fl_Text_Bufferappend (Buffer_text3, "WORRIES FEELING AVG: " & str(worried_avg) & !"\n")
	Fl_Text_Bufferappend (Buffer_text3, "HAPPINESS FEELING AVG: " & str(happy_avg) & !"\n")
	Fl_Text_Bufferappend (Buffer_text3, "RELAXED FEELING AVG: " & str(relaxed_avg) & !"\n")
	Fl_Text_Bufferappend (Buffer_text3, "BORED FEELING AVG: " & str(bored_avg) & !"\n")
	Fl_Text_Bufferappend (Buffer_text3, "-----------------------------------" & !"\n")
	Fl_Text_Bufferappend (Buffer_text3, "SAD MAX FEELING: " & max_sad & !"\n")
	Fl_Text_Bufferappend (Buffer_text3, "ANGRY MAX FEELING: " & max_angry & !"\n")
	Fl_Text_Bufferappend (Buffer_text3, "WOORIES MAX FEELING: " & max_worried & !"\n")
	Fl_Text_Bufferappend (Buffer_text3, "HAPPINESS MAX FEELING: " & max_happy & !"\n")
	Fl_Text_Bufferappend (Buffer_text3, "RELAXED MAX FEELING: " & max_relaxed & !"\n")
	Fl_Text_Bufferappend (Buffer_text3, "BORED MAX FEELING: " & max_bored & !"\n")
	Fl_Text_Bufferappend (Buffer_text3, "-----------------------------------" & !"\n")
	Fl_Text_Bufferappend (Buffer_text3, "SAD MIN FEELING: " & min_sad & !"\n")
	Fl_Text_Bufferappend (Buffer_text3, "ANGRY MIN FEELING: " & min_angry & !"\n")
	Fl_Text_Bufferappend (Buffer_text3, "WOORIES MIN FEELING: " & min_worried & !"\n")
	Fl_Text_Bufferappend (Buffer_text3, "HAPPINESS MIN FEELING: " & min_happy & !"\n")
	Fl_Text_Bufferappend (Buffer_text3, "RELAXED MIN FEELING: " & min_relaxed & !"\n")
	Fl_Text_Bufferappend (Buffer_text3, "BORED MIN FEELING: " & min_bored & !"\n")
	Fl_Text_DisplayWrapMode(editor_text3, WRAP_AT_BOUNDS, 0)
	
	'create_win2()
	fl_windowshow(win2)
	sad_avg = 0
	angry_avg = 0
	worried_avg = 0
	happy_avg = 0
	relaxed_avg = 0
	bored_avg = 0
	'redim shared as long sad(any), angry(any), worried(any), happy(any), relaxed(any), bored(any)
	erase sad, angry, worried, happy, relaxed, bored
End Sub


create_window()
Fl_WidgetSetCallback0 (Button_Save, @Button_Save_Event())
Fl_WidgetSetCallback0 (Button_Show, @Button_Show_Event())
Fl_WindowShow(win)

Fl_Run()

end