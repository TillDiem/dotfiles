let mapleader =","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'tpope/vim-surround'  " Chaning of brackets etc
Plug 'preservim/nerdtree'  " File Browser on the side bar
Plug 'junegunn/goyo.vim'   " Distraction free writing: Focusses in the middle
Plug 'PotatoesMaster/i3-vim-syntax' " TODO : DO I NEED IT?
Plug 'jreybert/vimagit'    " Check the git history
Plug 'lukesmithxyz/vimling' " Change different language keyboards
Plug 'vimwiki/vimwiki'	   " Wiki locally - write your own
Plug 'bling/vim-airline'   " Bottom Line - TODO
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary' " Use gcc to comment a lime, use gcgc to uncomment
Plug 'kovetskiy/sxhkd-vim'  " Detect X files
Plug 'ap/vim-css-color'     " Highlight CSS colors
Plug 'lervag/vimtex'        " Liverender latex
Plug 'terryma/vim-multiple-cursors'  " DEPRECATED: Using multple cursors
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " Autocomplete
Plug 'vim-scripts/AutoComplPop'    " Opens some pop-up
Plug 'spolu/dwm.vim'	     " Window management
Plug 'jamessan/vim-gnupg'    " Open Gnu pages
Plug 'rhysd/vim-grammarous'  " Grammar check
Plug 'nvim-lua/plenary.nvim'  " ni idea
Plug 'nvim-telescope/telescope.nvim' " In vim search
Plug 'arcticicestudio/nord-vim'  " Colorscheme
Plug 'ayu-theme/ayu-vim' " colorscheme
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Colorfull Icons for NERDTree
Plug 'ryanoasis/vim-devicons' "Icons for NERDTree
call plug#end()

set bg=dark
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus

set termguicolors     " enable true colors support
let ayucolor="dark" " for mirage version of theme
colorscheme ayu

let g:airline_theme='minimalist'

" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
	map <leader>tn :tabnew
" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Goyo plugin makes text more readable when writing prose:
	map <leader>gf :Goyo \| set bg=light \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>
	map <leader>O :setlocal spell! spelllang=de_de<CR>

"Spell Checker Colors
	hi SpellBad ctermfg=White ctermbg=DarkRed

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright



" Nerd tree
set guifont=DroidSansMono\ Nerd\ Font\ 11
let g:WebDevIconsOS = 'Arch'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['pdf'] = ''
" If you have vim-devicons you can customize your icons for each file type.
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
	"let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	let g:vimwiki_list = [{'path': '~/Documents/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	"let g:vimwiki_list = [{'path': '~/Documents/vimwiki', 'path_html': '~/Documents', 'syntax': 'markdown', 'ext': '.md', 'custom_wiki2html': '~/test.sh'}]
" let g:vimwiki_list = [{
"   \ 'auto_export': 1,
"   \ 'automatic_nested_syntaxes':1,
"   \ 'path_html': '$HOME/Documents/vimwiki/HTML',
"   \ 'path': '$HOME/Documents/vimwiki',
"   \ 'template_path': '/home/till/',
"   \ 'syntax': 'markdown',
"   \ 'ext':'.md',
"   \ 'template_default':'markdown',
"   \ 'custom_wiki2html': '$HOME/Documents/vimwiki/HTML/test.sh',
"   \ 'template_ext':'.html'
" \}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
"Spell Checker Colors
hi SpellBad ctermfg=White ctermbg=DarkRed

" Enable Goyo by default for mutt writting
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=100
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






"""HTML
	autocmd FileType html inoremap	,b <b></b><Space><++><Esc>FbT>i
	autocmd FileType html inoremap	,it <em></em><Space><++><Esc>FeT>i
	autocmd FileType html inoremap	,1 <h1></h1><Enter><Enter><++><Esc>2kf<i
	autocmd FileType html inoremap	,2 <h2></h2><Enter><Enter><++><Esc>2kf<i
	autocmd FileType html inoremap	,3 <h3></h3><Enter><Enter><++><Esc>2kf<i
	autocmd FileType html inoremap	,p <p></p><Enter><Enter><++><Esc>02kf>a
	autocmd FileType html inoremap	,a <a<Space>href=""><++></a><Space><++><Esc>14hi
	autocmd FileType html inoremap	,e <a<Space>target="_blank"<Space>href=""><++></a><Space><++><Esc>14hi
	autocmd FileType html inoremap	,ul <ul><Enter><li></li><Enter></ul><Enter><Enter><++><Esc>03kf<i
	autocmd FileType html inoremap	,li <Esc>o<li></li><Esc>F>a
	autocmd FileType html inoremap	,ol <ol><Enter><li></li><Enter></ol><Enter><Enter><++><Esc>03kf<i
	autocmd FileType html inoremap	,im <img src="" alt="<++>"><++><esc>Fcf"a
	autocmd FileType html inoremap	,td <td></td><++><Esc>Fdcit
	autocmd FileType html inoremap	,tr <tr></tr><Enter><++><Esc>kf<i
	autocmd FileType html inoremap	,th <th></th><++><Esc>Fhcit
	autocmd FileType html inoremap	,tab <table><Enter></table><Esc>O
	autocmd FileType html inoremap	,gr <font color="green"></font><Esc>F>a
	autocmd FileType html inoremap	,rd <font color="red"></font><Esc>F>a
	autocmd FileType html inoremap	,yl <font color="yellow"></font><Esc>F>a
	autocmd FileType html inoremap	,dt <dt></dt><Enter><dd><++></dd><Enter><++><esc>2kcit
	autocmd FileType html inoremap	,dl <dl><Enter><Enter></dl><enter><enter><++><esc>3kcc
	autocmd FileType html inoremap &<space> &amp;<space>
	autocmd FileType html inoremap á &aacute;
	autocmd FileType html inoremap é &eacute;
	autocmd FileType html inoremap í &iacute;
	autocmd FileType html inoremap ó &oacute;
	autocmd FileType html inoremap ú &uacute;
	autocmd FileType html inoremap ä &auml;
	autocmd FileType html inoremap ë &euml;
	autocmd FileType html inoremap ï &iuml;
	autocmd FileType html inoremap ö &ouml;
	autocmd FileType html inoremap ü &uuml;
	autocmd FileType html inoremap ã &atilde;
	autocmd FileType html inoremap ẽ &etilde;
	autocmd FileType html inoremap ĩ &itilde;
	autocmd FileType html inoremap õ &otilde;
	autocmd FileType html inoremap ũ &utilde;
	autocmd FileType html inoremap ñ &ntilde;
	autocmd FileType html inoremap à &agrave;
	autocmd FileType html inoremap è &egrave;
	autocmd FileType html inoremap ì &igrave;
	autocmd FileType html inoremap ò &ograve;
	autocmd FileType html inoremap ù &ugrave;


""".bib
	autocmd FileType bib inoremap	,a @article{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>journal<Space>=<Space>{<++>},<Enter>volume<Space>=<Space>{<++>},<Enter>pages<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i
	autocmd FileType bib inoremap	,b @book{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>6kA,<Esc>i
	autocmd FileType bib inoremap	,c @incollection{<Enter>author<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>booktitle<Space>=<Space>{<++>},<Enter>editor<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i

"MARKDOWN
	autocmd Filetype markdown,rmd map <leader>w yiWi[<esc>Ea](<esc>pa)
	autocmd Filetype markdown,rmd inoremap	,n ---<Enter><Enter>
	autocmd Filetype markdown,rmd inoremap	,b ****<++><Esc>F*hi
	autocmd Filetype markdown,rmd inoremap	,s ~~~~<++><Esc>F~hi
	autocmd Filetype markdown,rmd inoremap	,e **<++><Esc>F*i
	autocmd Filetype markdown,rmd inoremap	,h ====<Space><++><Esc>F=hi
	autocmd Filetype markdown,rmd inoremap	,i ![](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap	,a [](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap	,1 #<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap	,2 ##<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap	,3 ###<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap	,l --------<Enter>
	autocmd Filetype markdown,rmd inoremap	,r ```{r}<CR>```<CR><CR><esc>2kO
	autocmd Filetype markdown,rmd inoremap	,p ```{python}<CR>```<CR><CR><esc>2kO
	autocmd Filetype mardown,rmd inoremap	,c ```<cr>```<cr><cr><esc>2kO

""".xml
	autocmd FileType xml inoremap	,e <item><Enter><title><++></title><Enter><guid<space>isPermaLink="false"><++></guid><Enter><pubDate><Esc>:put<Space>=strftime('%a, %d %b %Y %H:%M:%S %z')<Enter>kJA</pubDate><Enter><link><++></link><Enter><description><![CDATA[<++>]]></description><Enter></item><Esc>?<title><enter>cit
	autocmd FileType xml inoremap	,a <a href="<++>"><++></a><++><Esc>F"ci"

"Better Escape
inoremap jkj <Esc>


nnoremap <silent> <F5> :call SaveAndExecutePython()<CR>
vnoremap <silent> <F5> :<C-u>call SaveAndExecutePython()<CR>

function! SaveAndExecutePython()
    " SOURCE [reusable window]: https://github.com/fatih/vim-go/blob/master/autoload/go/ui.vim

    " save and reload current file
    silent execute "update | edit"

    " get file path of current file
    let s:current_buffer_file_path = expand("%")

    let s:output_buffer_name = "Python"
    let s:output_buffer_filetype = "output"

    " reuse existing buffer window if it exists otherwise create a new one
    if !exists("s:buf_nr") || !bufexists(s:buf_nr)
        silent execute 'botright new ' . s:output_buffer_name
        let s:buf_nr = bufnr('%')
    elseif bufwinnr(s:buf_nr) == -1
        silent execute 'botright new'
        silent execute s:buf_nr . 'buffer'
    elseif bufwinnr(s:buf_nr) != bufwinnr('%')
        silent execute bufwinnr(s:buf_nr) . 'wincmd w'
    endif

    silent execute "setlocal filetype=" . s:output_buffer_filetype
    setlocal bufhidden=delete
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nobuflisted
    setlocal winfixheight
    setlocal cursorline " make it easy to distinguish
    setlocal nonumber
    setlocal norelativenumber
    setlocal showbreak=""

    " clear the buffer
    setlocal noreadonly
    setlocal modifiable
    %delete _

    " add the console output
    silent execute ".!python " . shellescape(s:current_buffer_file_path, 1)

    " resize window to content length
    " Note: This is annoying because if you print a lot of lines then your code buffer is forced to a height of one line every time you run this function.
    "       However without this line the buffer starts off as a default size and if you resize the buffer then it keeps that custom size after repeated runs of this function.
    "       But if you close the output buffer then it returns to using the default size when its recreated
    "execute 'resize' . line('$')

    " make the buffer non modifiable
    setlocal readonly
    setlocal nomodifiable
endfunction

"Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


"""ALE

let g:ale_completion_enabled = 1
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['black', 'isort']}
let g:ale_fix_on_save = 1
set completeopt+=noinsert


""""COC config

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=no

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

"inoremap <expr><S-C-space> pumvisible() ? "\<C-p>" : "\<C-h>"
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
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
  else
    call CocAction('doHover')
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

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

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

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" GPG: Handeling of certain file types
let g:GPGPreferArmor=1
let g:GPGDefaultRecipients=["tilld@student.ethz.ch"]
