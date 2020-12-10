""" Eklentiler
call plug#begin('~/.vim/plugged')
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'vim-syntastic/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'arcticicestudio/nord-vim'
"Plug 'flazz/vim-colorschemes'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'junegunn/limelight.vim'
Plug 'szw/vim-maximizer'
Plug 'gcmt/taboo.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'joom/turkish-deasciifier.vim'
Plug 'scrooloose/nerdtree'
Plug 'mhartington/oceanic-next'
Plug 'christoomey/vim-tmux-navigator'
Plug 'rbgrouleff/bclose.vim'
Plug 'Yggdroot/indentLine'
call plug#end()

set rtp+=~/.fzf

""" Ayarlar
filetype on
filetype plugin on
filetype plugin indent on
filetype indent on

set shell=bash\ --login
set background=dark
syntax on
set nocompatible        " don't bother with vi compatibility
set autoread            " reload files when changed on disk, i.e. via `git checkout`
set tabstop=2           " tab uzunluğu
set shiftwidth=4        " Görsel modda < ve > karakterlerine basıldığında bloğun ne kadar kaydırılacağı
set softtabstop=2       " boşluklardan oluşan feyk tabın uzunluğu
set expandtab           " tab'a basıldığında boşluk karakterlerinden oluşan feyk tab kullanılmasını sağlar.
set lbr                 " linebreak; satir sonunda alt satira hecelemeyle gecisi saglar
set tw=79               " bir satırın alabileceği karakter sayısı
set magic               " For regular expressions turn magic on
noremap <Leader>s :update<CR> " mevcbut buffer'i diske kayededer
let $PAGER='' " man page icin 
set clipboard=unnamedplus
set term=tmux-256color
set t_Co=256
"map y "+y
set pastetoggle=<F5>            " when in insert mode, press <F5> to go to
                                " paste mode, where you can paste mass data
                                " that won't be autoindented
au InsertLeave * set nopaste
" au VimResized * wincmd =      " vim itself moves the split bar... 
                                " when the window is grown, vim will not move the split bars back.
                                " this is independent of equalalways, which works only when creating new splits or
                                " closing windows. But not when resizing the surrounding window.
" set noequalalways

" YAML editor
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


""" Eklenti yapilandirma
" indenLine
let g:indentLine_char = '⦙'

" Buffergator; buffer'lar arasi gezinme
nnoremap <C-n> :BuffergatorMruCycleNext<cr>
nnoremap <C-p> :BuffergatorMruCyclePrev<cr>
nnoremap <Leader>b :BuffergatorToggle<CR> " acik buffer'lari listele

" turkish-deasciifier; harflerdeki turkceye ozgu karakterlerin, kelimenin anlamina gore eklenip kaldirilmasini saglar.
vmap <Leader>tr :<c-u>call Turkish_Deasciify()<CR>
vmap <Leader>rt :<c-u>call Turkish_Asciify()<CR>
let g:turkish_deasciifier_path = '~/Public/turkish-deasciify'
"let g:turkish_deasciifier_path = '~/Git_Repolari/diger/turkish-deasciifier/turkish-deasciify'

""" Nerdtree dizin/dosya paneli
" Leader key ile acma
"" map <Leader>n :NERDTreeMapToggleHidden<CR>
map <Leader>n :NERDTreeToggle<CR>
" Sadece NERDTREE penceresi aciksa Vim'i otomatik kapat;
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeMapJumpNextSibling = ''
let g:NERDTreeMapJumpPrevSibling = ''
let g:NERDTreeMapJumpLastChild = ''
let g:NERDTreeMapJumpFirstChild = ''
let g:NERDTreeWinSize=31
let g:NERDTreeDirArrows=0
" vim-tmux-navigator; tmux pane'leri arasinda vim kisayollariyla gezinme
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif

" Yankstack ile registers yonetimi
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste
nnoremap <leader>y :Yanks<CR>

" Taboo ile tab yonetimi
nnoremap <C-w>e :TabooOpen
nnoremap <C-w>q :tabclose!<CR>

" vim-maximizer ile pencere yonetimi
nnoremap <silent><C-w>z :MaximizerToggle<CR>
vnoremap <silent><C-w>z :MaximizerToggle<CR>gv
inoremap <silent><C-w>z <C-o>:MaximizerToggle<CR>

" Limelight
nnoremap <Leader>l :Limelight<CR>
nnoremap <Leader>k :Limelight!<CR>
let g:limelight_conceal_ctermfg = 'Black'
let g:limelight_conceal_ctermfg = 0
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
let g:limelight_default_coefficient = 1

""" Görünüm
"hi Normal guifg=#93a1a1 " metin gorunum rengi
"hi StatusLine cterm=none gui=none
"hi StatusLineNC cterm=none gui=none
"hi VertSplit ctermfg=00
"hi SignColumn ctermbg=none
"
"hi Search ctermfg=25 ctermbg=16
"hi Folded ctermfg=25 ctermbg=16
"hi NonText ctermfg=00
"hi clear SignColumn
"hi TabLineFill cterm=none gui=none
"hi TabLine ctermfg=none ctermbg=none
"hi TabLineSel ctermfg=none ctermbg=none
"set statusline=%t\ %=\ %l:%c
"set fillchars+=vert:│

"""" Window'u acik tut, buffer yonet
" buffer'i kaydet
nnoremap <Leader>w :w<bar>:Bclose!<cr>
" buffer'i kaydetme
nnoremap <Leader>q :Bclose!<cr>

" buffer'lari kaydet
noremap <Leader>s :wall<CR>
"noremap <Leader>e :wall<CR>

"""" Window'u kapatip buffer yonet
" buffer'i kaydet
noremap <S-w> :wqall!<CR>
" buffer'lari kaydetme
noremap <S-q> :bdelete!<cr>
noremap <S-e> :qall!<cr>

augroup MyColors
    autocmd!
    autocmd ColorScheme * hi Comment guifg=#002b36 guibg=#586e75 guisp=NONE gui=italic cterm=italic
augroup END
colorscheme solarized8
"colorscheme OceanicNext
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif


" Vim session
let g:session_autosave= 'no'
let g:session_autoload = 'yes' 
"set sessionoptions=buffers

"let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='base16_solarized'
au! BufNewFile,BufRead * colorscheme solarized8

