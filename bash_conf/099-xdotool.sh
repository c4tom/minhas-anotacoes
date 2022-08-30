[[ `isWin` != "1" ]] || { return ; }

#http://xmodulo.com/simulate-key-press-mouse-movement-linux.html

# Use o comand xprop para mostrar detalhes de uma janela


[[ -f /usr/bin/xdotool ]] || { return ; }

ct_xdotool_writeText() {
    local WIN_TITLE_TEXT="$1"
    WID=$(xdotool search --sync --onlyvisible --name "$WIN_TITLE_TEXT" | head -1) 
    #WID=$(xdotool selectwindow)
    xdotool windowfocus $WID
    xdotool windowactivate --sync $WID
    xdotool type "$2" 
    xdotool key "Return"
}