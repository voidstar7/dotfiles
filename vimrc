filetype plugin on
syntax on
set notermguicolors
colorscheme default
" this seems so unnecessary to have to source .vimrc on load just to make my colors work
autocmd VimEnter * source ~/.vimrc

if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'michal-h21/vim-zettel'
Plug 'mattn/calendar-vim'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'salsifis/vim-qfmanip'
Plug 'farconics/victionary'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-liquid'
if has('nvim')
	" nvim plugins go here
endif
call plug#end()

" reload .vimrc after exiting Goyo
autocmd!  User GoyoLeave nested set bg=light

" settings for neomutt buffers
autocmd FileType mail set textwidth=0

" recognize YAML frontmatter on jekyll .md files
" https://www.codeography.com/2010/02/20/making-vim-play-nice-with-jekylls-yaml-front-matter.html
autocmd BufNewFile,BufRead */jekyll/*/*/*.md syntax match Comment /\%^---\_.\{-}---$/

" set filetype=liquid for html files in ~/jekyll/*
autocmd BufRead,BufNewFile */jekyll/*/*.html set syntax=liquid

" restore custom colors on Goyo exit
" broken now that I put everything back in .vimrc
"function! s:update_highlights()
"	source ~/.vim/highlight.vim
"endfunction
"autocmd! colorscheme default call s:update_highlights()
"autocmd! colorscheme vim call s:update_highlights()

" uses xterm256 codes
" https://www.ditig.com/publications/256-colors-cheat-sheet
highlight LineNr ctermfg=250
highlight Conceal ctermbg=none
highlight ErrorMsg term=standout ctermfg=231 ctermbg=9
highlight Error term=standout ctermfg=231 ctermbg=9
highlight SpellBad term=standout ctermfg=231 ctermbg=9
highlight MatchParen ctermfg=black ctermbg=11
highlight Visual ctermbg=254
highlight Folded ctermbg=255
highlight VertSplit ctermbg=16
highlight StatusLineNC ctermfg=16
highlight cursorLine cterm=none ctermbg=255
highlight cursorColumn cterm=none ctermbg=255
highlight cursorLineNr cterm=none ctermfg=245 ctermbg=255

let &t_SI.="\e[6 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)
let g:vimwiki_list = [{'path': '~/vimwiki/','syntax': 'markdown', 'ext': '.md'}]
"https://github.com/vimwiki/vimwiki/issues/95
let g:vimwiki_global_ext = 0 
let g:vimwiki_create_link = 0
let g:vimwiki_use_calendar = 1 
let g:vimwiki_url_maxsave = 0 
" set theme for vimwiki fzf preview window
let $BAT_THEME='GitHub' 
let g:zettel_options = [{"template": "~/vimwiki/templates/note.tpl", "disable_front_matter": 1},
			\{"template": "~/shopwiki/templates/note.tpl", "disable_front_matter": 1}]
let g:zettel_format = "%y%m%d%random"
let g:zettel_random_chars = "5"
let g:zettel_backlinks_title_level = 2
let g:goyo_width = 70 
let g:NERDTreeShowHidden= 1
let g:NERDTreeMinimalUI= 1
let g:NERDTreeShowBookmarks = 1
let g:markdown_folding = 1
let g:vimwiki_folding='custom'
let g:calendar_keys = { 'goto_next_month': '<C-Right', 'goto_prev_month': 'C-Left', 'goto_next_year': 'C-Up', 'goto_prev_year': 'C-Down' }

set wrap
set linebreak
set nolist
set rnu
set nu
set fillchars+=vert:\  
set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%)\ %P
set confirm
"set nofoldenable https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
set foldlevelstart=20
set shiftwidth=2
set tabstop=2
set bg=light
set nohlsearch
set foldmethod=syntax
set cursorline
"set listchars=eol:$

map <F1> :NERDTree<CR>
map <F2> :VimwikiUISelect<CR>
map <F3> :Calendar<CR>
map <F4> :VimwikiDiaryGenerateLinks<CR>
map <F5> :Goyo<CR>
map <F6> :Goyo!<CR>
map <F7> :VimwikiRebuildTags<CR>
map <F10> :so ~/.vimrc<CR>
map <leader>o :ZettelOpen<CR>
map <leader>i :ZettelSearch<CR>
map <leader>n :ZettelNew<CR>

nnoremap <C-z> <nop>
" https://stackoverflow.com/questions/59773445/vim-ack-ag-search-in-directory-of-file-that-you-are-editing-in
nnoremap <leader>f <Esc>:cd %:p:h<CR><Esc>:Ag<CR>
nnoremap <leader>F <Esc>:cd %:p:h<CR><Esc>:Files<CR>
nnoremap <leader>b <Esc>:Buffers<CR>
nnoremap <Down> <C-d>
nnoremap <Up> <C-u>
nmap <S-j> <C-e>
nmap <S-k> <C-y>
"nmap <S-f> <C-d>
"nmap <S-d> <C-u>
nmap <C-h> :tabp<CR>
nmap <C-l> :tabn<CR>
nmap <Space> :
nmap <M-h> <C-w>h
nmap <M-l> <C-w>l
nmap <M-k> <C-w>k
nmap <M-j> <C-w>j
nmap <M-S-j> <C-w>+
nmap <M-S-k> <C-w>-
nmap <M-S-h> <C-w><
nmap <M-S-l> <C-w>>
imap <Left> <C-o><C-w>h<Esc>
imap <Right> <C-o><C-w>l<Esc>
imap <Up> <C-o><C-w>k<Esc>
imap <Down> <C-o><C-w>j<Esc>
" https://vi.stackexchange.com/questions/11772/skip-over-closing-html-tag
inoremap <C-f> <esc>f>a
