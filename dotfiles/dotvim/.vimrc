
" -- VIM PLUGINS
"
call plug#begin('~/.vim/plugged')

"" airline info
Plug 'vim-airline/vim-airline'
"" Plug 'vim-airline/vim-airline-themes'

" coc.nvim
"Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm install'}
Plug 'neoclide/coc.nvim', {'tag': 'v0.0.82', 'do': 'npm install'}

" scrooloose/nerdtree fs browsing tree
Plug 'scrooloose/nerdtree'

" arcticicestudio/nord-vim
Plug 'arcticicestudio/nord-vim'

" lumontec/nord-vim
Plug 'https://github.com/lumontec/nord-vim-light.git'

" vim-polyglot
Plug 'sheerun/vim-polyglot'

" yank from everywhere
Plug 'ojroques/vim-oscyank'

"" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()


" -- COC EXTENSIONS
"
let g:coc_global_extensions = ['coc-pyright', 'coc-yaml', 'coc-go', 'coc-tsserver']


" -- CONFIGURATIONS 
"
" show side numbers
set number

" set folding 
"set foldmethod=syntax "syntax highlighting items specify folds
set foldmethod=indent "syntax highlighting items specify folds
set foldlevelstart=99 "start file with all folds opened

" save content to system clipboard
set clipboard=unnamed

" setup undo 
set undodir=~/.vim/undodir
set undofile

" tab completion list
set wildmode=longest,list,full
set wildmenu

" keeps the last cursor position after vim close
source $VIMRUNTIME/vimrc_example.vim

" disable filetype indent
filetype indent off

set hidden
set backupcopy=yes
set nobackup
"set nowritebackup

" c, cpp autoformat
autocmd FileType c,cpp setlocal equalprg=clang-format

" disable cocnvim startup warning
let g:coc_disable_startup_warning = 1


" -- REMAPS
"
" Coc remaps for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Coc remap autocompletion
inoremap <silent><expr> <c-@> coc#refresh()

" Remap arrow keys to resize window
nnoremap <Up>    :resize -2<CR>
nnoremap <Down>  :resize +2<CR>
nnoremap <Left>  :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>

" Remap fzf search
nnoremap <C-p> :Files<CR>
nnoremap <C-l> :Buffers<CR>
nnoremap <C-g> :GFiles<CR>
nnoremap <C-f> :Rg! 

" Remap for NERDTree
map <silent> <C-t> :NERDTreeToggle<CR>

"" Remap yank to Ocsyank for no-clipboard copy
" vnoremap ye "+y
vnoremap ye :OSCYankVisual<CR>

" -- STYLES
"  
" syntax enable
" colorscheme nord
colorscheme nordlight
" colorscheme solarized
"colorscheme gruvbox

" Customize fzf preview window
let $BAT_THEME='base16'
""rg --column --line-number --no-heading --color=always --smart-case --
"" Set explicit ripgrep options for fzf
"command! -bang -nargs=* Rg
"  \ call fzf#vim#grep(
"  \   "rg --column --line-number --no-heading --color=always --smart-case -- ".fzf#shellescape(<q-args>), fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0
"  \ )


" -- CUSTOM FUNCTIONS
"  
" customized fold
function! MyFoldText()
    let nl = v:foldend - v:foldstart + 1
    let comment = substitute(getline(v:foldstart),"^ *","",1)
    let linetext = substitute(getline(v:foldstart+1),"^ *","",1)
    let txt = '+ ' . comment . ': length ' . nl
    return txt
endfunction
set foldtext=MyFoldText()

"
" yanks file line 
function! YankFileLine()
    " map abs path
    " let file = expand("%:p")
    " map curr file 
    let file = expand("%")
    let line = line(".")
    let fileline = file . ':' . line
"    let @+ = fileline
"    let @* = fileline
    let @0 = fileline
endfunction
noremap <F5> :call YankFileLine()<CR>:OSCYankRegister 0<CR>

"
" search fzf word under cursor
function SearchWord()
    let l:Command = expand("<cword>")
       execute "Rg!" . l:Command
endfunction
nnoremap <C-w> :call SearchWord()<CR>

"
" toggle coc
function! CocToggle()
    if g:coc_enabled
        CocDisable
    else
        CocEnable
    endif
endfunction
" Remap toggle everything
silent! map <F10> :set invnumber<CR> :call CocToggle()<CR>
