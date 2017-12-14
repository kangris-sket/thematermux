#!/data/data/com.termux/files/usr/bin/bash
function jsonValue() {
    KEY=$1
    num=$2
    awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'$KEY'\042/){print $(i+1)}}}' | tr -d '"' | sed -n ${num}p
}

if [ $# -eq 0 ]; then
    echo Usage: $0 theme-name
    echo 
    echo Themes: 
    curl -k -s "https://api.github.com/repos/termux/termux-styling/contents/app/src/main/assets/colors"|jsonValue name|sed 's/.properties//g'|sed 's/ //g'
else
    cd ~
    mkdir -p .termux
    curl -k -s "https://raw.githubusercontent.com/termux/termux-styling/master/app/src/main/assets/colors/$1.properties" > ~/.termux/colors.properties
    termux-reload-settings
fi
