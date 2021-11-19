#ifndef __FBImage_bi__
#define __FBImage_bi__


#ifdef __FB_WIN32__
# libpath "lib/win/"
#else
# libpath "lib/lin/"
#endif

#ifndef __FB_64BIT__
# inclib "FBImage-32-static"
#else
# inclib "FBImage-64-static"
#endif


' Load BMP, PNG, JPG, TGA, DDS from file or memory as FBImage

' screenres 640,480,32 ' <--- RGBA
' var jpg = LoadRGBAFile("test_rgb.jpg")
' put (0,0),jpg,PSET
'
' var png = LoadRGBAFile("test_rgba.png")
' put (256,0),png,ALPHA

' var img = LoadRGBAFile("filenotfound.xxx")
' if img=0 then
'   print "error: loading filenotfound.xxx " & *GetLastResult()
' end if

' Save RGB image as PNG
' var ok = SavePNGFile(img,"test_rgb.png")

' Save RGBA image as PNG
' var ok = SavePNGFile(img,"test_rgba.png",true)

extern "C"

declare function LoadRGBAFile(byval filename as const zstring ptr) as any ptr

declare function LoadRGBAMemory(byval buffer as const any ptr, byval buffersize as long) as any ptr

declare function GetLastResult() as const zstring ptr

declare function SavePNGFile (byval img as any ptr, byval filename as const zstring ptr,byval saveAlpha as boolean=false) as boolean

end extern

' load (32bit) RGBA image and convert it for 16 bit RGB mode
function Load16BitRGB(filename as const zstring ptr) as any ptr
  #define RGB16(_r,_g,_b) ((((_b) shr 3) shl 11) or (((_g) shr 2) shl 5) or ((_r) shr 3))
  var imgSrc = LoadRGBAFile(filename)
  if imgSrc=0 then return 0
  dim as integer w,h,spitch,dpitch
  dim as ubyte ptr s
  imageinfo imgSrc,w,h,,spitch,s
  var imgDst = ImageCreate(w,h,0,16)
  dim as ushort ptr d
  imageinfo imgDst,,,,dpitch,d 
  dpitch shr= 1 ' pitch in bytes to pitch in pixels
  for y as integer =1 to h
    dim as integer i
    for x as integer =0 to w-1
      d[x] = RGB16(s[i],s[i+1],s[i+2]) 
      i+=4 ' next source pixel
    next
    s+=spitch ' next src row
    d+=dpitch ' next dst row
  next
  ImageDestroy imgSrc
  return imgDst
  #undef RGB16
end function

namespace Base64
  static as string*64 B64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" _
                          & "abcdefghijklmnopqrstuvwxyz" _
                          & "0123456789+/"

  Function EncodeMemory(buffer as any ptr,size as long) As String
    #define E0 (S[j] shr 2)
    #define E1 (((S[j] and &H03) shl 4) + (S[j+1] shr 4))
    #define E2 (((S[j+1] and &H0F) shl 2) + (S[j+2] shr 6))
    #define E3 (S[j+2] and &H3F)
    dim as long nChars = size
    if nChars=0 then return ""
    dim as ubyte ptr S=buffer
    dim as long j,k,m = nChars mod 3
    dim as string r=string(((nChars+2)\3)*4,"=")
    nChars-= (m+1)
    For j = 0 To nChars Step 3
      r[k]=B64[e0] : r[k+1]=B64[e1] : r[k+2]=B64[e2] : r[k+3]=B64[e3]:k+=4
    Next
    if m then
      r[k]=B64[e0] : r[k+1]=B64[e1] : r[k+3]=61
      If m = 2 Then r[k+2]=B64[e2] Else  r[k+2]=61
    end if
    return r
    #undef E0
    #undef E1
    #undef E2
    #undef E3
  End Function

  Function DecodeMemory(s As String,byref nBytes as integer) As any ptr
    #define P0(p) instr(B64,chr(s[n+p]))-1
    dim as long nChars=Len(s)
    if nChars<1 then return 0
    nBytes=nChars : nChars-=1
    dim as ubyte ptr O,buffer=callocate(nBytes)
    O=buffer
    for n As long = 0 To nChars Step 4
      var b = P0(1), c = P0(2), d = P0(3)
      if b>-1 then
        var a = P0(0) : *O = (a shl 2 + b shr 4) : O+=1
      end if
      if c>-1 then *O = (b shl 4 + c shr 2) : O+=1
      if d>-1 then *O = (c shl 6 + d) : O+=1
    next
    return buffer
    #undef P0
  end function
end namespace  



#endif ' __FBImage_bi__
