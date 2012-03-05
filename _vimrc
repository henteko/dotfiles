"####################
" Vundle系
"####################
set nocompatible
filetype off
 
set rtp+=~/.vim/vundle.git/
call vundle#rc()
 
" vim-scripts リポジトリ (1)
" Bundle "rails.vim"
 
" github の任意のリポジトリ (2)
" Bundle "tpope/vim-fugitive"
Bundle "Shougo/neocomplcache"
Bundle "thinca/vim-quickrun"
Bundle "Shougo/vimproc"
Bundle "Shougo/vimshell"
Bundle "dannyob/quickfixstatus"
Bundle "jceb/vim-hier"
 
" github 以外のリポジトリ (3)
" Bundle "git://git.wincent.com/command-t.git"
 
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

"#######################
" プログラミングヘルプ系
"#######################
syntax on "カラー表示
set smartindent "オートインデント
" tab関連
set expandtab "タブの代わりに空白文字挿入
set ts=4 sw=4 sts=0 "タブは半角4文字分のスペース
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


"#####################
" quickrun系
"#####################
if !exists("g:quickrun_config")
    let g:quickrun_config={}
endif

let g:quickrun_config["_"] = {
    \ "runner/vimproc/updatetime" : 80,
    \ "outputter/buffer/split" : ":rightbelow 10sp",
    \ "outputter/error/error" : "buffer",
    \ "outputter/error/success" : "buffer",
    \ "outputter" : "error",
    \ "runner" : "vimproc",
    \ }

