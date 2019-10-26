
autocmd ColorScheme * hi Comment guifg=darkgray ctermfg=darkgray
colorscheme molokai
set t_Co=256
set number
set colorcolumn=80
set smartindent

set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

set clipboard+=unnamed

set foldmethod=indent
set foldnestmax=1

set ts=4
set sw=4

set whichwrap=h,l,<,>,[,]

autocmd FileType c set ts=2 | set sw=2 | set expandtab | set cindent
autocmd FileType cpp set ts=4 | set sw=4 | set expandtab | set cindent
autocmd FileType html set ts=2 | set sw=2 | set expandtab
autocmd FileType javascript set ts=2 | set sw=2 | set expandtab | set cindent
autocmd FileType vim set ts=2 | set sw=2 | set expandtab | set cindent

autocmd QuickFixCmdPost *grep* cwindow

" #### dein.vim ####

  set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

  if dein#load_state('~/.config/nvim/dein/')
    call dein#begin('~/.config/nvim/dein/')

    " Required
    call dein#add('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim')

    " dark plugins
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
    call dein#add('Shougo/defx.nvim')
    call dein#add('Shougo/vimshell.vim')

    " my plugins
    call dein#add('skatto/template-loader.nvim')
    call dein#add('skatto/pimpl-maker.vim')

    " syntax or completion
    " call dein#add('scrooloose/syntastic.git')
    call dein#add('w0rp/ale', {'lazy' : 1})
    call dein#add('deoplete-plugins/deoplete-jedi')
    call dein#add('deoplete-plugins/deoplete-clang')

    " editting
    call dein#add('terryma/vim-expand-region')
    call dein#add('Vimjas/vim-python-pep8-indent', {'lazy' : 1})

    " view
    call dein#add('nathanaelkane/vim-indent-guides')
    call dein#add('t9md/vim-quickhl')
    call dein#add('airblade/vim-gitgutter', {'lazy' : 1})
    call dein#add('tyru/caw.vim.git')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('cohama/agit.vim')

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

" #### Plugin : deoplete-clang ####

function! SetClangCompleteDatabase(path)
  if filereadable(a:path.'/compile_commands.json')
    let g:deoplete#sources#clang#clang_complete_database = a:path
  endif
endfunction
  let g:deoplete#sources#clang#clang_complete_database = ''
  let g:deoplete#sources#clang#libclang_path = '/usr/local/Cellar/llvm/7.0.1/lib/libclang.dylib'
  let g:deoplete#sources#clang#clang_header = '/usr/local/Cellar/llvm'
  call SetClangCompleteDatabase(getcwd())

  autocmd DirChanged * call SetClangCompleteDatabase(expand("<afile>"))

" #### Plugin : defx ####

autocmd FileType defx call s:defx_my_settings()

function! s:defx_my_settings() abort
  set ts=8
  set sw=8
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction

" #### Plugin : syntastic ####

  " let g:syntastic_cpp_include_dirs = ['/usr/local/include', '/usr/include', "./"]
  " let g:syntastic_cpp_compiler = 'clang++'
  " let g:syntastic_cpp_config_file = '.syntastic_cpp_config'
  " let g:syntastic_cpp_check_header = 1
  "
  " let g:syntastic_python_checkers = ['pyflakes', 'pycodestyle']
  " let g:loaded_syntastic_python_pep8_checker = 1

" #### Plugin : ALE ####

  let g:ale_sign_error = '>>'
  let g:ale_sign_warning = '>'

  let g:ale_linters = {'cpp': ['clang']}
  let g:ale_cpp_clang_executable = '/usr/local/Cellar/llvm/7.0.1/bin/clang++'
  let g:ale_lint_on_text_changed = 'never'

  " autocmd TextChanged * ALELint
  autocmd BufEnter * ALELint
  " autocmd InsertLeave * ALELint

  " for c++
  autocmd BufWritePre *.cpp,*.h,*.hpp ALEFix clang-format

  let g:default_ale_cpp_clang_options = '-std=c++17 -Wall -Wextra -Weverything -Wno-c++98-compat -Wno-c++98-compat-pedantic -Wno-padded -Wno-unused-macros -Wno-weak-vtables -Wno-unused-template'

  let g:ale_cpp_config_file = ".ale_cpp_config"

  let g:ale_compile_commnads_json_file = "compile_commands.json"
  let g:compile_commands_json_data = []

  func! SearchCompileCommnadJson()
    let dir = expand("%:p:h")
    let i = 0
    while (i < 100)
      let dir = dir."/../"
      let i = i + 1
      if filereadable(dir.g:ale_compile_commnads_json_file)
        let data = ""
        for line in readfile(dir.g:ale_compile_commnads_json_file)
          let data = data . ' ' . line
        endfor
        let g:compile_commands_json_data = json_decode(data)
        break
      endif
    endwhile
  endfunc

  call SearchCompileCommnadJson()

  let g:ale_cpp_clang_options = ""

  func! LoadALECppOption()
    " if found compile_commands.json, load the flags.
    if g:compile_commands_json_data != []
      for dict in g:compile_commands_json_data
        if dict["file"] == expand("%:p")
          let command_len = strlen(split(dict["command"], " ")[0])
          let g:ale_cpp_clang_options = dict["command"][command_len:-1]
        endif
      endfor
    endif

    " search ale_cpp_config_file and load.
    if g:ale_cpp_clang_options == ""
      let dir = expand("%:p:h")
      let inputfile = g:ale_cpp_config_file
      let g:ale_cpp_clang_options = g:default_ale_cpp_clang_options
      let i = 0
      while (i < 100)
        let dir = dir."/../"
        let i = i + 1
        if filereadable(dir.inputfile)
          for line in readfile(dir.inputfile)
            let g:ale_cpp_clang_options = g:ale_cpp_clang_options.' '.line
          endfor
          break
        endif
      endwhile
    endif
  endfunc

  autocmd BufReadPre *.cpp,*.h,*.hpp call SearchCompileCommnadJson()
  autocmd BufReadPre *.cpp,*.h,*.hpp call LoadALECppOption()

" #### Plugin : airline ####

  let g:airline_powerline_fonts = 1
  let g:airline_theme = 'molokai'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#whitespace#mixed_indent_algo = 1
  let g:airline#extensions#tabline#formatter = 'unique_tail'
  let g:airline#extensions#ale#enabled = 1
  " set laststatus=2

" #### Plugin : indent guides ####

let g:indent_guides_enable_on_vim_startup = 1
hi IndentGuidesOdd  ctermfg=238 ctermbg=0   guifg=238 guibg=0
hi IndentGuidesEven ctermfg=238 ctermbg=235 guifg=238 guibg=235

" #### Plugin : gitgutter ####

" autocmd FileType * GitGutterLineHighlightsEnable

" #### Plugin : VimFiler ####

let g:vimfiler_ignore_pattern = ['^\.git$', '^\.DS_Store$']

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
  autocmd FileType tex nnoremap <Space>t :call TypeSetAndShow()<CR>

" #### Reset IME at pressing ESC (Only MacOS) ####

if has('mac')
  " set wait duaration when ESC is pressed.
  set ttimeoutlen=1

  let g:imeoff = 'osascript -e "tell application \"System Events\" to key code 102" &'
  " autocmd InsertLeave *.tex :call system(g:imeoff)
  noremap <silent> <ESC> <ESC>:call system(g:imeoff)<CR>
endif

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

  nnoremap <C-d> :tabnext<CR>
  nnoremap <C-a> :tabprevious<CR>

  nnoremap fo za

  nnoremap <C-e> :Defx<CR>

  nnoremap gf :vs<CR>gf

  let s:tabpage = 1

  nnoremap <C-t> :tabnew<CR>:Defx<CR>

  nnoremap <Space>s :VimShellPop<CR>
  nnoremap <C-s> :VimShellCreate<CR>

  nmap <D-/> <Plug>(caw:hatpos:toggle)
  vmap <D-/> <Plug>(caw:hatpos:toggle)
  nmap <Space>/ <Plug>(caw:hatpos:toggle)
  vmap <Space>/ <Plug>(caw:hatpos:toggle)

  map <Space>m <Plug>(quickhl-manual-this)
  map <Space>M <Plug>(quickhl-manual-reset)

  vmap v <Plug>(expand_region_expand)
  vmap <C-v> <Plug>(expand_region_shrink)

  map <Space>g :Agit<CR>

  nmap <Space>k <Plug>(ale_previous_wrap)
  nmap <Space>j <Plug>(ale_next_wrap)

hi ColorColumn ctermbg=red guibg=red
