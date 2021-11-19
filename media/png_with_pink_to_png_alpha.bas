#include "FBImage.bi"

function PinkToAlgha(byval img as any ptr) as boolean
  dim as integer iWidth,iHeight,iBytes,iPitch
  dim as ulong ptr row
  if ImageInfo(img,iWidth,iHeight,iBytes,iPitch,row) then return false
  if iBytes<4 then return false
  iPitch shr=2 ' bytes to pixels
  for y as integer = 0 to iHeight-1
    for x as integer = 0 to iWidth-1
      var col32 = row[x]
      ' if pink
      if col32=&HFFFF00FF then
        ' clear alpha byte
        col32=col32 and &H00FF00FF
        ' write alpha pixel
        row[x]=col32
      end if  
    next  
    row+=iPitch ' next row
  next
  return true
end function
'
' main
'
ChDir(ExePath())
'screenres 8,8,32,,-1
var fileName = dir("*.png")
while len(fileName)
  print "work on: " & fileName
  var img = LoadRGBAFile(fileName)
  if img then
    print "loaded: " & fileName
    if PinkToAlgha(img) then
      if SavePNGFile(img,fileName,true)=false then
        print "saved : " & fileName 
      else
        print "error : writing " & fileName  & " !"
      end if
    else
      print "error: while convert '" & fileName & "' !"
    end if
    imagedestroy(img)
  else
    print "error: can't read '" & fileName & "' !"
  end if  
  fileName = dir()
wend
print "..." : sleep
