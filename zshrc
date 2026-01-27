#PROMPT="%B%F{29}%n%f%b%B%F{29}@%f%b%B%F{29}%m%f%b%F{15}:%f%F{33}%~%f%F{15}$%f "
PROMPT="%F{51}%n%f%F{9}@%f%F{85}%m%f:%F{39}%~%f%F{white}$%f "

export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:/usr/local/bin/"


PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh

alias cat="cat"
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias python="python3"
alias pip="pip3"
alias all_update="sudo snap refresh && sudo apt update -y && sudo apt upgrade -y"
alias shred="shred -n 25 -u -v -z"

alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

alias bat='batcat'
alias rand='openssl rand -hex'
alias rsync='rsync --progress --stats'
