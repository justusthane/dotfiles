set runtimepath^=~/vimfiles runtimepath+=~/vimfiles/after
let &packpath = &runtimepath
if has('win32')
	source ~/_vimrc
elseif has('unix')
	source ~/.vimrc
endif
