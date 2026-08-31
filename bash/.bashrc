# ~/.bashrc: executed by bash(1) for non-login shells.
# Karen Danielyan 2022

#shopt options
#shopt -s histappend shopt -s checkwinsize

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00;00m\]\$ '
#history, locale
HISTSIZE=30000
HISTCONTROL=ignoreboth
HISTFILESIZE=30000
export PYTHONSTARTUP=$HOME/.pythonstartup
export PYTHONPATH="${PYTHONPATH}:/usr/bin/python3.10"

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

export TERM="tmux-256color"

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
#preference aliases
alias untar='tar -xvzf'
alias ipar='curl ipinfo.io/ip'
alias ipal='ifconfig getifaddr en0'
alias sag='sudo apt-get'
alias vim='nvim'
alias vimrc='vim ~/.vimrc'
alias vimdiff='nvim -d'
alias bashrc='vim ~/.bashrc'
alias ubashrc='source ~/.bashrc'
alias clangd='clangd-12'
alias python='python3'
alias work='cd /home/daniev/workspace'

force_color_prompt=yes

function hgrep(){
    history|grep $1;
}

function trash() {
    mv $1 ~/.trash
}

# export PATH="$PATH:$HOME/gcc-arm-none-eabi/bin"
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

export EDITOR=nvim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kdaniely/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kdaniely/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kdaniely/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kdaniely/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

