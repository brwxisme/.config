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
alias tks="tmux kill-server"

alias ncfg="sudo nvim /etc/nixos/ "
alias nclean="sudo nix-collect-garbage -d"
alias rbs="sudo nixos-rebuild switch"



alias dcd="cd /home/brew/SharedHDD/GodotProjects/TowDef/"
alias tbp="cd /home/brew/SharedHDD/GodotProjects/TurnBasePlatform/"
alias axf="cd /home/brew/SharedHDD/GodotProjects/newAxes/axesfull-godot"
alias landing_page="cd /home/brew/Documents/LandingPage/"
# alias steady="cd $HOME/Documents/steadyfarm/"
alias steady="~/Config_BRWXISME/tmux/steady_session.sh"
alias fctry="cd /home/brew/Documents/newfactory/"
alias marble="cd /home/brew/Documents/marble/MarbleMadness/"
alias aok="cd /home/brew/Documents/AoK/Age_of_Kings_DEMO/"


alias brc="nv $HOME/.bashrc"
alias .files="nvim $HOME/.config/"
alias bcfg="cd ~/Config_BRWXISME/ && nv"


alias utube_music="floorp -p music"

alias to_ogv='mkdir OGVs
for i in *.mp4; do ffmpeg -i "$i" -q:v 9 -q:a 9 "OGVs/${i%.*}.ogv"; done'

alias to_jpg='mkdir JPGs
for i in *.png; do magick "$i" "JPGs/${i%.*}.jpg"; done'

alias spacetime="$HOME/.local/bin/spacetime"
alias hybsleep="systemctl hybrid-sleep"

function nvgd(){
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


function yz() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}


function start_tmux(){
	tmux has-session 2>/dev/null
	if [ $? != 0 ]; then
		tmux new-session -d -s config_session
		tmux source-file ~/Config_BRWXISME/tmux/tmux.conf
	fi
}
export -f start_tmux
