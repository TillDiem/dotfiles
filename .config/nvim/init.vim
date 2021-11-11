let mapleader =","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'jreybert/vimagit'
Plug 'lukesmithxyz/vimling'
Plug 'vimwiki/vimwiki'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'kovetskiy/sxhkd-vim'
Plug 'ap/vim-css-color'
Plug 'lervag/vimtex'
Plug 'terryma/vim-multiple-cursors'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-scripts/AutoComplPop'
Plug 'spolu/dwm.vim'
Plug 'jamessan/vim-gnupg'
Plug 'rhysd/vim-grammarous'
call plug#end()

set bg=light
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus

" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Goyo plugin makes text more readable when writing prose:
"	map <leader>f :Goyo \| set bg=light \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>
	map <leader>O :setlocal spell! spelllang=de_de<CR>

"Spell Checker Colors
	hi SpellBad ctermfg=White ctermbg=DarkRed

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    if has('nvim')
        let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
    else
        let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
    endif

" vimling:
	nm <leader>d :call ToggleDeadKeys()<CR>
	imap <leader>d <esc>:call ToggleDeadKeys()<CR>a
	nm <leader>i :call ToggleIPA()<CR>
	imap <leader>i <esc>:call ToggleIPA()<CR>a
	nm <leader>q :call ToggleProse()<CR>

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h map <C-j> <C-w>j map <C-k> <C-w>k
	map <C-l> <C-w>l

" Replace ex mode with gq
	map Q gq

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>

" Open my bibliography file in split
"	map <leader>b :vsp<space>$BIB<CR>
""	map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>
"	map <leader>p : !zathura <c-r>%<backspace><backspace><backspace>pdf &<CR><CR>
" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %
" Automaticly compile dwmblocks

autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }
" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	map <leader>v :VimwikiIndex
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
"Spell Checker Colors
hi SpellBad ctermfg=White ctermbg=DarkRed

" Enable Goyo by default for mutt writting
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=1000000000000000000000000000
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=light
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>
"Better Pasting
	nmap ,P o<ESC>p
" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritepre * %s/\n\+\%$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost files,directories !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb%
" Update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkj

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif

autocmd FileType tex inoremap ,<Space><Space> <Esc>/<++><Enter>"_c4l
autocmd FileType tex inoremap ;r \begin{document}<Enter><Enter>\end{document}<Esc>ki
autocmd FileType tex inoremap ;m \begin{align}<Enter><Enter>\end{align}<Esc>ki
autocmd FileType tex inoremap ;m \begin{align}<Enter><Enter>\end{align}<Esc>ki

"""LATEX
	" Word count:
	autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
	" Code snippets
	"""autocmd FileType tex inoremap	,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
	autocmd FileType tex inoremap	,fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap	,exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap	,bf \textbf{}<++><Esc>T{i
	autocmd FileType tex vnoremap 	, <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
	autocmd FileType tex inoremap	,it \textit{}<++><Esc>T{i
	autocmd FileType tex inoremap	,ct \textcite{}<++><Esc>T{i
	autocmd FileType tex inoremap	,cp \parencite{}<++><Esc>T{i
	autocmd FileType tex inoremap	,glos {\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
	autocmd FileType tex inoremap	,x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
	autocmd FileType tex inoremap	,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap	,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap	,li <Enter>\item[]<Space>
	autocmd FileType tex inoremap	,ref \ref{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap	,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
	autocmd FileType tex inoremap	,ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
	autocmd FileType tex inoremap	,can \cand{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap	,con \const{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap	,v \vio{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap	,a \href{}{<++>}<Space><++><Esc>2T{i
	autocmd FileType tex inoremap	,sc \textsc{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap	,chap \chapter{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap	,sec \section{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap	,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap	,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap	,st <Esc>F{i*<Esc>f}i
	autocmd FileType tex inoremap	,beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
	autocmd FileType tex inoremap	,up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex nnoremap 	,up /usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex inoremap	,tt \texttt{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap	,bt {\blindtext}
	autocmd FileType tex inoremap	,nu $\varnothing$
	autocmd FileType tex inoremap	,col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
	autocmd FileType tex inoremap	,rn (\ref{})<++><Esc>F}i
	autocmd FileType tex inoremap	,fr \dfrac{}{<++>} <++> <Esc>T{2hi
	autocmd FileType tex inoremap	,sqrt \sqrt{}<++> <Esc>T{i
	autocmd FileType tex inoremap	,b( \left(\right)<++><Esc>T(i
	autocmd FileType tex inoremap	,bb \mathbb{}<++><Esc>T{i
 	autocmd FileType tex inoremap	,b{ \left\{\right\}<++><Esc>T{i
	autocmd FileType tex inoremap	,b[ \left[\right]<++><Esc>T[i
	autocmd FileType tex inoremap	,rm \mathrm{}<++><Esc>T{i
 	autocmd FileType tex inoremap	,abs \left\|\right\|<++><Esc>3ba
 	autocmd FileType tex inoremap	,em \emph{}<++><Esc>T{i
	autocmd FileType tex inoremap 	,tabb \begin{tabbing}<Enter>\hspace*{3cm}\=\hspace*{3cm}\= \kill<Enter>\end{tabbing}<Enter><Enter><++><Esc>3kA<Enter>
	autocmd FileType tex inoremap 	,txt  \text{}<++><Esc>T{i
	autocmd FileType tex inoremap 	,sfr  \sfrac{}{<++>}<++><Esc>2T{i
        autocmd FileType tex inoremap ,beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
	autocmd FileType tex inoremap	,fra \begin{frame}<Enter><Enter>\end{frame}<Enter><Enter><++><Esc>3kA\frametitle{ }<Esc>i
	autocmd FileType tex inoremap	,fi \begin{figure}<Enter><Enter>\end{figure}<Enter><Enter><++><Esc>3kA\includegraphics[]{<++>}<Esc>6hi

""".bib
	autocmd FileType bib inoremap	,a @article{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>journal<Space>=<Space>{<++>},<Enter>volume<Space>=<Space>{<++>},<Enter>pages<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i
	autocmd FileType bib inoremap	,b @book{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>6kA,<Esc>i
	autocmd FileType bib inoremap	,c @incollection{<Enter>author<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>booktitle<Space>=<Space>{<++>},<Enter>editor<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i









inoremap jkj <Esc>

"""ALE

let g:ale_completion_enabled = 1
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['black', 'isort']}
let g:ale_fix_on_save = 1
set completeopt+=noinsert


" GPG: Handeling of certain file types
let g:GPGPreferArmor=1
let g:GPGDefaultRecipients=["tilld@student.ethz.ch"]
