if [ $(dpkg-query -W -f='${Status}' git 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo apt-get install git;
fi
cd ~
git clone https://github.com/jimeh/tmux-themepack
ln -s ~/.dotfiles/.bash_profile ~/.bash_profile
ln -s ~/.dotfiles/.bashrc ~/.bashrc
ln -s ~/.dotfiles/.bash_aliases ~/.bash_aliases
ln -s ~/.dotfiles/.bash_logout ~/.bash_logout
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
