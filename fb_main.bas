#include "fltk-c.bi"

dim shared as fl_window ptr win
DIM SHARED AS Fl_Text_Editor PTR Editor_text1
DIM SHARED AS Fl_Text_Buffer PTR Buffer_text1
DIM SHARED AS Fl_Text_Editor PTR Editor_text2
DIM SHARED AS Fl_Text_Buffer PTR Buffer_text2
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

sub create_window()
	'window
	win = fl_windownew(800, 600, "Diary Plus v1.0.0")
	'components
	Editor_text1 = Fl_Text_EditorNew (10, 10, 300, 200)
	Buffer_text1 = Fl_Text_BufferNew ()
	editor_text2 = fl_text_editornew(320, 10, 300, 200)
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
	Fl_Menu_Add(cho1,"depressed")
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
	Fl_Menu_Add(cho2,"depressed")
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
	Fl_Menu_Add(cho3,"depressed")
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
	Fl_Menu_Add(cho4,"depressed")
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
	Fl_Menu_Add(cho5,"depressed")
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
	Fl_Menu_Add(cho6,"depressed")
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
	slid6 = Fl_Hor_Value_SliderNew(350,470,180, 20,"Rate between 0 - 100:")
	Fl_ValuatorSetStep(slid6, 1)
	Fl_ValuatorBounds(slid6 , 1, 100)
	Fl_ValuatorSetValue(slid6 , 50)
	
	'button
	Button_Save = Fl_ButtonNew (700, 580, 100, 20, "SAVE")
	
	
End Sub

'click button save
SUB Button_Save_Event CDECL (widget AS FL_Widget PTR)
	'Callback function for Button
	
	DIM AS STRING text1, text2
	'dim as integer num1
	
	text1 = *Fl_Text_BufferGetText(buffer_text1)
	text2 = *Fl_Text_BufferGetText(buffer_text2)
	print text1
	print text2
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
	
END SUB


create_window()

Fl_WindowShow(win)
Fl_WidgetSetCallback0 (Button_Save, @Button_Save_Event())
Fl_Run()

end