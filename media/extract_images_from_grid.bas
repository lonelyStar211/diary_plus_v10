#include "FBImage.bi"

function PinkToAlgha(byval img as any ptr) as boolean
  dim as integer iWidth,iHeight,iBytes,iPitch
  dim as ulong ptr row
  if ImageInfo(img,iWidth,iHeight,iBytes,iPitch,row) then return false
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

function ExtractFromGrid(byval fileName as string, _
                         byval filePrefix as string, _
                         byval gridCellSize as integer, _
                         byval xOffset as integer=0, _
                         byval yOffset as integer=0, _
                         byval xGab    as integer=0, _
                         byval yGab    as integer=0) as integer
  dim as integer iWidth,iHeight,iBytes,iPitch 
  if gridCellSize <=1 then return false
  var grid = LoadRGBAFile(fileName) : if grid = 0 then return 0
  screenres 640,480,32,,-1
  if ImageInfo(grid,iWidth,iHeight,iBytes,iPitch) then screen 0: return 0
  screenres iWidth,iHeight,32
  put (0,0),grid,PSET
  windowtitle "source: " & iWidth & " x " & iHeight
  var nRows   = (iHeight-yOffset)/(gridCellSize+yGab)
  var nCols   = (iWidth -xOffset)/(gridCellSize+xGab)
  var nImages = 0
  var cell = ImageCreate(gridCellSize,gridCellSize)
  for y as integer = 0 to nRows-1
    for x as integer = 0 to nCols-1
      get grid, (xOffset+x*(gridCellSize+xGab),yOffset+y*(gridCellSize+yGab)) - step(gridCellSize-1,gridCellSize-1),cell
      line      (xOffset+x*(gridCellSize+xGab),yOffset+y*(gridCellSize+yGab)) - step(gridCellSize-1,gridCellSize-1),0,BF
      sleep 100
      put (xOffset+x*(gridCellSize+xGab),yOffset+y*(gridCellSize+yGab)),cell,PSET
      fileName = filePrefix & nImages & "_" & gridCellSize & "x" & gridCellSize & ".png"
      windowtitle fileName
      if SavePNGFile(cell,fileName,true)=false then 
        ImageDestroy cell
        screen 0 : beep : return nImages
      end if

      nImages+=1
    next
  next  
  ImageDestroy cell
  screen 0
  return nImages
end function

'
' main
'
var fileName = "free-design-icons_32x32.png"
var filePrefix = "icon_"
ChDir(ExePath())
var nImages = ExtractFromGrid(fileName, filePrefix, 32, 15,0,5,5)
if nImages<1 then
  print "error: no images extracted from '" & fileName & "' !"
  beep
else
  print "" & nImages & " images from '" & fileName & "' extracted"
end if  
print "..." : sleep
