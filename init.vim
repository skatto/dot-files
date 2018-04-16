
autocmd ColorScheme * hi Comment guifg=lightgreen
colorscheme molokai
set number
set colorcolumn=80
set smartindent

set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

set clipboard+=unnamed

set ts=4
set sw=4

set whichwrap=b,h,l

autocmd FileType c set ts=2 | set sw=2 | set expandtab | set cindent
autocmd FileType cpp set ts=2 | set sw=2 | set expandtab | set cindent
autocmd FileType html set ts=2 | set sw=2 | set expandtab
autocmd FileType javascript set ts=2 | set sw=2 | set expandtab | set cindent
autocmd FileType vim set ts=2 | set sw=2 | set expandtab | set cindent

" #### dein.vim ####

set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.config/nvim/dein/')
  call dein#begin('~/.config/nvim/dein/')

  " Required
  call dein#add('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim')

  " my plugins
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/vimfiler.vim')
  call dein#add('Shougo/vimshell.vim')

  " syntax or completion
  call dein#add('scrooloose/syntastic.git')
  call dein#add('rhysd/nyaovim-markdown-preview')
  call dein#add('zchee/deoplete-jedi')

  " editting
  call dein#add('terryma/vim-expand-region')
  call dein#add('Vimjas/vim-python-pep8-indent')

  " view
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('t9md/vim-quickhl')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tyru/caw.vim.git')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

" #### Plugin : deoplete ####

" Use deoplete.
let g:deoplete#auto_complete_delay = 0
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_ignore_case = 0

inoremap <expr><C-h> deoplete#smart_close_popup()
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><BS> pumvisible() ? "\<C-h>" : "\<BS>"

" #### Plugin : syntastic ####

let g:syntastic_cpp_include_dirs = ['/usr/local/include', '/usr/include', "./"]
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_config_file = '.syntastic_cpp_config'
let g:syntastic_cpp_check_header = 1

let g:syntastic_python_checkers = ['pyflakes', 'pycodestyle']
let g:loaded_syntastic_python_pep8_checker = 1

" #### Plugin : airline ####

let g:airline_powerline_fonts = 1
let g:airline_theme = 'molokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
" set laststatus=2
if exists('g:nyaovim_version')
  set termguicolors
endif

" #### Plugin : indent guides ####

let g:indent_guides_enable_on_vim_startup = 1
hi IndentGuidesOdd  ctermfg=238 ctermbg=0   guifg=238 guibg=0
hi IndentGuidesEven ctermfg=238 ctermbg=235 guifg=238 guibg=235

" #### Plugin : gitgutter ####

autocmd FileType * :GitGutterLineHighlightsEnable

" #### Plugin : VimFiler ####

let g:vimfiler_ignore_pattern = ['^\.git$', '^\.DS_Store$']

" #### Plugin : Markdown preview ####

let g:markdown_preview_auto=1
autocmd FileType markdown :StartMarkdownPreview

" #### temprate loader [my script] ####

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

" #### typeset tex [my script] ####

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
autocmd FileType tex nnoremap <Space>t :call TypeSetAndShow()<CR>

" #### Key Bind ####

noremap <C-j> 10j
noremap <C-k> 10k
noremap <C-l> 10l
noremap <C-h> 10h

noremap j gj
noremap k gk

noremap 0 $
noremap 9 0

nnoremap <Space>f <Space>zfa{
nnoremap <Space>l <C-l>

nnoremap <C-e> :VimFilerExplorer<CR>
nnoremap <D-e> :VimFiler<CR>

nnoremap <C-t> :tabnew<CR>:VimFiler<CR>
nnoremap <Space>t gt

nnoremap <Space>s :VimShellPop<CR>
nnoremap <C-s> :VimShellCreate<CR>

" for GUI NyaoVim
if exists('g:nyaovim_version')
  if has("mac")
    " for MacOSX
    noremap <D-v> p
    imap <D-v> <C-o>p
    vnoremap <D-c> y
    noremap <D-f> :call nyaovim#call_javascript_function('toggleFullSc', [])<CR>
  else
    noremap <C-f> :call nyaovim#call_javascript_function('toggleFullSc', [])<CR>
  endif
endif

nmap <D-/> <Plug>(caw:hatpos:toggle)
vmap <D-/> <Plug>(caw:hatpos:toggle)

map <Space>m <Plug>(quickhl-manual-this)
map <Space>M <Plug>(quickhl-manual-reset)

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

hi ColorColumn ctermbg=red guibg=green
