# ~/.bashrc
#
# http://www.gnu.org/software/bash/manual/bashref.html
# http://tldp.org/LDP/abs/html/index.html
# http://www.caliban.org/bash/
# http://www.shelldorado.com/scripts/categories.html
# http://www.dotfiles.org/

# Test for an interactive shell. There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize


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

#-------------------------------------------------------------
# Command prompt appearance
#
# See https://wiki.archlinux.org/index.php/Color_Bash_Prompt
#-------------------------------------------------------------
if ${use_color} ; then
	# Define some colors (with transparent background)
	reset=$(tput sgr0)
	black=$(tput setaf 0)
	red=$(tput setaf 1)
	green=$(tput setaf 2)
	yellow=$(tput setaf 3)
	blue=$(tput setaf 4)
	magenta=$(tput setaf 5)
	cyan=$(tput setaf 6)
	white=$(tput setaf 7)

	# set color prompt
	if [[ ${EUID} == 0 ]] ; then
		PS1='\[$red\]\u\[$reset\]@\[$blue\]\h\[$reset\]:\[$magenta\]\w\[$reset\]# '   # root
	else
		PS1='\[$blue\]\u\[$reset\]@\[$blue\]\h\[$reset\]:\[$magenta\]\w\[$reset\]\$ ' # non-root
	fi
else
	if [[ ${EUID} == 0 ]] ; then
		PS1='\u@\h:\w# '  # root
	else
		PS1='\u@\h:\w\$ ' # non-root
	fi
fi
unset use_color


#-------------------------------------------------------------
# Miscellaneous settings
#-------------------------------------------------------------
ulimit -S -c 0          # Disable core dumps
set -o notify
set -o noclobber
# set -o xtrace

# Disable mail stuff
shopt -u mailwarn
unset MAILCHECK

export HOSTFILE=$HOME/.hosts    # Put list of remote hosts in ~/.hosts ...


#-------------------------------------------------------------
# Command line editing
#-------------------------------------------------------------
shopt -s cmdhist histappend histreedit histverify
export HISTIGNORE="&:[ ]*:bg:fg:ls:ll:la:h"

# http://www.gnu.org/software/bash/manual/bashref.html#Command-Line-Editing
# export INPUTRC=~/.inputrc


#-------------------------------------------------------------
# Aliases
#
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
# Tweak 'less'
#-------------------------------------------------------------
export PAGER=less
export LESS='-F -i -M -R -W -X -z-2'
export LESSCHARSET='latin1'
export LESSOPEN='|/usr/local/bin/lesspipe.sh %s 2>&-'


#-------------------------------------------------------------
# Set PATH
#-------------------------------------------------------------
PATH=.:~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
CDPATH=.:~:~/Source


#-------------------------------------------------------------
# Programmable completion features
#
# http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
#-------------------------------------------------------------
shopt -s cdspell        # Correct small typos when moving to another directory
shopt -s nocaseglob	
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion

export FIGNORE=.svn

if [ -f $(which brew) ]; then
	bp=$(brew --prefix)

	if [ -f $bp/etc/bash_completion ]; then
	  . $bp/etc/bash_completion
	fi
	
	if [ -f $bp/Library/Contributions/brew_bash_completion.sh ]; then
		. $bp/Library/Contributions/brew_bash_completion.sh
	fi

	unset bp
fi
