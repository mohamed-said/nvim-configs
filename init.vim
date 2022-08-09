set runtimepath^=~/.vim runtimepath+=~/.vim/plugged/vim-colorschemes
let &packpath=&runtimepath
source ~/.vimrc

lua require('kogo.plugins')
lua require('kogo.treesitter')
