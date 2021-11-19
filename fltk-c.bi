#ifndef __FLTK_C_BI__
#define __FLTK_C_BI__

'  FreeBASIC header file for the Fast Light Tool Kit C wrapper.
'  FLTK C wrapper copyright 2013-2019 by D.J.Peters

'  C++ library Fast Light Tool Kit (FLTK)
'  Copyright 1998-2010 by Bill Spitzak and others.
' 
'  This library is free software. Distribution and use rights are outlined in
'  the file "COPYING" which should have been included with this file.  If this
'  file is missing or damaged, see the license at:
' 
'    http://www.fltk.org/COPYING.php
' 
'  Please report all FLTK C wrapper bugs and problems on the following page:
'
'    http://www.freebasic.net/forum/viewtopic.php?f=14&t=24547
'
#include once "fltk-c/fltk-main.bi"
#include once "fltk-c/fltk-tools.bi"

#ifndef __FB_ARM__
 #include once "fltk-c/fltk-gl.bi"
 #include once "fltk-c/fltk-glut.bi"
#endif

#endif ' __FLTK_C_BI__
