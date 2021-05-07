# check for and download necessary files
[ ! -f ./.git-completion.bash ] && curl -o ./.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
[ ! -f ./.git-prompt.sh ] && curl -o ./.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
[ ! -d ./tmux-themepack ] && git clone https://github.com/jimeh/tmux-themepack

ln -s /data/.dotfiles/.bash_profile ~/.bash_profile
ln -s /data/.dotfiles/.bashrc ~/.bashrc
ln -s /data/.dotfiles/.bash_aliases ~/.bash_aliases
ln -s /data/.dotfiles/.bash_logout ~/.bash_logout
rm /root/.tmux.conf
ln -s /data/.dotfiles/.tmux.conf ~/.tmux.conf
tmux source-file /data/.dotfiles/.tmux.conf
source /data/.dotfiles/.bashrc
