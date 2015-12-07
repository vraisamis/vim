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
""unite 融合プラグイン
NeoBundle 'Shougo/unite.vim'
""unite-outline コードアウトライン(fork版)
NeoBundle 'Shougo/unite-outline'

""vimproc
NeoBundle 'Shougo/vimproc.vim', {
			\ 'build' : {
			\	'cygwin' : 'make -f make_cygwin.mak',
			\	'linux' : 'make',
			\	},
			\ }
""vimshell Shell on Vim
NeoBundle 'Shougo/vimshell'
""vimfiler ファイラー
NeoBundle 'Shougo/vimfiler'
""neocomplete 自動補完
NeoBundle 'Shougo/neocomplete.vim'
""neosnippet スニペット
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
"" vim-javacomplete2
NeoBundle 'vim-scripts/vim-javacomplete2'
"" vim-marching C++ completion
NeoBundle 'osyo-manga/vim-marching'
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

""neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#sources#dictionary#dictionaries = {
			\ 'default' : '',
			\ 'vimshell' : $HOME.'/.vimshell_hist'
			\ }
inoremap <expr><C-l> neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_neocomplete_cr_function()<CR>
function! s:my_neocomplete_cr_function()
	return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif

""neosnippet
imap <C-s> <Plug>(neosnippet_expand_or_jump)
smap <C-s> <Plug>(neosnippet_expand_or_jump)
xmap <C-s> <Plug>(neosnippet_expand_target)
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

""vim-javacomplete2
autocmd FileType java set omnifunc=javacomplete#Complete
imap <F4> <Plug>(JavaComplete-Imports-Add)
imap <F4> <Plug>(JavaComplete-Imports-RemoveUnused)
nmap <F4> <Plug>(JavaComplete-Imports-Add)
nmap <F4> <Plug>(JavaComplete-Imports-RemoveUnused)

""vim-marching
"let g:marching_backend = "sync_clang_command"
let g:marching_clang_command_option = "-std=c++1y"
" use with neocomplete 
let g:marching_enable_neocomplete = 1
if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.cpp =
			\ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:marching_include_paths = filter(
			\ split(glob('/usr/include/c++/*'), '\n') +
			\ split(glob('/usr/include/*/c++/*'), '\n') +
			\ split(glob('/usr/include/*/'), '\n'),
			\ 'isdirectory(v:val)')

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
