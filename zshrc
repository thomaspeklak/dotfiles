# fix keybindings (Home/End/Delete)
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char
bindkey "^?" backward-delete-char

# cursor commands
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[5C" forward-word
bindkey "^[[5D" backward-word
bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word

# line editing
bindkey '^K' kill-line
bindkey '^[d' kill-word

# add helper keybindings (for vi editing mode)
bindkey "^[[5~" history-search-backward
bindkey "^[[6~" history-search-forward
bindkey '^R' history-incremental-search-backward


[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function 
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="random"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"
DISABLE_AUTO_TITLE="true"
# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-extras github gitflow rails3 ruby rvm cap gem svn node npm bundler svn history history-substing-search vundle)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=~/node_modules/.bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:~/.vim/bin:~/bin
export NODE_PATH="/usr/local/lib/node"
export TERM="xterm-256color"

alias cdrupal='ctags --langmap=php:.engine.inc.module.theme.php --php-kinds=cdfi --languages=php --recurse'
alias a="sudo apt-get install \$1"
alias aup="sudo apt-get update && sudo apt-get upgrade"
alias iphp="php -a"
alias store_terminal_session="gnome-terminal --save-config=/home/thomaspeklak/.terminalrc"
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm" 
alias gaac='git add . && git commit'
alias vim_update='cd ~/.vim && git pull && vim +BundleInstall! +qall'
alias g='git'

# Inline aliases, zsh -g aliases can be anywhere in command line
alias -g G='| grep -'
alias -g L='| less'
# #this reduces a command like
# ls | grep foo | less
# #to 
# ls G foo L
# # 
alias -g R=' > /c/aaa/tee.txt '           # redirect
alias -g T=' | tee /c/aaa/tee.txt '       # tee
alias -g F=' | fmt -'                     # format
alias -g W=' | wc -l'                     # wc
alias -g n='nautilus .'

export SPB_CONFIG_ROOT=/var/www/spb/spb-config
export EDITOR=vim

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting


export TEAMCITY_USER="mschaerfer@diamonddogs.cc"
export TEAMCITY_PASSWORD="hackmenot"


export GEOIP_COUNTRY_DAT="/usr/local/lib/geoip/GeoIP.dat"
export GEOIP_COUNTRY_DAT_V6="/usr/local/lib/geoip/GeoIPv6.dat"
export GEOIP_CITY_DAT="/usr/local/lib/geoip/GeoLiteCity.dat"
export GEOIP_CITY_DAT_V6="/usr/local/lib/geoip/GeoLiteCityv6.dat"


XDEBUG_CONFIG=ide-key=vim

# Check to see if SSH Agent is already running
agent_pid="$(ps -ef | grep "ssh-agent" | grep -v "grep" | awk '{print($2)}')"
 
# If the agent is not running (pid is zero length string)
if [[ -z "$agent_pid" ]]; then
    # Start up SSH Agent
 
    # this seems to be the proper method as opposed to `exec ssh-agent bash`
    eval "$(ssh-agent)"
 
    # if you have a passphrase on your key file you may or may
    # not want to add it when logging in, so comment this out
    # if asking for the passphrase annoys you
    ssh-add
 
# If the agent is running (pid is non zero)
else
    # Connect to the currently running ssh-agent
 
    # this doesn't work because for some reason the ppid is 1 both when
    # starting from ~/.profile and when executing as `ssh-agent bash`
    #agent_ppid="$(ps -ef | grep "ssh-agent" | grep -v "grep" | awk '{print($3)}')"
    agent_ppid="$(($agent_pid - 1))"
 
    # and the actual auth socket file name is simply numerically one less than
    # the actual process id, regardless of what `ps -ef` reports as the ppid
    agent_sock="$(find /tmp -path "*ssh*" -type s -iname "agent.$agent_ppid")"
 
    echo "Agent pid $agent_pid"
    export SSH_AGENT_PID="$agent_pid"
 
    echo "Agent sock $agent_sock"
    export SSH_AUTH_SOCK="$agent_sock"
fi
