#----------------------------------------------------------------------
# FUN :P
#----------------------------------------------------------------------

#Random Git Commit Message
rgc() {
    git commit -m"`curl -s http://whatthecommit.com/index.txt`"
}

#----------------------------------------------------------------------
# General Time Savers
#----------------------------------------------------------------------

alias code="emacs -nw"

#cd up, up, and above
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias ..4='cd ../../../../'
alias ..5='cd ../../../../../'
alias ..6='cd ../../../../../../'
alias ..7='cd ../../../../../../../'
alias ..8='cd ../../../../../../../../'

#extract tars of what not compression 
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xjf    $1 && cd $(echo $1 | sed 's/.tar.bz2//') ;;
           *.tar.gz)    tar xzf    $1 && cd $(echo $1 | sed 's/.tar.gz//')  ;;
           *.bz2)       bunzip2    $1 && cd $(echo $1 | sed 's/.bz2//')     ;;
           *.rar)       unrar x    $1 && cd $(echo $1 | sed 's/.rar//')     ;;
           *.gz)        gunzip     $1 && cd $(echo $1 | sed 's/.gz//')      ;;
           *.tar)       tar xf     $1 && cd $(echo $1 | sed 's/.tar//')     ;;
           *.tbz2)      tar xjf    $1 && cd $(echo $1 | sed 's/.tbz2//')    ;;
           *.tgz)       tar xzf    $1 && cd $(echo $1 | sed 's/.tgz//')     ;;
           *.zip)       unzip      $1 && cd $(echo $1 | sed 's/.zip//')     ;;
           *.Z)         uncompress $1 && cd $(echo $1 | sed 's/.Z//')       ;;
           *.7z)        7z x       $1 && cd $(echo $1 | sed 's/.7z//')      ;;
           *)           echo "don't know how to extract '$1'..."            ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

#show last 30 most popular commands
alias freq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'

#Recursive directory listing
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'''

#----------------------------------------------------------------------
# GIT Related  
#----------------------------------------------------------------------
#GIT ALIAS
alias refresh="git pull"

#Compact, colorized git log
alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

#---------------------------------------------------------------------- 
# SOC Related Shortcuts
#----------------------------------------------------------------------

# hw 1 => 'cd soc2014f-hw1-vvg2111'
# hw => 'cd soc2014'
function hw(){
 if [ -z "$1" ]    # Is parameter #1 zero length?
   then
     cd ~/soc2014  # Or no parameter passed.
   else
     cd ~/soc2014f-hw$1-vvg2111/
   fi
}