"####################
" Vundle系
"####################
set nocompatible
filetype off
 
set rtp+=~/dotfiles/neobundle.vim
if has('vim_starting')
  set runtimepath+=~/dotfiles/neobundle.vim
  call neobundle#rc(expand('~/.vim/'))
endif
     
NeoBundle 'scala.vim'
NeoBundle "Shougo/neocomplcache"
NeoBundle "thinca/vim-quickrun"
NeoBundle "Shougo/vimshell"
NeoBundle "dannyob/quickfixstatus"
NeoBundle "jceb/vim-hier"
NeoBundle "scrooloose/nerdtree"
NeoBundle "mattn/sonictemplate-vim"
NeoBundle "jcf/vim-latex" 
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'claco/jasmine.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \   'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
      \   'cygwin' : 'make -f make_cygwin.mak',
      \   'mac' : 'make -f make_mac.mak',
      \   'unix' : 'make -f make_unix.mak',
      \ }}

NeoBundle 'scrooloose/syntastic'
NeoBundle 'marijnh/tern_for_vim'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'wookiehangover/jshint.vim'

NeoBundle 'szw/vim-tags'
NeoBundle 'basyura/unite-rails'
NeoBundle 'tpope/vim-rails'

NeoBundle 'rking/ag.vim'
  
filetype plugin indent on

"##########################################
"  vimの設定
"##########################################

set nocompatible "vi非互換モード

"#######################
" 表示系
"#######################
set number "行番号表示
set showmode "モード表示
set title "編集中のファイル名を表示
set ruler "ルーラーの表示
set showcmd "入力中のコマンドをステータスに表示する
set showmatch "括弧入力時の対応する括弧を表示
set laststatus=2 "ステータスラインを常に表示

set cursorline " カーソル行をハイライト

set nobackup " バックアップを作らない
set noswapfile " swapファイルを作らない

" カレントウィンドウにのみ罫線を引く
augroup cch
autocmd! cch
autocmd WinLeave * set nocursorline
autocmd WinEnter,BufRead * set cursorline
autocmd FileType * setlocal formatoptions-=ro
augroup END
:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

"#######################
" プログラミングヘルプ系
"#######################
syntax on "カラー表示
set smartindent "オートインデント
" tab関連
set expandtab "タブの代わりに空白文字挿入
set ts=2 sw=2 sts=0 "タブは半角4文字分のスペース
set list!
set listchars=tab:>-
set shiftwidth=2
" ファイルを開いた際に、前回終了時の行で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe
"normal g`\"" | endif

"#######################
" 検索系
"#######################
set ignorecase "検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
set noincsearch "検索文字列入力時に順次対象文字列にヒットさせない
set nohlsearch "検索結果文字列の非ハイライト表示

"#######################
" neocomplcache系
"#######################
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_max_list = 30
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_enable_smart_case = 1
"" like AutoComplPop
let g:neocomplcache_enable_auto_select = 1
"" search with camel case like Eclipse
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
"imap <C-k> <Plug>(neocomplcache_snippets_expand)
""smap <C-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
"" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ?
""\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
"" <CR>: close popup and save indent.
"inoremap <expr><CR> neocomplcache#smart_close_popup() . (&indentexpr != '' ?
""\<C-f>\<CR>X\<BS>":"\<CR>")
inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
"" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup() . "\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup() . "\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

"####################
" VimShell系
"####################
",is:VimShell起動
nnoremap <silent> ,vs :VimShell<CR>
",igs:goshを非同期起動
nnoremap <silent> ,vg :VimShellInteractive gosh<CR>
",ss:非同期で開いたインタプリンタに現在の行を実行
vmap <silent> ,ss :VimShellSendString<CR>
"選択中に,ss:非同期で開いたインタプリンタに選択行を評価させる
nnoremap <silent> ,ss <S-v>:VimShellSendString<CR>


"#####################
" quickrun系
"#####################
if !exists("g:quickrun_config")
    let g:quickrun_config={}
endif

let g:quickrun_config["_"] = {
    \ "runner/vimproc/updatetime" : 80,
    \ "outputter/buffer/split" : ":rightbelow 15sp",
    \ "outputter/error/error" : "buffer",
    \ "outputter/error/success" : "buffer",
    \ "outputter" : "error",
    \ }


""""""""""""""""""""""""""""""""""""
" The NERDTree系設定
""""""""""""""""""""""""""""""""""""

" 引数なしで実行したとき、NERDTreeを実行する
let file_name = expand("%:p")
if has('vim_starting') &&  file_name == ""
    autocmd VimEnter * call ExecuteNERDTree()
endif

" カーソルが外れているときは自動的にnerdtreeを隠す
function! ExecuteNERDTree()
    "b:nerdstatus = 1 : NERDTree 表示中
    "b:nerdstatus = 2 : NERDTree 非表示中

    if !exists('g:nerdstatus')
        execute 'NERDTree ./'
        let g:windowWidth = winwidth(winnr())
        let g:nerdtreebuf = bufnr('')
        let g:nerdstatus = 1 

    elseif g:nerdstatus == 1 
        execute 'wincmd t'
        execute 'vertical resize' 0 
        execute 'wincmd p'
        let g:nerdstatus = 2 
    elseif g:nerdstatus == 2 
        execute 'wincmd t'
        execute 'vertical resize' g:windowWidth
        let g:nerdstatus = 1 

    endif
endfunction
noremap <c-e> :<c-u>:call ExecuteNERDTree()<cr>


""""""""""""""""""""
" vim-latex関係
""""""""""""""""""""

filetype plugin on
filetype indent on
set shellslash
set grepprg=grep\ -nH\ $*

" コンパイル時に使用するコマンド
"let g:Tex_CompileRule_dvi = 'platex --interaction=nonstopmode $*' 
let g:Tex_BibtexFlavor = 'jbibtex'
"let g:Tex_CompileRule_pdf = 'dvipdfmx $*.dvi'

" ファイルのビューワー
let g:Tex_ViewRule_dvi = 'xdvi'
"let g:Tex_ViewRule_pdf = 'evince'
let g:tex_flavor='latex'

let g:Tex_ViewRule_pdf = 'open -a /Applications/Preview.app'
let g:Tex_FormatDependency_pdf = 'dvi,pdf'
let g:Tex_CompileRule_pdf = '/opt/local/bin/dvipdfmx $*.dvi'
"let g:Tex_CompileRule_dvi = '/opt/local/bin/platex-sjis --interaction-nonstopmode $*'
let g:Tex_IgnoredWarnings =
      \"Underfull\n".
      \"Overfull\n".
      \"specifier changed to\n".
      \"You have requested\n".
      \"Missing number, treated as zero.\n".
      \"There were undefined references\n".
      \"Citation %.%# undefined\n".
      \'LaTeX Font Warning:'"
let g:Tex_IgnoreLevel = 8


" golong
" go setttings
filetype off
filetype plugin indent off
set runtimepath+=/usr/local/Cellar/go/1.3/libexec/misc/vim
au FileType go setlocal sw=4 ts=4 sts=4 noet
au BufWritePre *.go Fmt
filetype plugin indent on
syntax on

" scala
autocmd BufRead,BufNewFile *.scala set filetype=scala

" gradle and groovy
au BufRead,BufNewFile *.gradle set filetype=groovy
au BufRead,BufNewFile *.groovy set filetype=groovy
au FileType groovy setlocal sw=4 ts=4 sts=4

" perl lang 
filetype off
filetype plugin indent off
au FileType perl setlocal sw=4 ts=4 sts=4
filetype plugin indent on
syntax on

"" ===============================================
"" set Leader
"" ===============================================

let mapleader=" "

"" --------------------------------------------------
"" unite
"" --------------------------------------------------
let g:unite_enable_start_insert      = 1
let g:unite_winheight                = "10"
let g:unite_winwidth                 = "35"
""let g:unite_source_grep_default_opts = '-iRHn --color=none'
let g:unite_source_grep_default_opts = '-iHRn'
let g:unite_source_session_options   = &sessionoptions

" unite mapping
nnoremap <Leader>u: :Unite 
nnoremap <silent> <Leader>ub :<C-u>Unite buffer<CR> 
nnoremap <silent> <Leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> <Leader>ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <Leader>us :<C-u>Unite file_mru<CR>
nnoremap <silent> <Leader>ua :<C-u>Unite buffer file_mru bookmark tab<CR>
nnoremap <silent> <Leader>uy :<C-u>Unite history/yank<CR> 
nnoremap <silent> <Leader>uo :<C-u>Unite outline -vertical<CR>
nnoremap <silent> <Leader>um :<C-u>Unite mark<CR>
nnoremap <silent> <Leader>uc :<C-u>Unite command<CR>
nnoremap <silent> <Leader>ut :<C-u>Unite tab<CR>
nnoremap <silent> <leader>ug :<C-u>Unite grep:%<CR>

call unite#custom_default_action('file', 'above')
call unite#custom_default_action('file_mru', 'above')
call unite#custom_default_action('file/new', 'above')
call unite#custom_default_action('buffer', 'above')
call unite#custom_default_action('tab', 'above')
call unite#custom_default_action('bookmark', 'above')
call unite#custom_default_action('command', 'above')
call unite#custom_default_action('mark', 'above')

augroup UniteWindowKeyMaps
  autocmd!
  autocmd FileType unite noremap <silent><buffer><expr> <C-j> unite#do_action('split')
  autocmd FileType unite noremap <silent><buffer><expr> <C-l> unite#do_action('vsplit')
  autocmd FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
  autocmd FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
  autocmd FileType unite call UnmapAltKeys()
augroup END

function! UnmapAltKeys()
  " almost for unite to avoid Alt keys does not fire normal <Esc>
  " noremap <Esc> to avoid <Esc>* mappings fired
  inoremap <buffer> <silent> <Plug>(esc) <Esc>
  imap <buffer> <Esc>t <Plug>(esc)t
  imap <buffer> <Esc>t <Plug>(esc)t
endfunction


"------------------------------------
"" Unite-rails.vim
"------------------------------------
nnoremap <silent> <Leader>urv :<C-u>Unite rails/view<CR>
nnoremap <silent> <Leader>urm :<C-u>Unite rails/model<CR>
nnoremap <silent> <Leader>urc :<C-u>Unite rails/controller<CR>

nnoremap <silent> <Leader>urcon :<C-u>Unite rails/config<CR>
nnoremap <silent> <Leader>urs :<C-u>Unite rails/spec<CR>
nnoremap <silent> <Leader>urg ':e '.b:rails_root.'/Gemfile<CR>'
nnoremap <silent> <Leader>urr ':e '.b:rails_root.'/config/routes.rb<CR>'

" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

"-----------------------------------
"" vim tags
"-----------------------------------
let g:vim_tags_project_tags_command = "/usr/local/Cellar/ctags/5.8/bin/ctags -f .tags -R {OPTIONS} {DIRECTORY} 2>/dev/null &"
let g:vim_tags_gems_tags_command = "/usr/local/Cellar/ctags/5.8/bin/ctags -R -f .Gemfile.lock.tags `bundle show --paths` 2>/dev/null &"
set tags+=.tags
set tags+=.Gemfile.lock.tags

" vim ctags
nnoremap <silent> <Leader><C-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
