"basic setting
syntax on
set nu "显示行号
set rnu "显示相对行号
set tabstop=4 "设置tab键长度
set shiftwidth=4 "设置缩进空格数为4
set autoindent "自动缩进
set cindent "使用C++语言的具体缩进方式
set ruler "显示标尺
set hlsearch "搜索内容高亮
set showcmd "显示输入的命令
syntax on "语法显示高亮
set backspace=2
set wildmenu
"禁用自动备份
set nobackup
set nowritebackup
set signcolumn=yes
set noswapfile

set expandtab "用空格代替tab
set autowrite "自动保存
set cursorline "突出当前行
set clipboard+=unnamed "共享剪贴板
set autoread "文件改动时自动载入
set splitbelow
set splitright
"keymapping
nmap wq :wq<CR>
nmap qq :q<CR>
nmap ww :w<CR>
nmap <silent>tt :term ++rows=10<CR>
nmap <A-h> <C-w>h
nmap <A-j> <C-w>j
nmap <A-k> <C-w>k
nmap <A-l> <C-w>l

nmap <A-Up> :resize -2<CR>
nmap <A-Down> :resize +2<CR>
nmap <A-Left> :vertical resize -2<CR>
nmap <A-Right> :vertical resize +2<CR>


"plug
call plug#begin('~/.vim/plugged')
    "自动补全
    Plug 'neoclide/coc.nvim',{'branch':'release'}    
    "目录树
    Plug 'preservim/nerdtree'
    "模糊搜索
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    "底部状态栏美化
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    "colorschem
    Plug 'junegunn/seoul256.vim'
    "缩进
    Plug 'Yggdroot/indentLine'
    "开始界面
    Plug 'mhinz/vim-startify'
    "debug
    Plug 'https://gitclone.com/github.com/puremourning/vimspector', {'do': './install_gadget.py --enable-python --enable-cpp'}
    "fzf
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'ludovicchabant/vim-gutentags' "自动生成tags标签
    Plug 'skywind3000/asyncrun.vim' "运行程序
call plug#end()

"colorschem
colorschem seoul256
hi CocFloating ctermfg=green ctermbg=darkgrey

"nerdtree
map <C-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

"airline
set laststatus=2  "永远显示状态栏
let g:airline_powerline_fonts = 1  " 支持 powerline 字体
let g:airline#extensions#tabline#enabled = 1 "显示窗口tab和buffer
let g:airline_theme='bubblegum'  " murmur配色不错
if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

"indentLine
let g:indentLine_color_term = 67
let g:indentLine_char = '¦'

"coc
let g:copilot_no_tab_map = v:true
set signcolumn=yes
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ exists('b:_copilot.suggestions') ? copilot#Accept("\<CR>") :
      \ CheckBackSpace() ? "\<Tab>" :
      \ coc#refresh()

"vimspector
let g:vimspector_enable_mappings = 'HUMAN'
function! s:read_template_into_buffer(template)
	" has to be a function to avoid the extra space fzf#run insers otherwise
	execute '0r ~/vim/vimspector_json/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
			\   'source': 'ls -1 ~/vim/vimspector_json/',
			\   'down': 20,
			\   'sink': function('<sid>read_template_into_buffer')
			\ })
noremap vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
sign define vimspectorBP text=☛ texthl=Normal
sign define vimspectorBPDisabled text=☞ texthl=Normal
sign define vimspectorPC text=🔶 texthl=SpellBad


"""ctags
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
if !isdirectory(s:vim_tags)
	silent! call mkdir(s:vim_tags, 'p')
endif

let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--python-kinds=+px']


""""""asyncrun
let g:asyncrun_open = 10 "运行时自动打开高度为6的quickfix窗口
let g:asyncTasks_term_pos = 'bottom'
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']
noremap <silent>rr :AsyncTask file-run<CR>
noremap <silent>bb :AsyncTask file-build<CR>


""""光标
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
