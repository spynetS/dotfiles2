# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
export LANG="en_US.UTF-8"
export GITURL="git@github.com:spynetS/"

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on branch %b'
 
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
autoload -U colors && colors
# PS1='[%{$fg[yellow]%}%n]-[%{$fg[blue]%}%t]─[${PWD/#$HOME/~}]—[${vcs_info_msg_0_}]—> '
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' rehash true  
zmodload zsh/complist
compinit

export PATH="$HOME/.config/emacs/bin:$PATH"
export EDITOR=nvim
export MANPAGER="nvim +Man!"
export FILE_EXPLORER=dolphin
export XDG_CONFIG_HOME="$HOME/.config"
export WEBKIT_DISABLE_DMABUF_RENDERER=1

HISTFILE=~/.cashe/zsh/history
alias mechvibes="mechvibes --in-process-gpu"
alias ls="exa --icons "
alias screenshot="scrot -s -e 'xclip -selection clipboard -t image/png -i $f"
alias lgrep="ll | grep"
alias shut="sudo shutdown -h now"
alias vps="ssh spy@193.181.23.24"
alias mnt='sudo mount /dev/nvme0n1p1 /media/drive1 && sudo mount /dev/sdb1 /media/drive2'
alias dj="python manage.py"
alias clip="xclip -sel c "
alias sshswed="ssh -i ./.ssh/authorized_keys/Sm4rtcsh_bp.pem ubuntu@ec2-16-171-138-156.eu-north-1.compute.amazonaws.com"
alias getdb="scp -i ./.ssh/authorized_keys/Sm4rtcsh_bp.pem ubuntu@ec2-16-171-138-156.eu-north-1.compute.amazonaws.com:servers/Brinto_pay_backend/db.sqlite3 ./dev/Brinto_pay_2022/backend"
alias tab="$TERM &"
alias fetch="fastfetch"
alias ll="ls -alh"
alias i3reload="i3-msg reload"
alias i3="vim ~/.config/i3/config"
alias poly="vim ~/.config/polybar/forest/"
alias dot="cd ~/dotfiles2/"
alias ..="cd .."
alias rc="$EDITOR ~/.zshrc"
alias pacman="sudo pacman"
alias fresh="clear;fetch"
alias ec="emacsclient -c -a ''"
alias extract-album="yt-dlp --extract-audio --audio-format flac "
alias r2="r2modman --in-process-gpu"

## pdfs
alias inl="cd ~/Documents/linjär/in$1"
alias vf='cd $(find $($HOME) -type d | fzf) && tmux'

eval "$(zoxide init zsh)"
alias cd="z"

fetch
# fix bad keybiding
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

#exit line in vim
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
#
##source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#function _update_ps1()
#{
#    export PROMPT="$(~/.config/powerline-zsh/powerline-zsh.py $?)"
#}
#precmd()
#{
#    _update_ps1
#}

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


alias python3="python"
#source ~/.zsh/zsh-vim.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

