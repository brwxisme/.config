eval "$(oh-my-posh init bash)"
# eval "$(oh-my-posh init bash --config ~/brwxisme.omp.json)"
eval "$(oh-my-posh init bash --config ~/Config_BRWXISME/bash/new_theme.omp.json)"

alias ~="cd ~"
alias ls="lsd"
alias nv="nvim"
alias dlph="yt-dlp -f 720p "
alias dlcheck="yt-dlp -F "
alias dlmusic="yt-dlp -f 140 "
alias resdp="systemctl restart display-manager.service"
alias gp="git push"
alias lg="lazygit"

alias ncfg="sudo nvim /etc/nixos/ "
alias nclean="sudo nix-collect-garbage -d"
alias rbs="sudo nixos-rebuild switch"



alias mma='cd $HOME/SharedHDD/GodotProjects/MMASim/'
alias mma_patch='cd $HOME/SharedHDD/GodotProjects/MMA_LifeSim/'
alias dcd="cd /home/brew/SharedHDD/GodotProjects/TowDef/"
alias tbp="cd /home/brew/SharedHDD/GodotProjects/TurnBasePlatform/"
alias axf="cd /home/brew/SharedHDD/GodotProjects/newAxes/axesfull-godot"
alias landing_page="cd /home/brew/Documents/LandingPage/"
alias steady="cd $HOME/Documents/steadyfarm/"
alias fctry="cd /home/brew/Documents/newfactory/"
alias marble="cd /home/brew/Documents/marble/MarbleMadness/"
alias aok="cd /home/brew/Documents/AoK/Age_of_Kings_DEMO/"


alias brc="nv $HOME/.bashrc"
alias .files="nvim $HOME/.config/"
# alias nvgd="nvim --listen ~/.cache/nvim/godot.pipe ."
# alias nvgd="nvim --listen ./godothost"
# alias nixcfg="sudo nvim /etc/nixos/configuration.nix"


alias utube_music="floorp -p music"
# alias wakeup_in="sudo rtcwake -m no -s"
# alias wakeup_in4="sudo rtcwake -m no -s 14400"
# alias wakeup_in2="sudo rtcwake -m no -s 7200"
alias to_ogv='mkdir OGVs
for i in *.mp4; do ffmpeg -i "$i" -q:v 9 -q:a 9 "OGVs/${i%.*}.ogv"; done'
alias to_jpg='mkdir JPGs
for i in *.png; do magick "$i" "JPGs/${i%.*}.jpg"; done'

alias spacetime="$HOME/.local/bin/spacetime"
alias hybsleep="systemctl hybrid-sleep"
set -o vi
set show-mode-in-prompt on
set vi-cmd-mode-string "\1\e[2 q\2"
set vi-ins-mode-string "\1\e[6 q\2"

# set vi-ins-mode-string "+"
# set vi-cmd-mode-string ":"
# set vi-cmd-mode-string "\1\e[1;31m\2:\1\e
# set vi-ins-mode-string \1\e[6 q\2
# set vi-cmd-mode-string \1\e[2 q\2[0m\2
# set vi-cmd-mode-string "\1\e[2 q\2cmd"
# set vi-ins-mode-string "\1\e[6 q\2ins"


function nvgd(){
	# nvim --listen ./godothost
	if [ -z ${1+x} ]; 
		then nvim --listen ./godothost
		else nvim --listen ./godothost$1; 
	fi
}
export -f nvgd

function wakeup_in_h(){
	KEK=$(($1*3600))
	sudo rtcwake -m no -s $KEK
}
export -f wakeup_in_h


#     ffmpeg -i output_%04d.png -vf "scale=200:-1,tile=5x5" contact_sheet.jpg
