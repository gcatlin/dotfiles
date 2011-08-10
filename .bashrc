#=============================================================
#
# ~/.bashrc
#
# http://www.gnu.org/software/bash/manual/bashref.html
#
# http://tldp.org/LDP/abs/html/index.html
# http://www.caliban.org/bash/
# http://www.shelldorado.com/scripts/categories.html
# http://www.dotfiles.org/
#
#=============================================================

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#-------------------------------------------------------------
# Shell Prompt
#-------------------------------------------------------------

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm|aterm|kterm|gnome*|interix)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		use_color=true
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		use_color=true
		;;
	*)
		use_color=false
		;;
esac

# Set the prompt
if ${use_color} ; then
	# Define some colors (with transparent background)
	BLACK='\e[0;30m'
	RED='\e[0;31m'
	GREEN='\e[0;32m'
	YELLOW='\e[0;33m'
	BLUE='\e[0;34m'
	MAGENTA='\e[0;35m'
	CYAN='\e[0;36m'
	WHITE='\e[0;37m'
	NONE='\e[0m'

	# set color prompt
	if [[ ${EUID} == 0 ]] ; then
		PS1="${RED}\u${NONE}@${BLUE}\h${NONE}:${MAGENTA}\w${NONE}# "    # root
	else
		PS1="${BLUE}\u${NONE}@${BLUE}\h${NONE}:${MAGENTA}\w${NONE}\$ "  # not root
	fi
else
	if [[ ${EUID} == 0 ]] ; then
		PS1='\u@\h:\w# '  # root
	else
		PS1='\u@\h:\w\$ ' # not root
	fi
fi
unset use_color


#-------------------------------------------------------------
# Miscellaneous settings
#-------------------------------------------------------------

ulimit -S -c 0          # Disable core dumps
set -o notify
set -o noclobber
set -o nounset
#set -o xtrace

# Number of consecutive EOF characters that can be read as the first character
# on an input line before the shell will exit
# set -o ignoreeof
# export IGNOREEOF=3


# Disable options:
shopt -u mailwarn
unset MAILCHECK

export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HOSTFILE=$HOME/.hosts    # Put list of remote hosts in ~/.hosts ...


#-------------------------------------------------------------
# Command line editing
#-------------------------------------------------------------
# shopt -s cmdhist histappend histreedit histverify
# export HISTCONTROL=ignoredups
# export HISTTIMEFORMAT="%H:%M > "
# export HISTIGNORE="&:bg:fg:ls:ll:h"

# http://www.gnu.org/software/bash/manual/bashref.html#Command-Line-Editing
# export INPUTRC=~/.inputrc


#-------------------------------------------------------------
# Aliases
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
#-------------------------------------------------------------
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# Enable color support of ls and also add handy aliases
# if [ "$TERM" != "dumb" ]; then
#     eval "`dircolors -b`"
# fi


#-------------------------------------------------------------
# Tailoring 'less'
#-------------------------------------------------------------

export PAGER=less
export LESSCHARSET='latin1'
export LESSOPEN='|/usr/local/bin/lesspipe.sh %s 2>&-'
export LESS='-i -w -z -4 -g -e -M -X -F -R -P%t?f%f \
:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

# ignore case, long prompt, exit if it fits on one screen, allow colors for ls
# and grep colors, display search target at line 4, skip current screen for search
# export LESS="-iMFXrj4a"


#-------------------------------------------------------------
# Set PATH
#-------------------------------------------------------------
PATH=.:~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
CDPATH=.:~:~/Source


#-------------------------------------------------------------
# Enable programmable completion features
# http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
#-------------------------------------------------------------
# Enable options:
shopt -s cdspell        # Correct small typos when moving to another directory
shopt -s nocaseglob	
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion

# if [ -f ~/.bash_completion ]; then
# 	. ~/.bash_completion
# fi

if [ -f `brew --prefix`/Library/Contributions/brew_bash_completion.sh ]; then
	source `brew --prefix`/Library/Contributions/brew_bash_completion.sh
fi
