" Preamble
    set nocompatible              " be iMproved, required
    filetype off                  " required - can turn off later

" Plugins with Vundle 
    "Finds the path to Vundle
        let hostname = substitute(system('hostname'), '\n', '', '')
        if hostname == "MR"
            set rtp+=C:/Users/User/.vim/bundle/Vundle.vim
        elseif hostname() == "acer-artix"
            set rtp+=/home/dan/.vim/bundle/Vundle.vim
        endif

    call vundle#begin()
    " Seem to have to swap these first two, depending on the PC
    Plugin 'gmarik/Vundle.vim' " let Vundle manage Vundle, required
    "Plugin 'VundleVim/Vundle.vim' " let Vundle manage Vundle, required - Acer-Artix (update May '22 - this line now doesnt work on acer-artix)
    Plugin 'ervandew/supertab' " Tab completion
    Plugin 'vim-latex/vim-latex' "Vim Latex
    Plugin 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
    Plugin 'vim-scripts/indentpython.vim' " indentpython.vim extension
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'preservim/nerdtree'
    Plugin 'rafi/awesome-vim-colorschemes' "color schemes
    Plugin 'zorab47/vim-gams.git' "GAMS syntax highlighting
    Plugin 'itchyny/lightline.vim' "Allows changing the status bar colour
    Plugin 'jiangmiao/auto-pairs' "Adds the matching close bracket
    Plugin 'airblade/vim-gitgutter' "Shows git symbols in the 'gutter'
    Plugin 'mattn/emmet-vim' "HTML plugin
    Plugin 'chrisbra/csv.vim' "CSV plugin
    Plugin 'iamcco/markdown-preview.nvim' "Markdown previewer - may need to run ':call mkdp#util#install() to get it to work
    Plugin 'tpope/vim-ragtag' " HTML (and other languages) assisstant
    Plugin 'ap/vim-css-color' "CSS colour name highlighter
    Plugin 'kezhenxu94/vim-mysql-plugin.git'
    Plugin 'preservim/tagbar' "TagBar"
    call vundle#end()            " required

" General
    au GUIEnter * simalt ~x " Open full screen

    " Lightline scheme and make it reload when changing buffer
        let g:lightline = {'colorscheme': 'darcula'} "Lightline changes the status bar colour scheme"
        autocmd BufEnter * call lightline#enable()

    " Colorscheme
        if has('unix') != 1
            colorscheme orbital
        endif
        if has('unix') == 1
            highlight Folded ctermbg=None ctermfg=Red
        endif

    " Automatically avoid weird indents when pasting from system clipboard.
        let &t_SI .= "\<Esc>[?2004h"
        let &t_EI .= "\<Esc>[?2004l"

        inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

        function! XTermPasteBegin()
            set pastetoggle=<Esc>[201~
            set paste
            return ""
        endfunction

    " General editing
        syntax enable           " enable syntax processing
        set shiftwidth=4
        set tabstop=4           " number of visual spaces per TAB
        set softtabstop=4       " number of spaces in tab when editing
        set expandtab           " tabs are spaces
        set autoread            " auto reload changed files (e.e. *.lst)
        set number              " show line numbers
        set relativenumber
        set cursorline          " highlight current line
        set showmatch           " highlight matching [{()}]
        set incsearch           " search as characters are entered
        set hlsearch            " highlight matches
        set smartcase           " ignore case if search pattern is all lower case, case-sensitive otherwise
        set copyindent          " copy the previous indentation on auto-indenting
        set noswapfile
        filetype plugin on      " Used by nerdcommenter to get 'comment string'

    " jk is escape and kj is escape write 
        inoremap jk <esc>l
        inoremap kj <esc>l:w<CR>

    " change leader
        let mapleader=" "

    " Toggles spell check with leader-o    
        nnoremap <leader>s :set spell! <CR>

    "split navigations - basically the same as the nav keys, but with ctrl
        nnoremap <C-J> <C-W><C-J>
        nnoremap <C-K> <C-W><C-K>
        nnoremap <C-L> <C-W><C-L>
        nnoremap <C-H> <C-W><C-H>

    "Start NERDTree always (unless on unix) and show bookmarks
        if has('unix') != 1
            autocmd VimEnter * NERDTree
        endif
        autocmd VimEnter * wincmd p
        let NERDTreeShowBookmarks=1

        "leader-n toggles NERDTree
        autocmd VimEnter * nmap <leader>n :NERDTreeToggle<CR>

    " Clean things up a bit    
        set guioptions-=L "Remove scrollbar
        set guioptions-=T "Remove Toolbar
        set guioptions-=m "Remove Menubar

    " Make vsplits open to right, splits open below
        :set splitright
        :set splitbelow

    " Chnage line endings to dos
        map <leader>led :e ++ff=dos<CR>

    " Disable annoying bells
        autocmd GUIEnter * set vb t_vb=

    " Insert newline below using ctrl-j while in normal mode
        nnoremap <leader><n> A<CR><ESC>k

    " Fix accidentally hitting F1 and bringing up help instead of esc     
        inoremap <F1> <esc>
        vnoremap <F1> <esc>

    " Auto complete lines
        inoremap <S-Tab> <C-x><C-l> 

" Folding 
    " Enable folding
        set foldenable          

    " 10 nested fold max
        set foldnestmax=10      

    "space f open/closes folds
        nnoremap <space>f za

    " fold based on indent level
        set foldmethod=indent 

" Python Commands
    " Special auto indent for python
    au BufNewFile,BufRead *.py
        \ set tabstop=4 |
        \ set softtabstop=4 |
        \ set shiftwidth=4 |
        \ set textwidth=99 |
        \ set expandtab |
        \ set autoindent |
        \ set fileformat=unix |
        \ set breakat=\ ^I!@*-+;:,./?\(\[\{ |
        \ set linebreak |
        \ set foldmethod=indent

        set encoding=utf-8  " UTF8 with python

    " Shortcuts to run code
    let g:python_run_main = 1
    autocmd FileType python3 nnoremap <buffer> <leader>g :w<CR>:! clear && python main.py<CR>
    autocmd FileType python nnoremap <buffer> <leader>g :w<CR>:! clear && python main.py<CR>

    nnoremap <leader>gg :call PythonRunToggle()<CR>
        function! PythonRunToggle()
            if g:python_run_main
                autocmd FileType python3 nnoremap <buffer> <leader>g :w<CR>:! clear && python %<CR>
                autocmd FileType python nnoremap <buffer> <leader>g :w<CR>:! clear && python %<CR>
                let g:python_run_main = 0
            else
                autocmd FileType python3 nnoremap <buffer> <leader>g :w<CR>:! clear && python main.py<CR>
                autocmd FileType python nnoremap <buffer> <leader>g :w<CR>:! clear && python main.py<CR>
                let g:python_run_main = 1
            endif
        endfunction

        autocmd FileType python3 nnoremap <buffer> <F7> :w<CR>:! clear && python -m unittest<CR>
        autocmd FileType python nnoremap <buffer> <F7> :w<CR>:! clear && python -m unittest<CR>
        "
    " leader-dj means running django, so F9 does runserver
        map <leader>jd :w <CR> :!python manage.py runserver <CR>

    " Make python code pretty
        let python_highlight_all=1

    " Direct python output to a vim window, not to the external shell
        autocmd Filetype python nnoremap <buffer> <F6> :w<CR>:ter python "%"<CR>
        autocmd Filetype python let @e = "oexit()"
        autocmd Filetype python let @b = "obreakpoint()"
        autocmd Filetype python let @n = "|f=a \\\<CR>kj"
        
    " Map leader-t to toggle tagbar
    nmap <leader>t :TagbarToggle<CR>

" Latex Suite 
    " REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.

    " IMPORTANT: win32 users will need to have 'shellslash' set so that latex
    " can be called correctly.
    set shellslash

    " OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
    " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
    " The following changes the default filetype back to 'tex':
    let g:tex_flavor='latex'


        if hostname == "TPad"
            set grepprg=grep\ -nH\ $*
        endif

" Tex Commands
    au BufNewFile,BufRead *.tex
        \ set textwidth=8000       " will auto indent after this

     "autocmd BufEnter *.tex colorscheme atom

    " Save before compiling with leader t or F9
    autocmd BufEnter *.tex map <Leader>t :w<CR><Leader>ll 
    autocmd BufEnter *.tex map <F9> <Leader>t
        
    autocmd Filetype tex let @a = "a\\added{}"
    autocmd Filetype tex let @d = "xi\\deleted{}kjPa"
    autocmd Filetype tex let @r = "xi\\replaced{}{}kjPa"

    "stop vim suite closing the file I compiled and opening something else
    let g:Tex_GotoError=0"

    let g:Tex_DefaultTargetFormat='pdf'
    let g:Tex_ViewRule_pdf='SumatraPDF'
    let g:Tex_ViewRule_dvi='SumatraPDF'
    let g:latex_viewer='SumatraPDF'
    let g:Tex_MultipleCompileFormats='pdf,bibtex,pdf'

" GAMS
    " Define file type
        au BufRead,BufNewFile *.gms set filetype=gams

    " F9 runs the code.  Would be nice if it produced a log file.  
        autocmd FileType gams nnoremap <buffer> <F9> :w !gams % errmsg=1<CR><CR>

    " Leader e goes to the next error
        autocmd BufRead,BufNewFile *.lst nnoremap <buffer> <leader>e :/\*\*\*\*<CR>

" Processing
    " Python
        if filereadable("_vimrc_processing")
            so _vimrc_processing
        else
            if filereadable("../_vimrc_processing")
                 so ../_vimrc_processing
            endif
        endif
    " Java
        " F9 runs the sketch.
            autocmd FileType arduino nnoremap <buffer> <F9> :w<CR>:!prun<CR>

"Pymode
    ""Pymode uses python 2 by default. Make it use python 3
        :filetype indent on

        let g:pymode_python = 'python3'

        let g:pymode_options_max_line_length = 99
        let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
        let g:pymode_options_colorcolumn = 1
       
    "Seem to need to set these on MR
        if hostname == "MR"
            set pythonthreehome=C:\Users\User\AppData\Local\Programs\Python\Python38-32
            set pythonthreedll=C:\Users\User\AppData\Local\Programs\Python\Python38-32\python38.dll
            let $PYTHONHOME = 'C:\Users\User\AppData\Local\Programs\Python\Python38-32'
        endif 

    "Avoids an annoying warning
        if has('python3')
          silent! python3 1
        endif

"VIMRC
    " leader-rc opens the syncthing vimrc
        if hostname == "MR"
            map <leader>rc :tabnew ~/Documents/syncthing/code/vimrc_file/_vimrc<CR>
        elseif hostname() == "acer-artix"
            map <leader>rc :tabnew ~/.vim/vimrc<CR>
        endif 

    " leader-g saves, sources and re-opens
       au BufRead,BufNewFile vimrc nnoremap <buffer> <leader>g :w<CR>:so %<CR>:e %<CR>

"R
    "Run with F9
        autocmd FileType r nnoremap <buffer> <F9> :w <CR> :!Rscript.exe %<CR>

" Markdown
    au BufNewFile, BufRead *.md
        \ set textwidth=8000       " will auto indent after this
    autocmd BufEnter *.md map <F9>:w<CR>

    " set to 1, nvim will open the preview window after entering the markdown buffer default: 0
    let g:mkdp_auto_start = 1
    " set to 1, the vim will refresh markdown when save the buffer or
    " leave from insert mode, default 0 is auto refresh markdown as you edit or
    " move the cursor
    " default: 0
    
" CSV Commands
    au BufNewFile,BufRead *.csv nnoremap <buffer> <CR> :HiColumn<CR>
    let g:csv_default_delim=','


    " F9 runs the code.  Would be nice if it produced a log file.  
        autocmd FileType gams nnoremap <buffer> <F9> :w !gams % errmsg=1<CR><CR>

" Text File commands
    au BufNewFile, BufRead *.txt
        \ set textwidth=8000       " will auto indent after this

" Java
    autocmd FileType javascript nnoremap <buffer> <F9> :w<CR>:!clear && node %<CR>

" Shell
    autocmd FileType sh nnoremap <buffer> <F9> :w<CR>:! ./%<CR>
