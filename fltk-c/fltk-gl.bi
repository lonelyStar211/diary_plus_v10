#ifndef __FLTK_GL_BI__
#define __FLTK_GL_BI__

#ifndef __FB_ARM__

'  FreeBASIC header file for the Fast Light Tool Kit C wrapper.
'  FLTK C wrapper copyright 2013-2019 by D.J.Peters

'  C++ library Fast Light Tool Kit (FLTK)
'  Copyright 1998-2010 by Bill Spitzak and others.
' 
'  This library is free software. Distribution and use rights are outlined in
'  the file "COPYING" which should have been included with this file.  If this
'  file is missing or damaged, see the license at:
' 
'    http:www.fltk.org/COPYING.php
' 
'  Please report all FLTK C wrapper bugs and problems on the following page:
' 
'    http://www.freebasic.net/forum/viewtopic.php?f=14&t=24547

#ifndef __FLTK_MAIN_BI__
 #include once "fltk-c/fltk-main.bi"
#endif

#include once "GL/gl.bi"

' ########################################
' # class Fl_GL_Window extends Fl_Window #
' ########################################
Fl_Extends(Fl_GL_Window,Fl_Window)
 Fl_Extends(Fl_GL_WindowEx,Fl_GL_Window)


' Returns an Fl_Gl_Window pointer if this widget is an Fl_Gl_Window
declare function Fl_WidgetAsGL_Window(byval wgt as Fl_Widget ptr) as Fl_GL_Window ptr

' Fl_Gl_Window mode (values match Glut)
type FL_MODE as ulong
const as FL_MODE FL_MODE_RGB                      = &H000 ' default
const as FL_MODE FL_MODE_SINGLE                   = &H000
const as FL_MODE FL_MODE_INDEX                    = &H001
const as FL_MODE FL_MODE_DOUBLE                   = &H002 ' default
const as FL_MODE FL_MODE_ACCUM                    = &H004
const as FL_MODE FL_MODE_ALPHA                    = &H008
const as FL_MODE FL_MODE_DEPTH                    = &H010 ' default
const as FL_MODE FL_MODE_STENCIL                  = &H020
const as FL_MODE FL_MODE_RGB8                     = &H040
const as FL_MODE FL_MODE_MULTISAMPLE              = &H080
const as FL_MODE FL_MODE_STEREO                   = &H100
const as FL_MODE FL_MODE_FAKE_SINGLE              = &H200 ' Fake single buffered windows using double-buffer


extern "C"


' ###################
' # FLTK GL drawing #
' ###################
declare sub      glDrawSetColor(byval c as Fl_COLOR)

declare sub      glDrawRect(byval x as long, byval y as long, byval w as long, byval h as long)

declare sub      glDrawRectFill(byval x as long, byval y as long, byval w as long, byval h as long)

declare sub      glDrawSetFont(byval font as FL_FONT, byval size as FL_FONTSIZE)

declare function glDrawGetFontHeight() as long

declare function glDrawGetFontDescent() as long

declare function glDrawGetStrWidth (byval txt as const zstring ptr) as double

declare function glDrawGetStrWidth2(byval txt as const zstring ptr, byval nChars as long) as double

declare function glDrawGetCharWidth(byval c as ubyte) as double

declare sub      glDrawStrMeasure  (byval txt as const zstring ptr, byref x as long, byref y as long)

declare sub      glDrawStr         (byval txt as const zstring ptr)

declare sub      glDrawStr2        (byval txt as const zstring ptr, byval nChars as long)

declare sub      glDrawStrAti      (byval txt as const zstring ptr, byval x as long, byval y as long)

declare sub      glDrawStrAti2     (byval txt as const zstring ptr, byval nChars as long, byval x as long, byval y as long)

declare sub      glDrawStrAtf      (byval txt as const zstring ptr, byval x as single, byval y as single)

declare sub      glDrawStrAtf2     (byval txt as const zstring ptr, byval nChars as long, byval x as single, byval y as single)

declare sub      glDrawStrBox      (byval txt as const zstring ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval align as FL_ALIGN)

declare sub      glDrawImage       (byval buffer as const ubyte ptr, byval x as long, byval y as long, byval w as long, byval h as long, byval BytesPerPixel as long=3, byval pitch as long=0)


'########################################
'# class Fl_Gl_Window extends Fl_Window #
'########################################
declare function Fl_Gl_WindowNew(byval w as long, byval h as long, byval title as const zstring ptr=0) as Fl_Gl_Window ptr

declare function Fl_Gl_WindowNew2(byval x as long, byval y as long, byval w as long, byval h as long, byval title as const zstring ptr=0) as Fl_Gl_Window ptr

declare sub      Fl_Gl_WindowDelete(byref win as Fl_Gl_Window ptr)

declare function Fl_Gl_WindowHandle(byval win as Fl_Gl_Window ptr, byval ev as FL_EVENT) as long

declare function Fl_Gl_WindowCanDo(byval win as Fl_Gl_Window ptr) as long
declare function Fl_Gl_WindowCanDoOverlay(byval win as Fl_Gl_Window ptr) as long

declare sub      Fl_Gl_WindowSetContext(byval win as Fl_Gl_Window ptr, byval ctx as any ptr, byval destroy_flag as long=0)
declare function Fl_Gl_WindowGetContext(byval win as Fl_Gl_Window ptr) as any ptr

declare sub      Fl_Gl_WindowSetContextValid(byval win as Fl_Gl_Window ptr, byval v as long)
declare function Fl_Gl_WindowGetContextValid(byval win as Fl_Gl_Window ptr) as long

declare sub      Fl_Gl_WindowSetValid(byval win as Fl_Gl_Window ptr, byval v as long)
declare function Fl_Gl_WindowGetValid(byval win as Fl_Gl_Window ptr) as long

declare sub      Fl_Gl_WindowFlush(byval win as Fl_Gl_Window ptr)

declare sub      Fl_Gl_WindowInvalidate(byval win as Fl_Gl_Window ptr)

declare sub      Fl_Gl_WindowMakeCurrent(byval win as Fl_Gl_Window ptr)

declare sub      Fl_Gl_WindowHideOverlay(byval win as Fl_Gl_Window ptr)

declare sub      Fl_Gl_WindowMakeOverlayCurrent(byval win as Fl_Gl_Window ptr)

declare sub      Fl_Gl_WindowRedrawOverlay(byval win as Fl_Gl_Window ptr)

declare sub      Fl_Gl_WindowSetMode(byval win as Fl_Gl_Window ptr, byval m as FL_MODE)
declare function Fl_Gl_WindowGetMode(byval win as Fl_Gl_Window ptr) as FL_MODE

declare sub      Fl_Gl_WindowOrtho(byval win as Fl_Gl_Window ptr)

declare sub      Fl_Gl_WindowResize(byval win as Fl_Gl_Window ptr, byval x as long, byval y as long, byval w as long, byval h as long)

declare sub      Fl_Gl_WindowSwapBuffers(byval win as Fl_Gl_Window ptr)

declare sub      Fl_Gl_WindowHide(byval win as Fl_Gl_Window ptr)

declare sub      Fl_Gl_WindowShow(byval win as Fl_Gl_Window ptr)

declare sub      Fl_Gl_WindowShowArgs(byval win as Fl_Gl_Window ptr, byval argc as long, byval argv as zstring ptr ptr)

'#############################################
'# class Fl_Gl_WindowEx extends Fl_GL_Window #
'#############################################
declare function Fl_Gl_WindowExNew(byval w as long, byval h as long, byval title as const zstring ptr=0) as Fl_Gl_WindowEx ptr

declare function Fl_Gl_WindowExNew2(byval x as long, byval y as long, byval w as long, byval h as long, byval title as const zstring ptr=0) as Fl_Gl_WindowEx ptr

declare sub      Fl_Gl_WindowExDelete          (byref win as Fl_Gl_WindowEx ptr)

declare function Fl_Gl_WindowExHandleBase      (byval win as Fl_Gl_WindowEx ptr, byval event as FL_EVENT) as long

declare sub      Fl_Gl_WindowExSetDestructorCB (byval win as Fl_Gl_WindowEx ptr, byval cb as Fl_DestructorEx)

declare sub      Fl_Gl_WindowExSetDrawCB       (byval win as Fl_Gl_WindowEx ptr, byval cb as Fl_DrawEx)

declare sub      Fl_Gl_WindowExSetDrawOverlayCB(byval win as Fl_Gl_WindowEx ptr, byval cb as Fl_Draw_OverlayEx)

declare sub      Fl_Gl_WindowExSetHandleCB     (byval win as Fl_Gl_WindowEx ptr, byval cb as Fl_HandleEx)

declare sub      Fl_Gl_WindowExSetResizeCB     (byval win as Fl_Gl_WindowEx ptr, byval cb as Fl_ResizeEx)


end extern

#endif ' __FB_ARM__

#endif ' __FLTK_GL_BI__
