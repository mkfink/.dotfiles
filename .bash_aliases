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
# Quickly open new and existing tmux sessions
# tat() Usage:
# Use tat to open the last session
# $ tat
# Use the tab to open an existing session.
# $ tat [TAB]
# Use tat sessionname to create or open an existing named session
# $ tat foo

tat()
{
  if [ -z "$1" ]; then
    echo "attaching to last session"
    tmux a
  else
    local session_name="$1"
    tmuxp load $session_name
    if [ $? -ne 0 ]; then
      echo "tat() is creating new tmux session with name=$session_name"
      tmux new-session -d -s "$session_name"
      tmux attach-session -t "$session_name"
    fi
  fi
}
_tat()
{
  COMPREPLY=()
  local session="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "$(tmux list-sessions 2>/dev/null | awk -F: '{ print $1 }')" -- "$session") )
}
complete -F _tat tat
