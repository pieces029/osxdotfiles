#PS1
function parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

export PS1="[\e[0;32m\u@\h: \e[m\e[0;36m\w\e[m\e[1;35m\$(parse_git_branch)\e[m] >\e "

#Exports
export JAVA_HOME=$(/usr/libexec/java_home)
export ANDROID_HOME="$HOME/Library/Android/sdk"

#Path
PATH=$ANDROID_HOME/tools:$PATH
PATH=$ANDROID_HOME/platform-tools:$PATH

#Aliases
alias c='clear'
alias copy='pbcopy'
alias top='htop'
alias la='ls -la'
alias shit='echo "aww, it will be alright"'
alias ports='netstat -tulanp'
alias myip='wget http://ipecho.net/plain -O - -q && echo ""'
alias untar='tar -zxvf'
alias e='exit'
alias q='exit'
alias internet='ping google.com'

#Functions

# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}

# Find something in a directory above the one you are in
function upfind() {
  dir=`pwd`
  while [ "$dir" != "/" ]; do
    path=`find "$dir" -maxdepth 1 -name $1`
    if [ ! -z $path ]; then
      echo "$path"
      return
    fi
    dir=`dirname "$dir"`
  done
}

# Finds the gradle wrapper and executes it with the parameter passed in
function gw() {
    $(upfind gradlew) $@
}

# Finds the nearest build.gradle and executes it with the parameter passed in
function g() {
    gradle -b $(upfind build.gradle) $@
}

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/areitz/.sdkman"
[[ -s "/Users/areitz/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/areitz/.sdkman/bin/sdkman-init.sh"

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"