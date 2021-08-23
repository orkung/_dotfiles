if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
" Use release branch (recommend)
Plug 'cloudhead/neovim-fuzzy'
Plug 'Raimondi/delimitMate'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'glepnir/dashboard-nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/limelight.vim'
Plug 'cocopon/iceberg.vim'
Plug 'chrisbra/NrrwRgn'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'mbbill/undotree'
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'vim-syntastic/syntastic'
Plug 'airblade/vim-gitgutter'
"Plug 'maxbrunsfeld/vim-yankstack'
Plug 'szw/vim-maximizer'
Plug 'gcmt/taboo.vim'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'joom/turkish-deasciifier.vim'
Plug 'scrooloose/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'rbgrouleff/bclose.vim'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

""""""""""""""""""""""""""" settings from vimrc
nnoremap <Leader>h :nohl<CR> 
set t_Co=256
set pastetoggle=<F5>            " when in insert mode, press <F5> to go to
                                " paste mode, where you can paste mass data
                                " that won't be autoindented
au InsertLeave * set nopaste
set clipboard=unnamed
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
filetype on
filetype plugin on
filetype plugin indent on
filetype indent on
set rtp+=~/.fzf
nnoremap <F6> :UndotreeToggle<CR>
set exrc 
set secure
" YAML editor
"au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml 
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" indenLine
let g:indentLine_char = '|'
" Buffergator; buffer'lar arasi gezinme
nnoremap <C-n> :BuffergatorMruCycleNext<cr>
nnoremap <C-p> :BuffergatorMruCyclePrev<cr>
nnoremap <Leader>b :BuffergatorToggle<CR> " acik buffer'lari listele
nnoremap <C-o> :FuzzyOpen<CR>

" turkish-deasciifier; harflerdeki turkceye ozgu karakterlerin, kelimenin anlamina gore eklenip kaldirilmasini saglar.
"nnoremap <Leader>tr :<c-u>call Turkish_Deasciify()<CR>
"nnoremap <Leader>rt :<c-u>call Turkish_Asciify()<CR>
vnoremap <Leader>tr :<c-u>call Turkish_Deasciify()<CR>
vnoremap <Leader>rt :<c-u>call Turkish_Asciify()<CR>
let g:turkish_deasciifier_path = 'deasciify'
"let g:turkish_deasciifier_path = '~/Git_Repolari/diger/turkish-deasciifier/turkish-deasciify'
"let g:turkish_deasciifier_path = '~/Library/turkish-deasciifier/turkish-deasciify'


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

let g:limelight_conceal_ctermfg = 00
let g:limelight_conceal_ctermfg = 00
let g:limelight_conceal_guifg = '#002b36'
let g:limelight_conceal_guifg = '#002b36'
let g:limelight_default_coefficient = 1

" By default, it will be triggered by `ENTER` in insert mode.
" set this to 1 to use `CTRL+ENTER` instead, and keep the  
" default `ENTER` behavior unchanged.
let g:rtf_ctrl_enter = 0

" Enable formatting when leaving insert mode
let g:rtf_on_insert_leave = 1
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

"colorscheme nord
colorscheme iceberg
"colorscheme one
"colorscheme solarized8
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

command! WQ wq!
command! Wq wq!
command! W w!
command! Q q!
"set foldlevelstart=1

let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'
"""""""""""""""""""""""" vimrc bitti

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=no
endif


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='lucius'
let g:airline_powerline_fonts = 1
"let g:airline_theme='base16_solarized'
"au! BufNewFile,BufRead * colorscheme iceberg
"au! BufNewFile,BufRead * colorscheme solarized8 

let g:mapleader="\<Space>"
let g:dashboard_default_executive ='fzf'
nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
"nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
"nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
"nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
"nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
"nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
"nnoremap <silent> <Leader>cn :DashboardNewFile<CR>
nmap <silent> <buffer> gK <Plug>(kite-docs)

if (empty($TMUX))
    if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    if (has("termguicolors"))
        set termguicolors
    endif
endif

" Find files using Telescope command-line sugar.
nnoremap <leader>af :Telescope find_files<CR>
"nnoremap <leader>af :Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
"nnoremap <Leader>af :lua require('telescope.builtin').find_files()<cr>
"nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
"nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
"nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

"set operatorfunc=v.lua

"use {
"    "AcksID/nvim-neoclip.lua",
"    config = function()
"        require('neoclip').setup({
"            history = 1000,
"            filter = nil,
"        })
"    end,
"}

"inoremap <C-v> <ESC>"+pa
"vnoremap y "+y
"vnoremap yy "+y


