#!/bin/bash

# Wiki Oficial
# https://trac.ffmpeg.org/wiki

# https://trac.ffmpeg.org/wiki/Encode/HighQualityAudio
# http://howto-pages.org/ffmpeg/

# Metadata
# https://wiki.multimedia.cx/index.php/FFmpeg_Metadata
# 
# Codecs (https://www.ffmpeg.org/ffmpeg-codecs.html)
# H.264 https://trac.ffmpeg.org/wiki/Encode/H.264
# H.265 https://trac.ffmpeg.org/wiki/Encode/H.265 (HEVC)
# 
# Parametros mais comuns:
# Videos https://trac.ffmpeg.org/wiki/Encode/H.264
# -c:v libx265 
# -preset ultrafast (ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow and placebo)
# 
#
#
# Audio 
# -c:a aac (aac, libmp3lame,...)
# -b:a 64k (bitrate sample: 8, 16, 24, 32, 40, 48, 64, 80, 96, 112, 128, 160, 192, 224, 256, or 320 com k no final)
# -ar 44100 (frequencia, )
#

# ATEMPO range 05 ... 2


[[ -f /usr/bin/ffmpeg ]] || { return ; }

# https://unix.stackexchange.com/questions/283878/ffmpeg-creating-a-video-clip-of-approx-10-seconds-when-video-duration-is-unkn
FFMPEG_CLIP10s=" -threads 6 -ss 00:00:0.0 -t 10 -a"



ct_ffmpeg_speedUpVideoOnly() {
  : ${1?' <video input>'}
  : ${2?' <video output>'}
  : ${3?' <time to accelerate>'}
  ffmpeg -i "$1" -filter:v "setpts=PTS/$3" "$2"
}



# sudo apt install mediainfo
ct_video_info() {
  mediainfo "$1"
}

# Check if video is valid
ct_video_isValid() {
  ffmpeg -v error -i "$1" -f null - 2
}



ct_ffmpeg_convertToOdysee() {
  ffmpeg -i "$1" -c:v libx264 -crf 21 -preset faster -pix_fmt yuv420p -maxrate 5000K -bufsize 5000K -vf 'scale=if(gte(iw\,ih)\,min(1920\,iw)\,-2):if(lt(iw\,ih)\,min(1920\,ih)\,-2)' -movflags +faststart -c:a aac -b:a 128k "$2"
}







































ct_mp4tohevc1() {
  # Video
  # FPS = 10 (-r), codec = libx265, Constant Rate Factor = 25 (0-50 => 0 lowless)
  #
  #
  #
  mkdir -p conv
  ffmpeg -i "$1" -preset ultrafast -c:v libx265 -crf 25 -r 10 -c:a libmp3lame -ac 1 -b:a 64k -ar 32000 -metadata title="EVP" "conv/$1"
}

mp4tohevc1_all()
{
  for i in *.mp4
  do
    ct_mp4tohevc1 "$i"
  done
}

# $1 nome do arquivo de saida $1
vob2mp4_template1()
{
  ffmpeg -i "concat:$(echo *.VOB|tr \  \|)" -f mp4 -c copy -sn -y -preset ultrafast -c:v libx265 -crf 25 -c:a libmp3lame -ac 1 -b:a 96k -ar 44100 "$1.mp4"
}

vob2mp4_templateOA()
{
  if test ! -f "../_mp4/$1.mp4" 
  then
    ffmpeg -i "concat:$(echo *.VOB|tr \  \|)" -f mp4 -c copy -sn -y -preset ultrafast -c:v libx265 -crf 25 -r 15 -c:a libmp3lame -ac 1 -b:a 96k -ar 44100 \
    -metadata album="O Amanhã Hoje" -metadata comment="www.advertenciafinal.com.br / youtube.com/tvadvertenciafinal" \
    -metadata copyright="Ministério Quarto Anjo - Advertência Final" -metadata author="Ministério Quarto Anjo" \
    -metadata album_artist="Ministério Quarto Anjo - O Amanhã Hoje" \
    "../_mp4/$1.mp4"
  fi
}


ct_ffmpeg_SliceVideo() {
  local VIDEO_FILE="$1"
  local TIME_START="$2" # 00:00:00
  local TIME_END="$3" # 00:00:00

  mkdir -p slice
  echo_and_run ffmpeg -i "${VIDEO_FILE}" -ss "${TIME_START}" -c copy -to "${TIME_END}" "slice/${VIDEO_FILE}"
}

## https://superuser.com/questions/624563/how-to-resize-a-video-to-make-it-smaller-with-ffmpeg
## https://en.wikipedia.org/wiki/Display_resolution
ct_ffmpeg_resizeScale() {

	$HELPTXT "Tamanhos: 
https://en.wikipedia.org/wiki/Graphics_display_resolution#Video_Graphics_Array
https://en.wikipedia.org/wiki/Display_resolution

Name	H (px)	V (px)	H:V	H × V (Mpx)
QQVGA	160	120	4:03	19
HQVGA	240	160	3:02	38
256	160	16:10	43	
QVGA	320	240	4:03	77
WQVGA	384	240	16:10	92
WQVGA	360	240	3:02	86
WQVGA	400	240	5:03	96
HVGA	480	320	3:02	154
VGA	640	480	4:03	307
WVGA	768	480	16:10	368
WVGA	720	480	3:02	345
WVGA	800	480	5:03	384
FWVGA	≈854	480	16:09	410
SVGA	800	600	4:03	480
WSVGA	1024	576	16:09	590
WSVGA	1024	600	128:75	614
DVGA	960	640	3:02	614


Standard	Aspect ratio	Width (px)	Height (px)

nHD	16:09	640	360
SVGA	4:03	800	600
XGA	4:03	1024	768
WXGA	16:09	1280	720
WXGA	16:10	1280	800
SXGA	5:04	1280	1024
HD	≈16:9	1360	768
HD	≈16:9	1366	768
WXGA+	16:10	1440	900
HD+	16:09	1600	900
WSXGA+	16:10	1680	1050
FHD	16:09	1920	1080
WUXGA	16:10	1920	1200
QWXGA	16:09	2048	1152
QHD	16:09	2560	1440
4K UHD	16:09	3840	2160

"
	ct_help $1

  ${1?' video_source'}
  ${2?' video_output'}
  local scale=${3:-"1980:1020"};

  echo_and_run ffmpeg -i "$1" -vf scale=$scale,setsar=1:1 "$2"
}


evp_metadados() {

  local titulo="$1"
  local autor="$2"
  local albun="$3"
  local ano="$5"
  local copy="EVP"
  local descricao="$4"

  echo '-metadata title="'$titulo'" -metadata author="'$autor'" -metadata copyright="'$copy'" -metadata description="'$descricao'" -metadata album="'$albun'" -metadata year="'$ano'" ' 
 }


evp_convert_all() {
  export PATH=$PATH:/p/programas/video/
  local titulo=""
  mkdir -p conv
  for i in *.mp4
  do 
    if test ! -f "conv/$i" 
    then
      echo "============ $i ================"
      titulo=`echo "$i" | cut -d "_" -f 2`
      titulo=`basename "$titulo" .mp4`
      ffmpeg -i "$i" -preset ultrafast -c:v libx265 -crf 20 -r 10 -c:a libmp3lame -ac 1 -b:a 64k -ar 32000 \
      -metadata title="$titulo" -metadata author="$1" -metadata copyright="EVP" \
      -metadata comment="EVP.com.br" -metadata album="$2"  "conv/$i"
      echo
      echo 
    fi
  done
}

evp_convert_all_dir()
{
  for j in *
  do 
    cd $j
    echo "====== Diretorio: $j ======="
    evp_convert_all
    cd ..
  done
}


deezerMp3Convert() {
  mkdir -p conv
  for i in *.mp3
  do
    if test ! -f "conv/$i" 
     then
      echo "============ $i ================"
      ffmpeg -i "$i" -c:a libmp3lame -ac 2 -b:a 96k -ar 44100  "conv/$i"
    fi
  done
}

deezerMp3ConvertBiblia() {
  mkdir -p conv
  for i in *.mp3
  do
    if test ! -f "conv/$i" 
     then
      echo "============ $i ================"
      ffmpeg -i "$i" -c:a libmp3lame -ac 1 -b:a 64k -ar 32000  "conv/$i"
    fi
  done
}



#https://gist.github.com/protrolium/e0dbd4bb0f1a396fcb55
# https://pt.wikipedia.org/wiki/MP3
mp4TOmp3(){
  mkdir -p mp3
  for i in *.mp4
  do
    ffmpeg -n -i "$i" -ac 1 -ab 24000 -ar 32000 -f mp3 "mp3/$i.mp3"
  done
}

mp4TOmp3_44khz(){
  mkdir -p mp3-44khz
  for i in *.mp4
  do
    ffmpeg -n -i "$i" -ac 1 -ab 64000 -ar 44100 -f mp3 "mp3-44khz/$i.mp3"
  done
}

mkvTOmp4()
{
  ffmpeg -i "$1" -codec copy "$1.mp4"
}

videoClip() {
  mkdir -p tmp;
  ffmpeg -i "$1" -ss 00:00:0.0 -t 10 "tmp/$1";
}

videoAudioDelay() {
  # DELAYING THE AUDIO OR THE VIDEO
  # http://howto-pages.org/ffmpeg/#delay
  # http://alien.slackbook.org/blog/fixing-audio-sync-with-ffmpeg/
  # https://superuser.com/questions/982342/in-ffmpeg-how-to-delay-only-the-audio-of-a-mp4-video-without-converting-the-au
  echo;
}


ffmpeg_changeSpeed() {
  mkdir -p speed
  local speed=$2
  # ffmpeg.exe -i input.mp4 -filter_complex "[0:v]setpts=PTS/1.3[v];[0:a]atempo=1.3[a]" -map "[v]" -map "[a]" output.mp4
  ffmpeg -i "$1" \
    -filter_complex "[0:v]setpts=PTS/$speed[v];[0:a]atempo=$speed[a]" -map "[v]" -map "[a]" \
    "speed/$1"
}

ffmpeg_changeSpeed32k44khz() {
  mkdir -p speed
  local speed="1.3"
  # ffmpeg.exe -i input.mp4 -filter_complex "[0:v]setpts=PTS/1.3[v];[0:a]atempo=1.3[a]" -map "[v]" -map "[a]" output.mp4
  ffmpeg -i "$1" -ac 1 -ab 32000 -ar 44100 -f mp3 -filter_complex "[0:v]setpts=PTS/"$speed"[v];[0:a]atempo="$speed"[a]" -map "[v]" -map "[a]" "speed/$1"
}


mp4ToLow() {
  mkdir -p "conv"
  ffmpeg -i "$1" -preset faster -c:v libx265 -crf 22 -r 10 -c:a libmp3lame -ac 1 -b:a 64k -ar 32000 "conv/$1"
}


mp4ToLow4fps() {
  mkdir -p "conv"
  ffmpeg -i "$1" -preset faster -c:v libx265 -crf 22 -r 4 -c:a libmp3lame -ac 1 -b:a 64k -ar 32000 "conv/$1"
}


mp4ToScale320x240() {
  mkdir -p "conv"
  ffmpeg -i "$1" -vf scale=320:240 "conv/$1"
}


mp4ToScale320x240Low() {
  mkdir -p "conv"
  ffmpeg -i "$1" -vf scale=320:240 -preset ultrafast -c:v libx265 -crf 20 -r 10 -c:a libmp3lame -ac 1 -b:a 64k -ar 32000 "conv/$1"
}




# https://trac.ffmpeg.org/wiki/How%20to%20speed%20up%20/%20slow%20down%20a%20video
# The atempo filter is limited to using values between 0.5 and 2.0 
# (so it can slow it down to no less than half the original speed, and speed up 
# to no more than double the input). If you need to, you can get around this limitation 
# by stringing multiple atempo filters together. The following with quadruple the audio speed:
mp3ChangeSpeedCurrentFolder() {
  local speed="$1"
  local folderOut=conv$speed
  mkdir -p $folderOut
  for i in *.mp3
  do
    if test ! -f "$folderOut/$i" 
     then
      echo "============ $i ================"
      _mp3ChangeSpeed "$i" $speed
    fi
  done
}

_mp3ChangeSpeed() {
  local file="$1"
  local speed=$2
  local folderOut=conv$speed

  ffmpeg -i "$file" -filter:a "atempo=$speed,atempo=$speed" -c:a libmp3lame -ac 1 -b:a 64k -ar 32000 -vn "$folderOut/$file"
}


# https://www.onlineconverter.com/change-video-speed
_videoChangeSpeed() {
  local file="$1"
  local speed=$2
  mkdir -p "conv";
  
  ffmpeg -i "$file" -filter_complex "[0:v]setpts=$speed*PTS[v];[0:a]atempo=$speed[a]" -map "[v]" -map "[a]" "conv/$file";
}

ct_mencoderChangeSpeedVideo() {
  local file="$1"
  local speed=$2
  mkdir -p "conv";
  mencoder -speed $speed -o "$file" -ovc lavc "conv/$file";
}
