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


" #### Tab Setting ####
set smartindent
autocmd FileType c set expandtab | set ts=2 | set sw=2 | set cindent
autocmd FileType cpp set expandtab | set ts=2 | set sw=2 | set cindent
autocmd FileType tex set expandtab | set tabstop=2 | set shiftwidth=2


set colorcolumn=80


" #### call python3 for jedi ####
py3 import sys
py3 print(sys.path)


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
NeoBundle 'vim-latex/vim-latex'
NeoBundle 'tyru/caw.vim.git'

" #### Vim-LaTeX ####

filetype plugin on
filetype indent on
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Imap_UsePlaceHolders = 1
let g:Imap_DeleteEmptyPlaceHolders = 1
let g:Imap_StickyPlaceHolders = 0
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='dvi,pdf'
"let g:Tex_FormatDependency_pdf = 'pdf'
let g:Tex_FormatDependency_pdf = 'dvi,pdf'
"let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
let g:Tex_FormatDependency_ps = 'dvi,ps'
let g:Tex_CompileRule_pdf = '/Library/TeX/texbin/ptex2pdf -u -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
"let g:Tex_CompileRule_pdf = '/Library/TeX/texbin/pdflatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = '/Library/TeX/texbin/lualatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = '/Library/TeX/texbin/luajitlatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = '/Library/TeX/texbin/xelatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = '/usr/local/bin/ps2pdf $*.ps'
let g:Tex_CompileRule_ps = '/Library/TeX/texbin/dvips -Ppdf -o $*.ps $*.dvi'
let g:Tex_CompileRule_dvi = '/Library/TeX/texbin/uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
let g:Tex_BibtexFlavor = '/Library/TeX/texbin/upbibtex'
let g:Tex_MakeIndexFlavor = '/Library/TeX/texbin/upmendex $*.idx'
let g:Tex_UseEditorSettingInDVIViewer = 1
let g:Tex_ViewRule_pdf = 'Skim'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a Skim.app'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a Preview.app'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a TeXShop.app'
"let g:Tex_ViewRule_pdf = '/Applications/TeXworks.app/Contents/MacOS/TeXworks'
"let g:Tex_ViewRule_pdf = '/Applications/texstudio.app/Contents/MacOS/texstudio --pdf-viewer-only'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a Firefox.app'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a "Adobe Reader.app"'
"let g:Tex_ViewRule_pdf = '/usr/bin/open'

set imdisable
autocmd FileType tex nmap <D-y> \ll

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
set ts=4, sw=4 noet
" vimrc に記述されたプラグインでインストールされていないものがないかチェックする
NeoBundleCheck
call neobundle#end()
filetype plugin indent on

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
" 引数なしで実行したとき、NERDTreeを実行する
let file_name = expand("%:p")
if has('vim_starting') &&  file_name == ""
    autocmd VimEnter * execute 'NERDTree ./'
endif

"#### Plugin : Syntastic ####
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
" let g:loaded_syntastic_python_pep8_checker = 1

"保存時にSyntasticをかける.
autocmd BufWritePost * SyntasticCheck

set whichwrap=b,s,h,l,<,>,[,]
