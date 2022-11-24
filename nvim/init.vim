call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'

Plug 'junegunn/limelight.vim'

Plug 'junegunn/goyo.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/vim-jsx-improve'
Plug 'ryanoasis/vim-devicons'

Plug 'sheerun/vim-polyglot'


Plug 'ap/vim-css-color'

Plug 'wbthomason/packer.nvim', {'branch': 'master'}

Plug 'itchyny/lightline.vim'

Plug 'jiangmiao/auto-pairs'

Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }

call plug#end()


autocmd!

set nocompatible
set number
syntax enable
set fileencoding=utf-8
set encoding=utf-8
set title
set mouse=a
set autoindent
set background=dark
set nobackup
set hlsearch
set showcmd
set expandtab
set cmdheight=1
set laststatus=2
set scrolloff=10
set shell=fish

set nofoldenable
set foldlevel=99
set fillchars=fold:\
set foldtext=CustomFoldText()
setlocal foldmethod=expr
setlocal foldexpr=GetPotionFold(v:lnum)

function! GetPotionFold(lnum)
  if getline(a:lnum) =~? '\v^\s*$'
    return '-1'
  endif

  let this_indent = IndentLevel(a:lnum)
  let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

  if next_indent == this_indent
    return this_indent
  elseif next_indent < this_indent
    return this_indent
  elseif next_indent > this_indent
    return '>' . next_indent
  endif
endfunction

function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

function! NextNonBlankLine(lnum)
  let numlines = line('$')
  let current = a:lnum + 1

  while current <= numlines
      if getline(current) =~? '\v\S'
          return current
      endif

      let current += 1
  endwhile

  return -2
endfunction

function! CustomFoldText()
  " get first non-blank line
  let fs = v:foldstart

  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile

  if fs > v:foldend
      let line = getline(v:foldstart)
  else
      let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = " " . foldSize . " lines "
  let foldLevelStr = repeat("+--", v:foldlevel)
  let expansionString = repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr))
  return line . expansionString . foldSizeStr . foldLevelStr
endfunction

hi Normal guibg=none
hi Foreground guibg=#ffffff

if has('nvim')
	set inccommand=split
endif

set nosc noru nosm

set lazyredraw
set ignorecase
set smarttab
set ai
set si
filetype plugin indent on
set shiftwidth=4
set tabstop=4
set nowrap
set path+=**
set wildignore+=*/node_modules/*
set cursorline
set termguicolors
set winblend=0
set wildoptions=pum
set pumblend=5
let g:neosolarized_termtrans=1
runtime ./colors/NeoSolarized.vim

let g:lightline = {
      \ 'colorscheme': 'spaceduck',
      \ }

" =========================
" Custom Vim Functions
" =========================





"Goyo Settings
function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  hi! Normal ctermbg=NONE guibg=NONE 
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


"NERDTree setup

"Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

"Changing default NERDTree arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"KeyBind for NERDTree
"nnoremap <F4> :NERDTreeToggle<CR>
nnoremap <C-b> :NERDTreeToggle<CR>

"KeyBind for TAGbar
nmap <F8> :TagbarToggle<CR>


let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-css',
  \  'coc-eslint',
  \  'coc-prettier'
  \ ]



autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear


nnoremap <silent> K :call CocAction('doHover')<CR>


"function! s:show_hover_doc()
"  call timer_start(500, 'ShowDocIfNoDiagnostic')
"endfunction


"autocmd CursorHoldI * :call <SID>show_hover_doc()
"autocmd CursorHold * :call <SID>show_hover_doc()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>

nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>

nmap <leader>do <Plug>(coc-codeaction)

nmap <leader>rn <Plug>(coc-rename)

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

colorscheme spaceduck
