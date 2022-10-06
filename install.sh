#update the vim
git clone https://gitclone.com/github.com/vim/vim.git
cd vim
git pull
cd src
make distclean
make
sudo make install
