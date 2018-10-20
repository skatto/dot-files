/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install -s gcc cmake
brew install -s glew glfw python3 geckodriver imagemagick node phantomjs
brew install -s opencv3 --c++11 --with-opengl --with-python3
brew install -s neovim

# install tex
brew cask install basictex
tlmgr update --self --all
tlmgr paper a4
tlmgr install collection-langjapanese

rm -rf $(brew --cache)

mkdir "${HOME%/}.config"
mkdir "${HOME%/}.config/nvim"
mkdir "${HOME%/}.config/nyaovim"

pip3 install neovim

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
mkdir ~/.config/nvim/dein
sh installer.sh ~/.config/nvim/dein/

npm install -g nyaovim
ln -s /usr/local/bin/nyaovim /usr/local/bin/gn

ln -s "${HOME%/}/dotfiles/nyaovimrc.html" "${HOME%/}/.config/nyaovim"
ln -s "${HOME%/}/dotfiles/init.vim" "${HOME%/}/.config/nvim"
ln -s "${HOME%/}/dotfiles/.xvimrc" $HOME
ln -s "${HOME%/}/dotfiles/.bashrc" $HOME
ln -s "${HOME%/}/dotfiles/.zshrc" $HOME
ln -s "${HOME%/}/dotfiles/.bash_profile" $HOME
ln -s "${HOME%/}/program/exec/lssize.py" /usr/local/bin
