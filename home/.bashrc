# ~/.bashrc: executed by bash(1) for non-login shells.

# echo -n Loading bashrc... 1>&2

export PS1='\[\033]0;\w\007
\033[32m\]\u@\h \[\033[33m\w\033[0m\]
$ '

export EDITOR=joe

alias ls="\ls -l"
alias l="\ls"
alias h="history"

# alias homeshick="$HOME/.homesick/repos/homeshick/home/.homeshick"

alias xload="\xload -hl red -geometry  120x73+0-50"

alias renamefotos="jhead -autorot -ft -nf'%y%m%d-%H%M%S'"

if which apt > /dev/null
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
export EMAIL=kees-jan.dijkzeul@iae.nl

HOMESHICK=$HOME/.homesick/repos/homeshick/homeshick.sh
[ -f $HOMESHICK ] && source $HOMESHICK

# echo done 1>&2


# added by travis gem
[ -f /home/kees-jan/.travis/travis.sh ] && source /home/kees-jan/.travis/travis.sh
