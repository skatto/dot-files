colorscheme molokai
set undodir=$HOME/.vim/undo
set nobackup
set number

" #### Key Bind ####
noremap <C-h> b
noremap <C-l> e
noremap <C-j> 2j2j2j2j2j
noremap <C-k> 2k2k2k2k2k

noremap j gj
noremap k gk

noremap 0 $
noremap 9 0

nnoremap <S-Down> vj
nnoremap <S-Up> vk
nnoremap <S-Right> vl
nnoremap <S-Left> vh

vnoremap <S-Down> j
vnoremap <S-Up> k
vnoremap <S-Right> l
vnoremap <S-Left> h

nnoremap <S-j> vj
nnoremap <S-k> vk
nnoremap <S-l> vl
nnoremap <S-h> vh

vnoremap <S-j> j
vnoremap <S-k> k
vnoremap <S-l> l
vnoremap <S-h> h

noremap <C-Tab> gt
noremap <C-S-Tab> gT

map <D-F> <Space>zfa{

set whichwrap=b,s,h,l,<,>,[,]

" #### Tab Setting ####
set smartindent
set tabstop=4

autocmd FileType c set expandtab | set tabstop=2 | set sw=2 | set cindent
autocmd FileType cpp set expandtab | set tabstop=2 | set sw=2 | set cindent
autocmd FileType tex set expandtab | set tabstop=2 | set shiftwidth=2
autocmd FileType html set expandtab | set tabstop=2 | set shiftwidth=2
autocmd FileType javascript set expandtab | set tabstop=2 | set shiftwidth=2

let mapleader = "\<Space>"

set colorcolumn=80
highlight ColorColumn guibg=Red  

" #### RO setting ####
function UpdateColorScheme()
  if &readonly==1
    colorscheme morning
  else
    colorscheme molokai
  endif
endfunction

autocmd BufRead * call UpdateColorScheme()


" #### call python3 for jedi ####
" Comment Out, Bacause python3.6.5 is not supported yet.
" set pythonthreehome=/usr/local/Cellar/python/3.6.5
" set pythonthreedll=/usr/local/Cellar/python/3.6.5/Frameworks/Python.framework/Versions/3.6/Python
" py3 import sys

" neobundle settings 
if has('vim_starting')
  set nocompatible
  " neobundle をインストールしていない場合は自動インストール
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    " vim からコマンド呼び出しているだけ neobundle.vim のクローン
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  " runtimepath の追加は必須
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'

" neobundle#begin - neobundle#end の間に導入するプラグインを記載します。
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic.git'
NeoBundle 't9md/vim-quickhl'
NeoBundle 'tyru/caw.vim.git'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'hashrocket/vim-macdown'
NeoBundle 'itchyny/lightline.vim'

" #### Plugin : vimshell ####
nnoremap <C-s> :VimShellPop<CR>
nnoremap <Space>s :VimShellCreate<CR>

" #### Plugin : jedi-vim ####

"sudo pip install jedi pep8 pyflakes
NeoBundleLazy 'davidhalter/jedi-vim', {'autoload':{ 'filetypes':[ 'python' ]} } 
" NeoBundle 'davidhalter/jedi-vim'

" Do not load vim-pyenv until *.py is opened and
" make sure that it is loaded after jedi-vim is loaded.
" NeoBundleLazy 'lambdalisue/vim-pyenv', {
"         \ 'depends': ['davidhalter/jedi-vim'],
"         \ 'autoload': {
"         \   'filetypes': ['python', 'python3'],
"         \ }}
autocmd FileType python setlocal omnifunc=jedi#completions

let g:jedi#auto_vim_configuration = 0

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

func! JediGotoAsNewTab()
	let first_pos = getpos(".")
	:tabedit %:p
	call setpos(".", first_pos)
	call jedi#goto()
endfunc

autocmd FileType python nnoremap <buffer> <D-d> :call JediGotoAsNewTab()<CR>

" #### Plugin : caw.vim ####

nmap <D-/> <Plug>(caw:hatpos:toggle)
vmap <D-/> <Plug>(caw:hatpos:toggle)

nmap <D-j> <Plug>(quickhl-manual-this)
xmap <D-j> <Plug>(quickhl-manual-this)
nmap <D-J> <Plug>(quickhl-manual-reset)
xmap <D-J> <Plug>(quickhl-manual-reset)

" #### Plugin : vim-indent-guides ####

NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1
" let g:indent_guides_guide_size=1
" let g:indent_guides_start_level=2
" let g:indent_guides_auto_colors=0


" vimrc に記述されたプラグインでインストールされていないものがないかチェックする
NeoBundleCheck
call neobundle#end()
filetype plugin indent on


" #### Plugin : neocomplete ####

"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" 隠しファイルを表示する
let NERDTreeShowHidden = 1
let g:NERDTreeShowBookmarks=1
" 引数なしで実行したとき、NERDTreeを実行する
let file_name = expand("%:p")
if has('vim_starting') &&  file_name == ""
    autocmd VimEnter * execute 'NERDTree ./'
endif

" #### Plugin : Syntastic ####

let g:syntastic_mode_map = { 'mode': 'passive',     
                          \ 'active_filetypes': [],     
                          \ 'passive_filetypes': [] } 
let g:syntastic_auto_loc_list=1     
let g:syntastic_error_symbol = ">>"
let g:syntastic_warning_symbol = ">"

let g:syntastic_cpp_include_dirs = ['/usr/local/include', "./"]
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_config_file = '.syntastic_cpp_config'
let g:syntastic_cpp_check_header = 1

let g:syntastic_python_checkers = ['pyflakes', 'pep8']
let g:loaded_syntastic_python_pep8_checker = 1

"保存時にSyntasticをかける.
autocmd BufWritePost * SyntasticCheck


" #### clang-format ####

function! ClangFormat()
  let now_line = line(".")
  exec ':%! clang-format -style="{PointerAlignment: Left}"'
  exec ":" . now_line
endfunction

if executable('clang-format')
  augroup cpp_clang_format
    autocmd!
    nnoremap <C-c> :call ClangFormat()<CR>
  augroup END
endif

" #### typeset shortcut for tex ####

let s:tex_comple_rule='platex -synctex=1 -interaction=nonstopmode -file-line-error-style'
let s:dvi_comple_rule='dvipdfmx -interaction=nonstopmode'
let s:show_pdf_rule='open'

func! TypeSetAndShow()
	if &filetype!='tex' && &filetype!='plaintex'
		echo 'this file is not tex.'
		return
	endif
	lcd %:h
	let base=expand('%:r')
	let log=system(s:tex_comple_rule.' '.base.'.tex')
	if v:shell_error == 0
		let log=system(s:dvi_comple_rule.' '.base.'.dvi')
		if v:shell_error == 0
			let log=system(s:show_pdf_rule.' '.base.'.pdf')
			if v:shell_error != 0
				echo log
			endif
		else
			echo log
		endif
	else
		echo log
	endif
endfunc
autocmd FileType tex nnoremap <C-t> :call TypeSetAndShow()<CR>


func! Pep8()
	if &filetype!='python'
		echo 'this file is not python.'
		return
	endif
	lcd %:h
	let log=system('pep8 '.expand('%'))
	if log == ''
		echo 'everything OK!'
	else
		echo log
	endif
endfunc
nnoremap <C-p> :call Pep8()<CR>


" #### temprate loader ####
let s:tex_temp_path = '~/program/tex/temp.txt'

func! CopyTempFile(temp_path)
	let temp_path = glob(a:temp_path)
	if filereadable(temp_path) == 0
		echo 'temprate file not exits : '.temp_path
		return
	endif
	call append(0, readfile(temp_path))
endfunc

func! LoadTempFile()
	if expand("%:e") == 'tex'
		call CopyTempFile(s:tex_temp_path)
		set filetype=tex
	endif
endfunc

autocmd BufNewFile * call LoadTempFile()
