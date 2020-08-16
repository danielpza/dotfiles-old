# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'
export LESS=-R

# Alias
alias ll="ls -l"
alias l="ls -la"
alias unstow="stow -D"

# Prompt
export PS1="\[\e[32m\]\t\[\e[m\]\[\e[32m\] \[\e[m\]\[\e[32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]\[\e[32m\] \[\e[m\]\[\e[32m\]\w\[\e[m\]\n\\$ "

[[ -f $XDG_CACHE_HOME/wal/sequences ]] && (cat $XDG_CACHE_HOME/wal/sequences &)

function displayColors() {
	for C in {0..255}; do
		tput setab $C
		echo -n "$C "
	done && tput sgr0
}

function download() {
	aria2c -i "$1" --save-session "$1"
}

function downloadall() {
	for file in *; do
		if [ -f "$file" ]; then
			echo Downloading $file
			download "$file" --dir "d/$1"
		fi
	done
}

function ptouch() {
	mkdir -p $(dirname $1) && touch $1
}

function cpr() {
	rsync --archive -hh --partial --info=stats1 --info=progress2 --modify-window=1 "$@"
}

function mvr() {
	rsync --archive -hh --partial --info=stats1 --info=progress2 --modify-window=1 --remove-source-files "$@"
}

function youtube-dl-mp3() {
	youtube-dl --ignore-errors -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o '%(title)s.%(ext)s' "$1"
}

function youtube-dl-mp3p() {
	youtube-dl --ignore-errors -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' "$1"
}
