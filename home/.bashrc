# ~/.bashrc: executed by bash(1) for non-login shells.

# Check that we haven't already been sourced.
([[ -z ${CYG_SYS_BASHRC} ]] && CYG_SYS_BASHRC="1") || return

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# If started from sshd, make sure profile is sourced
if [[ -n "$SSH_CONNECTION" ]] && [[ "$PATH" != *:/usr/bin* ]]; then
    source /etc/profile
fi

echo -n Loading bashrc... 1>&2

# parse_git_branch() {
#   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
# }
# 
# if [ -x "$(which git)" ]
# then
#     PS1_GIT=' \[\033[36m\] ($(parse_git_branch))'
# else
#     PS1_GIT=''
# fi
# 
export PS1='\[\033]0;\w\007
\033[32m\]\u@\h \[\033[33m\w\033[0m\]'"${PS1_GIT}"'
$ '

export EDITOR=joe

alias ls="\ls -l"
alias l="\ls"
alias h="history"

# alias homeshick="$HOME/.homesick/repos/homeshick/home/.homeshick"

alias xload="\xload -hl red -geometry  120x73+0-50"

alias renamefotos="jhead -autorot -ft -nf'%y%m%d-%H%M%S'"

if which apt > /dev/null 2>&1
then
    alias sad="sudo apt full-upgrade"
    alias sau="sudo apt update"
else
    alias sad="sudo apt-get dist-upgrade"
    alias sau="sudo apt-get update"
fi
alias acs="apt-cache search"

if [ -z "$OLDPATH" ] ; then
    export OLDPATH=$PATH

    if [ -d ~/.local/bin ] ; then
        PATH=~/.local/bin:"${PATH}"
    fi

    # set PATH so it includes user's private bin if it exists
    if [ -d ~/bin ] ; then
        PATH=~/bin:"${PATH}"
    fi

    # Ruby gems
    for d in ~/.gem/ruby/*/bin ; do PATH="${PATH}:$d" ; done
    
    # do the same with MANPATH
    if [ -d ~/man ]; then
        MANPATH=~/man${MANPATH:-:}
    fi

    # and LD_LIBRARY_PATH
    if [ -d ~/lib ]; then
        LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/lib
    fi

    # Same for stuff in /opt
    for d in /opt/*/bin ; do PATH="${PATH}:$d" ; done
    for d in /opt/*/lib ; do LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:$d" ; done
    for d in /opt/*/man ; do MANPATH="${MANPATH}:$d" ; done

    if [ -d /var/lib/gems/1.8/bin ]; then
        PATH="${PATH}:/var/lib/gems/1.8/bin"
    fi
    export PATH MANPATH LD_LIBRARY_PATH
fi

export NAME="Kees-Jan Dijkzeul"
export EMAIL=kees-jan@dijkzeul.eu

HOMESHICK=$HOME/.homesick/repos/homeshick/homeshick.sh
[ -f $HOMESHICK ] && source $HOMESHICK

# added by travis gem
[ -f /home/kees-jan/.travis/travis.sh ] && source /home/kees-jan/.travis/travis.sh

echo done 1>&2
