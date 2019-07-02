alias ls='ls -F --color=auto'
alias ll='ls -lAhF --color=auto'
alias la='ls -lAF --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias glog="git log --graph --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

alias ssc='sudo systemctl'

extract () {
    if [ -f "$1" ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar x $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# Tab completion for tmux sessions.
# Quickly open new tmux sessions in your projects dir.

# Setup:
# Source this code in your bash shell.
# Update the code_dir var with the root directory of your source code.

# Usage:

# Use the tab to open an existing session.
# $ tat [TAB]

# Arguments that are passed to tat will be used to create a new session.
# Tat will open a new tmux session and set the default path to the found dir. 
# $ tat payments
# $ pwd
# /code_dir/payments 

tat()
{
  local session_name="$1"
  tmuxp load $session_name
  if [ $? -ne 0 ]; then
    echo "tat() is creating new tmux session with name=$session_name"
    tmux new-session -d -s "$session_name"
    tmux attach-session -t "$session_name"
  fi
}
_tat()
{
  COMPREPLY=()
  local session="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "$(tmux list-sessions 2>/dev/null | awk -F: '{ print $1 }')" -- "$session") )
}
complete -F _tat tat