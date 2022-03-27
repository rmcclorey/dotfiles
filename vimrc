" ____                         _             _                    
"|  _ \ ___  _ __   __ _ _ __ ( )___  __   _(_)_ __ ___  _ __ ___ 
"| |_) / _ \| '_ \ / _` | '_ \|// __| \ \ / / | '_ ` _ \| '__/ __|
"|  _ < (_) | | | | (_| | | | | \__ \  \ V /| | | | | | | | | (__ 
"|_| \_\___/|_| |_|\__,_|_| |_| |___/ (_)_/ |_|_| |_| |_|_|  \___|
"                                                                 

set backspace=indent,eol,start "Default stuff for backspace working
set background=dark "set's the backgroud dark
set incsearch "highlights as you type the search field
set number relativenumber "Sets line numbers relative to cursor position
set nrformats-=octal "Sets <c-a> and <c-x> to use decimal instead of base-8
set splitbelow splitright "Splits at the bottom and right like normal programs do 
set shiftwidth=4 "Set tabs to 4 spaces wide,not using spaces tho
set tabstop=4 softtabstop=4
set expandtab "turn tabs into spaces
set path+=** "Pseudo fuzzy finder 
set wildmenu  "Shows list of options for tab completion
set smarttab "Auto tab/indent stuff
set smartindent
set autoindent
set noerrorbells "Stops sound. Who wants this??
set nowrap "lines won't wrap around
set smartcase "case sensitive stuff for searching
set noswapfile "Turns off swap files
set nobackup "don't bother with backup files
set undodir=~/.vim/undodir "undo directory in .vim
set undofile "undo file
set encoding=utf-8
set scrolloff=8
set noshowmode "Turn off old mode line, using airline now
set signcolumn=yes
set updatetime=300 "update faster

"turn syntax on 
syntax on

"Number lines return to normal value when in insert mode
":augroup numbertoggle
":  autocmd!
":  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
":  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
":augroup END

"Polyglot settings (has to be set before loading polyglot
let g:polyglot_disabled = ['sensible', 'markdown']

"Source plugins
call plug#begin('~/.vim/plugged')
    "Colorscheme 
    Plug 'gruvbox-community/gruvbox'

    "autocomplete options
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    "syntax checker
    Plug 'scrooloose/syntastic'

    "Status bar
    Plug 'vim-airline/vim-airline'

    "Git integration
    Plug 'tpope/vim-fugitive'

    "vim-wiki
    Plug 'vimwiki/vimwiki'

    "fuzzy-finder 
    Plug 'junegunn/fzf', { 'do': {-> fzf#install() } }

    "highlight engine
    Plug 'sheerun/vim-polyglot'

    "Jinja support for vim
    Plug 'lepture/vim-jinja'
    
    "Make commenting nice
    Plug 'tpope/vim-commentary'

    "html macro thing
    Plug 'mattn/emmet-vim'
call plug#end()

"Sexy colorscheme
colorscheme gruvbox

"Line number coloring stuff
highlight LineNr ctermfg=grey ctermbg=Black
highlight CursorLineNr term=bold 
set cursorline
set cursorlineopt=number

"Set space to leader
let mapleader=" "

"Use tab/S-tab for Coc
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)nmap <silent> gd <Plug>(coc-definition)

"Make netrw not suck 
let g:netrw_browse_split = 4
let g:netrw_banner = 0
let g:netrw_winsize = 0
let g:netrw_liststyle=3

"termdebug stuff
packadd termdebug
let g:termdebug_wide=1

"Syntax checker settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

"remap emmet expand macro key
let g:user_emmet_leader_key='<C-x>'

"html close tag
noremap <leader>ct yypa/<ESC>k

"window control remaps
noremap <leader>h :wincmd h<CR>
noremap <leader>j :wincmd j<CR>
noremap <leader>k :wincmd k<CR>
noremap <leader>l :wincmd l<CR>
noremap <leader>vs :vsplit 
noremap <leader>sp :split 
noremap <silent> <leader>+ :vertical resize +5 <CR>
noremap <silent> <leader>- :vertical resize -5 <CR>

"tab mappings
"make leader-num go to that number tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>tn :tabnew<CR>

"syntastic remaps
"ce = closeErrors(technically it closes the location list)
noremap <leader>ce :lclose <CR>
"se = stop errors
noremap <leader>se :SyntasticToggleMode <CR>

"File tree remap
"fs=file system
noremap <leader>fs :wincmd v<bar> :Ex <bar> :wincmd H <CR> :vertical resize 20 <CR>

"youcompleteme remaps
"noremap <leader>gd :YcmCompleter GoTo <CR>
"noremap <leader>cp :pclose <CR>
"show info on what's under the cursor
"let g:ycm_auto_hover=1
"nmap <leader>D <plug>(YCMHover)

"vimscript wizardry to make copying nice
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

"change vimwiki directory
let g:vimwiki_list = [{'path': '~/.vim/mywiki/',
                      \ 'path_html': '~/Documents/mywiki_html'}]

"Template for vimwiki diary
au BufNewFile ~/.vim/mywiki/diary/*.wiki :silent 0r !~/.vim/bin/generate-vimwiki-diary-template.py '%'

"Cursor stuff
let &t_SI = "\<esc>[5 q"  " blinking I-beam in insert mode
let &t_SR = "\<esc>[3 q"  " blinking underline in replace mode
let &t_EI = "\<esc>[ q"  " default cursor (usually blinking block) otherwise

"Add large j/k movements to jumplist
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

"FZF remap
nnoremap <leader>ff :<C-u>FZF --reverse --preview batcat\ --color=always\ --style=numbers\ --line-range=:500\ {}<CR>
nnoremap <leader>fv <C-w><C-v>:<C-u>FZF<CR>

"FZF layout
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true } }
