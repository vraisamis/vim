"""""""" header
set nocompatible
filetype off

"" set neobundle directory
if has('vim_starting')
	set rtp+=~/.vim/bundle/neobundle.vim/
endif

"" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

"""""""" END of header

"----------------
"Install
"----------------
""vundle
NeoBundle 'gmarik/vundle'
""unite 融合プラグイン
NeoBundle 'Shougo/unite.vim'
""unite-outline コードアウトライン(fork版)
NeoBundle 'Shougo/unite-outline'

""vimfiler ファイラー
NeoBundle 'Shougo/vimfiler'
""neocomplete 自動補完
NeoBundle 'Shougo/neocomplete.vim'
""abolish 変数命名規則変換
"NeoBundle 'tpope/vim-abolish'
""tcomment コメントアウトトグル
"NeoBundle 'tomtom/tcomment_vim'
"" platex.vim コンパイルできる
NeoBundle 'lambdalisue/platex.vim'
""quickrun コードのお手軽実行
NeoBundle 'thinca/vim-quickrun'
""lightline 情報行強化
NeoBundle 'itchyny/lightline.vim'
""vim-indent-guides インデント可視化
NeoBundle 'nathanaelkane/vim-indent-guides'

"----------------
"Plugin option
"----------------


""Unite.vim
nnoremap <Space> <silent> <nop>
nmap <Space> [unite]
nnoremap [unite]u :Unite
nnoremap [unite]f :Unite file<CR>
nnoremap [unite]c :Unite tab buffer<CR>
nnoremap [unite]h :Unite file_mru directory_mru<CR>
nnoremap [unite]b :Unite bookmark<CR>
""unite-outline
nnoremap [unite]o :Unite outline<CR>

""vimfiler

""platex.vim
let g:platex_suite_main_file       = "index"
let g:platex_suite_latex_compiler  = "platex"
let g:platex_suite_dvipdf_compiler = "dvipdfmx"
let g:platex_suite_viewer          = "evince"
augroup platex
	autocmd!
	autocmd BufNewFile,BufRead *.tex let g:platex_suite_main_file = "%:r"
augroup END

""vim-quickrun
let g:quickrun_config = {
\	"cpp": {
\		'command': 'g++',
\		'cmdopt': '-std=c++11'
\	}
\}

""lightline
set laststatus=2
let g:lightline = {
\	'colorscheme': 'wombat',
\}

""vim-indent-guides
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=1
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=236
let g:indent_guides_guide_size=1

"""""""" last:
call neobundle#end()

filetype plugin indent on

if neobundle#exists_not_installed_bundles()
	echomsg 'Not installed bundles : ' .
		\ string(neobundle#get_not_installed_bundle_names())
	echomsg 'Please execute ":NeoBundleInstall" command.'
endif
