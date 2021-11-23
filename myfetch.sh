#!/usr/bin/env bash

display_info (){

	d_title=$USER@$HOSTNAME
	d=$(uname -a | awk '{print $2}')
	d_os=$(uname -o)
	d_kname=$(cat /proc/sys/kernel/ostype)
	d_kversion=$(cat /proc/sys/kernel/osrelease)
	d_uptime=$(uptime | awk '{print $3}')" min"
	d_shell=$(basename $SHELL)
	d_res=$(xrandr | sed -n '1p' | sed 's/.*current.//g;s/,.*//g;s/ //g')
	d_desk=$XDG_SESSION_DESKTOP
	d_font=$(fc-match | sed 's/\..*//g')
	d_cpu=$(cat /proc/cpuinfo | grep -o 'model name.*' | sed -n 1p | sed 's/.*:.//g;s/(.*)//g')
	d_ram=$(echo $(cat /proc/meminfo | sed -n 1p | tr -d [A-Za-z:' ']) / 1000000 | bc)" GB"
	d_memfree=$(echo "scale=2;$(cat /proc/meminfo |sed -n 2p | tr -d [A-Za-z:' '])" / 1000000 | bc)" GB"
	d_architeture=$(getconf LONG_BIT)"-bit"
	d_browser=$(xdg-settings get default-web-browser | sed 's/vivaldi/vivaldi/g;s/-.*//g')
	d_char=$(expr length "$d_title"); qtd=
	for i in $(seq 1 $d_char); do
		qtd="$qtd─"
	done
}


set_info(){
display_info
cat <<EOF

$d_title
$qtd
Distro: ${d^}
OS: $d_os
Kernel Name: $d_kname
kernel Version: $d_kversion
Uptime: $d_uptime
Shell: ${d_shell^}
Resolution: $d_res
Desk: $d_desk
Font: $d_font
CPU: $d_cpu
Ram: $d_ram
Mem Free: $d_memfree
Architeture: $d_architeture
Browser: ${d_browser^}
EOF
}
ArchLinux="
                                 
               .l.               
              ;ooo;              
             :oooool.            
           .  .cooooo'           
          :ool:,:ooooo:          
        .loooooooooooool.        
       ,oolllllllllllllll'       
      :llllll:'...':lll:cl:      
    .clllllc.       .cl:,..      
   ,lllllll.         .lllllc;'   
 .:lllllllc           clllllll:. 
 ..........           .......... 
                                 
                                 
                                 
"
#printf "%s" "$ArchLinux"
#set_info
paste <(printf "%s" "$ArchLinux") <(set_info) | lolcat
