#-------------------------------------------------------------
# The 'ls' family
#-------------------------------------------------------------
if [[ -z $LS ]] ; then
	LS=ls
fi

alias ls=$LS
alias ll="$LS -l"      # long listing
alias la="$LS -lA"     # show hidden files
alias lk="$LS -lSr"    # sort by size, biggest last
alias lc="$LS -ltrc"   # sort by and show change time, most recent last
alias lu="$LS -ltru"   # sort by and show access time, most recent last
alias lt="$LS -ltr"    # sort by date, most recent last
alias lr="$LS -lR"     # recursive ls
alias tree='tree -Csh' # nice alternative to 'recursive ls'


#-------------------------------------------------------------
# The 'cd' family
#-------------------------------------------------------------
alias cd..='cd ..'
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias ..6='cd ../../../../../..'
alias ..7='cd ../../../../../../..'
alias ..8='cd ../../../../../../../..'
alias ..9='cd ../../../../../../../../..'

alias q='cd ..; ls'
alias d='dirs -v'
alias pu=pushd
alias po=popd
alias cwd=pwd


#-------------------------------------------------------------
# colordiff
#-------------------------------------------------------------
if command_exists colordiff ; then
	alias diff=colordiff
fi


#-------------------------------------------------------------
# The 'git' family
#-------------------------------------------------------------
if command_exists git ; then
	if command_exists hub; then
		alias git=hub
	fi

	alias ga='git add'
	alias gb='git branch'
	alias gc='git checkout'
	alias gcl='git clone'
	alias gd='git diff'
	alias gdc='git diff --cached'
	alias gl='git log'
	alias gm='git commit -m'
	alias gma='git commit -am'
	alias gp='git push'
	alias gpom='git push -u origin master'
	alias gpu='git pull'
	alias gra='git remote add'
	alias grr='git remote rm'
	alias gs='git status'
fi


#-------------------------------------------------------------
# The 'svn' family
#-------------------------------------------------------------
if command_exists svn ; then
	svn_diff='svn diff --diff-cmd diff -x -duN'
	if command_exists colordiff ; then
		alias sd="${svn_diff}bw | colordiff"
		alias sdw="${svn_diff} | colordiff"
	else
		alias sd="${svn_diff}bw"
		alias sdw="${svn_diff}"
	fi

	alias ss='svn status --ignore-externals | grep -v ^X'
	alias sse='svn status'
	alias si='svn info'
	alias sc='svn checkout'
	alias sm='svn commit'
fi


#-------------------------------------------------------------
# Find a file with a pattern in name
#-------------------------------------------------------------
function f() { find . -iname '*'$*'*' ; }
function fd() { find . -type d -iname '*'$*'*' ; }
function ff() { find . -type f -iname '*'$*'*' ; }


#-------------------------------------------------------------
# Miscellaneous
#-------------------------------------------------------------
alias rgrep='grep -r'

alias du='du -kh'
alias mkdir='mkdir -p'

alias h=history
alias j='jobs -l'

alias path='echo -e ${PATH//:/\\n}'
alias cdpath='echo -e ${CDPATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

alias myip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d " " -f 2'


#-------------------------------------------------------------
# Environment dependent
#-------------------------------------------------------------
if command_exists irb ; then
	alias irb='irb -r irb/completion'
fi

if command_exists phpunit ; then
	alias phpunit='php -d memory_limit=512M phpunit'
fi

if command_exists rlwrap ; then
	alias telnet='rlwrap telnet'
fi
