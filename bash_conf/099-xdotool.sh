#http://xmodulo.com/simulate-key-press-mouse-movement-linux.html

# Use o comand xprop para mostrar detalhes de uma janela


[[ -f /usr/bin/xdotool ]] || { return ; }

ct_xDoToolVBoxWriteText() {
    WID=$(xdotool search --name "Windows10" | head -1) 
    #WID=$(xdotool selectwindow)
    xdotool windowfocus $WID 
    xdotool type "$1" 
    xdotool key "Return"
}