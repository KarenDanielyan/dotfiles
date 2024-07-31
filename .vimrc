" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    .vimrc                                             :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: kdaniely <marvin@42.fr>                    +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2022/10/01 19:58:19 by kdaniely          #+#    #+#              "
"    Updated: 2024/07/31 15:53:50 by kdaniely         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

" __   _(_)_ __ ___  _ __ ___ 
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__ 
"   \_/ |_|_| |_| |_|_|  \___|
"                             
" Karen Danielyan 2022

syntax on
set tabstop=4 softtabstop=4
set encoding=UTF-8
set shiftwidth=4
set noexpandtab
set exrc
set relativenumber
set nu
set noerrorbells
set noswapfile
set incsearch
set wildmenu
set cmdheight=2
set updatetime=300
set list lcs=tab:>\ ,space:.
set ruler

"plugin manager
set encoding=UTF-8
let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif
if vim_plug_just_installed " manually load vim-plug the first time
    :execute 'source '.fnameescape(vim_plug_path)
endif
call plug#begin('~/.vim/plugged')

Plug '42Paris/42header'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'terryma/vim-multiple-cursors'
Plug 'gruvbox-community/gruvbox'
Plug 'gosukiwi/vim-atom-dark'
Plug 'joshdick/onedark.vim'

call plug#end()

" Vim functions
function!	NewClass()
	execute 'Stdheader'

	let	fname = expand('%:t:r')
	let	extension = expand('%:t:e')
	let	sl = line(".")
	" Header guard
	call setline(sl, "#ifndef ".toupper(fname)."_".toupper(extension))
	call append(sl, "# define ".toupper(fname)."_".toupper(extension))
	" Class declaration
	call append(sl + 1, "")
	call append(sl + 2, "class	".fname)
	call append(sl + 3, "{")
	call append(sl + 4, "private:")
	call append(sl + 5, "")
	call append(sl + 6, "protected:")
	call append(sl + 7, "")
	call append(sl + 8, "public:")
	call append(sl + 9, "	".fname."();")
	call append(sl + 10, "	".fname."(const ".fname."& other);")
	call append(sl + 11, "")
	call append(sl + 12, "	".fname."&	operator=(const ".fname."& other);")
	call append(sl + 13, "")
	call append(sl + 14, "	~".fname."();")
	call append(sl + 15, "};")
	call append(sl + 16, "")
	call append(sl + 17, "#endif")
endfunction

" VIM Multiple Cursors Mapping - Default
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
set background=dark
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif

color onedark

" Function mappings
command! NewClass call NewClass()
map <C-h> :NewClass<CR>
