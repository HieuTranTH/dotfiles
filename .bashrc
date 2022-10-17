# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

###############################################################################
# Start of Hieu's custom Configurations
###############################################################################

# Customization for GNU Screen to use dynamic title and different screenrc files
if [ -f ~/.bashrc_extra/bashrc_screen.sh ]; then
    . ~/.bashrc_extra/bashrc_screen.sh
fi

if [ "$dyna_title" = "Yes" -a -f ~/.bashrc_extra/bashrc_screen_dyna_title.sh ]; then
    . ~/.bashrc_extra/bashrc_screen_dyna_title.sh
fi

# Alias for diff with color highlighting
alias diff='diff --color=auto'

# Hostname hieu-thinkpad-p14s-gen-2 specific ###################################
if [ $( hostname ) = "hieu-thinkpad-p14s-gen-2" ]; then
    # Todo.txt requirements
    # Make alias todo for todo.sh and source bash completion file todo_completion
    alias todo='~/bin/todo.txt_cli-2.12.0/todo.sh'
    . ~/bin/todo.txt_cli-2.12.0/todo_completion

    # Aliases to cd to Documents and Tuxera directory
    alias cdb='cd ~/bin'
    alias cdd='cd ~/Documents'
    alias cdt='cd ~/Documents/Tuxera'
    alias cdta='cd ~/Documents/Tuxera/AmbaFS; cd1'
    alias cdtb='cd ~/Documents/Tuxera/builroot_package_x86-64; cd1'
    alias cdtj='cd ~/Documents/Tuxera/Jira-tickets; cd1'
    alias cdti='cd ~/Documents/Tuxera/INTEGRITY; cd1'
    alias cdtq='cd ~/Documents/Tuxera/QNX; cd1'
    alias cdts='cd ~/Documents/Tuxera/software; cd1'

    # Edit *_commands files with vim
    alias vic='command vim -p ~/Documents/*_commands -c "tabdo set noexpandtab autoindent formatoptions-=q" -c "2tabnext"'

    # Edit i3 config, open other referenced configuration files
    alias vii3='command vim -p ~/.config/regolith/i3/{config,todo} ~/.config/regolith/Xresources ~/Documents/hieu_gits/voidrice/.config/i3/config -c "tabdo setfiletype i3" -c "1tabn"'

    # Start minicom with logging and color
    alias minicomlc='minicom -C minicom_$(date +%Y-%m-%d_%H.%M).txt -w -c on -t xterm-256color'

fi
# End of Hostname hieu-thinkpad-p14s-gen-2 specific ############################

# Hostname WPF1Y2XET specific ###################################
if [ $( hostname ) = "WPF1Y2XET" ]; then
    # Aliases to cd to common directories
    alias cdb='cd ~/bin'
    alias cdr='cd ~/repos; cd1'
    alias cdd='cd ~/dev; cd1'

    # Edit *_commands files with vim
    alias vic='command vim -p ~/binb/*_commands -c "tabdo set noexpandtab autoindent formatoptions-=q" -c "3tabnext"'
fi
# End of Hostname WPF1Y2XET specific ############################

# Edit .bashrc
alias vib='command vim ~/.bashrc'

# Edit .vimrc
alias viv='command vim ~/.vimrc'

# Kubectl bash completion
. ~/.kube/kubectl_completion

################################################################################
# fzf                                                                          #
################################################################################
# Make FZF background (current line) brighter
export FZF_DEFAULT_OPTS="--color='bg+:240'"

# cd to a sub-directory right under CWD
function cd1() {
    DEST=$( ls -laL | grep "^d" | fzf --height 20% |  awk '{ print $9 }' )
    [ -n "$DEST" ] && cd $DEST && echo "$PWD:" && ls -A
}
# Bind Alt-1 to execute cd1()
bind -m emacs-standard '"\e1": "cd1\n"'
bind -m vi-command '"\e1": "cd1\n"'
bind -m vi-insert '"\e1": "cd1\n"'
# Edit any text executable files
function fzfbin() {
    find $( echo $PATH | sed 's/:/ /g' ) /usr/share \
        -executable -type f -exec grep -Iq . {} \; -print | \
        fzf -m --preview="head -20 {}" --height 40% \
            --bind "ctrl-o:execute-silent:(/usr/bin/gnome-terminal --geometry=95x50 --class=floating_window -- bash -c 'vim {}' &)" | xargs -ro -d "\n" vim
}
# Edit any user configuration files
function fzfconf() {
    cd ~; find .bash* .config .gdbinit .gitconfig .*rc* .profile .screen* .ssh .vim* .Xresources* | \
        fzf -m --preview="head -20 {}" --height 40% \
            --bind "ctrl-o:execute-silent:(/usr/bin/gnome-terminal --geometry=95x50 --class=floating_window -- bash -c 'vim {}' &)" | xargs -ro -d "\n" vim
}
# Kill processes
function fzfkill() {
    PROCESS_IDs=$( ps aux | fzf -m --height 40% --no-mouse \
        --bind 'ctrl-r:reload(ps aux)' \
        --header 'Press CTRL-R to reload' --header-lines=1 \
            | awk '{print $2}' )
    if [ -n "$PROCESS_IDs" ]; then
        echo kill $1 $PROCESS_IDs
        read -p "Proceed? (Y/n)" CONT
        [ ${CONT:-Y} != 'Y' ] && return 1
        kill $1 $PROCESS_IDs
        ps -u -p $PROCESS_IDs
    fi
}
# Open any file in current directory with xdg-open
function fzfopen() {
    find \( -type f -o -type l \) | \
        fzf +m --preview="xdg-mime query filetype {}" --height 40% | \
        xargs -ro -d "\n" devour xdg-open 2>&-
}

# Tab completion for fzf command arguments
# fzf will be triggered with '**' then Tab
. ~/.vim/plugged/fzf/shell/completion.bash

# CTRL-T - Paste the selected file path into the command line
# CTRL-R - Paste the selected command from history into the command line
# ALT-C - cd into the selected directory
export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \\( -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
-o -type d -print 2> /dev/null | cut -b3-"
export FZF_ALT_C_OPTS='--preview="tree -L 1 {}"'
. ~/.vim/plugged/fzf/shell/key-bindings.bash
################################################################################
# End of fzf                                                                   #
################################################################################

# Function wrapper for dotfiles git version control
function dotfiles() {
    /usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME $@
}
# Enable git bash completion for dotfiles
if [ -f /usr/share/bash-completion/completions/git ]; then
    # Source the private functions
    . /usr/share/bash-completion/completions/git
    # Add git completion to aliases/functions
    __git_complete dotfiles __git_main
fi
# Function to push dotfiles, then update the repo on other hosts
function dotfilespush() {
    dotfiles push
    #dotfiles_sync.sh   # Don't sync to Tuxera hosts anymore
}
# Function to pull dotfiles, automatically stash save > pull > stash pop, which
# will keep custom changes in some hosts
function dotfilespull() {
    cd ~
    dotfiles stash save
    dotfiles pull
    dotfiles stash pop
    cd -
}

# Go to the top directory of a git repo, work with repo that have submodules
function cdg() {
    TEMP_PWD=$PWD
    while [ ! -d .git ]; do
        cd ..
        [ $PWD = "/" ] && break
    done
    OLDPWD=$TEMP_PWD
}

# Let shell change directory when ranger exits
# see /usr/bin/ranger
function r() {
    [ $# -eq 1 ] && cd $1
    # shift positional parameter because 'ranger' script will check $1
    shift
    source ranger
}

# Parse argument of file:line:column or file:line format to vim
# Only work with as first parameter
function vim() {
    local first="$1"
    case $first in
        *:*:*)
            shift
            file=${first%%:*}
            column=${first##*:}
            line=${first#$file:}
            line=${line%:$column}
            command vim ${file} +0${line} -c "normal ${column}|" $@
            ;;
        *:*)
            shift
            file=${first%%:*}
            line=${first##*:}
            command vim ${file} +0${line} $@
            ;;
        *)
            command vim $@
            ;;
    esac
}

# Give colors for man pages
# https://www.tecmint.com/view-colored-man-pages-in-linux/
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;48;5;56m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Make Vim to be the default editor for C-xC-e and fc commands
export EDITOR=vim

# Show job count in bash prompt
PS1="[\j]$PS1"

###############################################################################
# End of Hieu's custom Configurations
###############################################################################
