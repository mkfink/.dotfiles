GRE='\e[32m'
NC='\033[0m'
BOLD='\e[1m'
# dotfiles we care about
declare -a DOTFILES=(".bash_profile" ".bashrc" ".bash_aliases" ".bash_logout" ".tmux.conf")

#programs to make sure get installed
declare -a PROGRAMS=("wget" "git" "tmux" "curl" "htop" "python3" "python3-pip" "python3-dev" "ncdu")

# check if things are installed
to_install=""
for prog in ${PROGRAMS[@]}
do
  echo -e $GRE"Checking for "$prog$NC
  if [ $(dpkg-query -W -f='${Status}' $prog 2>/dev/null | grep -c "ok installed") -eq 0 ];
  then
    to_install+=" "$prog
  fi
done

if [ -n "$to_install" ]
then
  echo -e $BOLD$GRE"Installing "$to_install$NC
  sudo apt-get install $to_install
  echo -e $GRE"Done"$NC 
fi

[ ! -f ./.git-completion.bash ] && curl -o ~/.dotfiles/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
[ ! -f ./.git-prompt.sh ] && curl -o ~/.dotfiles/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

# backup any existing dotfiles and replace them with symlinks to new ones in ~/.dotfiles
echo -e $BOLD$GRE"Symlinking all the dotfiles"$NC
mkdir -p ~/.dotfiles/backup
for dotfile in ${DOTFILES[@]}
do
  echo -e $GRE"Copying "$dotfile$NC
  if [ -f ~/$dotfile ]
  then
    mv ~/$dotfile ~/.dotfiles/backup/$dotfile
  fi
  ln -s ~/.dotfiles/$dotfile ~/$dotfile
done
echo -e $GRE"Done"$NC

# see .tmux.conf for installed tmux plugins
echo -e $BOLD$GRE"Setting up tmux plugins"$NC
mkdir -p ~/.tmux/plugins
if [ ! -d ~/.tmux/plugins/tpm ]
then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
~/.tmux/plugins/tpm/scripts/install_plugins.sh
pip3 install wheel tmuxp
echo -e $GRE"Done"$NC

# source everything
echo -e $BOLD$GRE"Sourcing .bashrc now"$NC
source ~/.bashrc
exec bash
echo -e $GRE"Done"$NC

# set up git a little
echo -e $GRE"Enter git username"$NC
read git_username
echo -e $GRE"Enter git email"$NC
read git_email
git config --global user.name $git_username
git config --global user.email $git_email
