#-------------------------------------------------------------
# The 'ls' family
#-------------------------------------------------------------
alias ls="$LS"
alias ll="$LS -l"      # long listing
alias la="$LS -lA"     # show hidden files
alias lk="$LS -lSr"    # sort by size, biggest last
alias lc="$LS -ltrc"   # sort by and show change time, most recent last
alias lu="$LS -ltru"   # sort by and show access time, most recent last
alias lt="$LS -ltr"    # sort by date, most recent last
alias lr="$LS -lR"     # recursive ls
alias tree='tree -Csu' # nice alternative to 'recursive ls'


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

#-------------------------------------------------------------
# Find a file with a pattern in name
#-------------------------------------------------------------
function fd() { find . -type d -iname '*'$*'*' -ls ; }
function ff() { find . -type f -iname '*'$*'*' -ls ; }


#-------------------
# Miscellaneous
#-------------------
alias ip="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | cut -d ' ' -f 2"

alias cwd='pwd'

alias du='du -kh'
alias mkdir='mkdir -p'

alias h='history'
alias j='jobs -l'

if ! command_exists rgrep ; then
	alias rgrep='grep -r'
fi

alias path='echo -e ${PATH//:/\\n}'
alias cdpath='echo -e ${CDPATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

if command_exists colorsvn ; then
	alias svn=colorsvn
fi

if command_exists hub; then
	alias git=hub
fi

if [ -f /Applications/Preview.app ] ; then
	function manpdf { man -t $* | open -f -a /Applications/Preview.app ; }
fi
