" ---------------------------------      Preamble           --------------
    " Required
        set nocompatible
        filetype off
" ---------------------------------      Vundle             --------------
    "Set Vundle path
        let hostname = substitute(system('hostname'), '\n', '', '')
        if hostname == "MR"
            set rtp+=C:/Users/User/.vim/bundle/Vundle.vim
        elseif hostname() == "acer-artix"
            set rtp+=/home/dan/.vim/bundle/Vundle.vim
        endif

    call vundle#begin()
    " Seem to have to swap these first two, depending on the PC
    "Plugin 'gmarik/Vundle.vim'                     " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'                   " let Vundle manage Vundle, required
    Plugin 'ervandew/supertab'                      " Tab completion
    Plugin 'vim-latex/vim-latex'                    " Vim Latex
    Plugin 'vim-scripts/indentpython.vim'           " indentpython.vim extension
    Plugin 'scrooloose/nerdcommenter'               " useful commenting
    Plugin 'preservim/nerdtree'                     " provides a navigation window
    Plugin 'rafi/awesome-vim-colorschemes'          " color schemes
    Plugin 'zorab47/vim-gams.git'                   " GAMS syntax highlighting
    Plugin 'itchyny/lightline.vim'                  " Allows changing the status bar colour
    Plugin 'airblade/vim-gitgutter'                 " Shows git symbols in the 'gutter'
    Plugin 'mattn/emmet-vim'                        " HTML plugin
    Plugin 'chrisbra/csv.vim'                       " CSV pluginn n n n 'kezhenxu94/vim-mysql-plugin.git'
    Plugin 'iamcco/markdown-preview.nvim'           " Markdown previewer. Run ':call mkdp#util#install() to make it  work
    Plugin 'tpope/vim-ragtag'                       " HTML (and other languages) assisstant
    Plugin 'ap/vim-css-color'                       " CSS colour name highlighter
    Plugin 'preservim/tagbar'                       " Organises tags of functions and things to navigate quickly
    Plugin 'tpope/vim-surround'                     " Vim surround for brackets and things
    Plugin 'tpope/vim-fugitive'                     " premier git plugin for Vim... apparently
    Plugin 'Townk/vim-autoclose'                    " Auto-close brackets and tings
    Plugin 'kkoomen/vim-doge'                       " 
    Plugin 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
    call vundle#end()            " required 
" ---------------------------------      General            --------------
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
        set ignorecase
        set smartcase           " ignore case if search pattern is all lower case, case-sensitive otherwise
        set copyindent          " copy the previous indentation on auto-indenting
        set noswapfile
        set updatetime=100  " Will update gitgutter (and other things) more regularly
        filetype plugin on      " Used by nerdcommenter to get 'comment string'

    " jk is escape and kj is escape write 
        inoremap jk <esc>l
        inoremap kj <esc>l:w<CR>

    "split navigations - basically the same as the nav keys, but with ctrl
        nnoremap <C-J> <C-W><C-J>
        nnoremap <C-K> <C-W><C-K>
        nnoremap <C-L> <C-W><C-L>
        nnoremap <C-H> <C-W><C-H>

    " Make vsplits open to right, splits open below
        :set splitright
        :set splitbelow
        
    " Fix accidentally hitting F1 and bringing up help instead of esc     
        inoremap <F1> <esc>
        vnoremap <F1> <esc>
    " Colorscheme
        nnoremap <leader>qc1 :colorscheme  256_noir<CR>
        nnoremap <leader>qc2 :colorscheme  elflord<CR>
" ---------------------------------      Functions          --------------
    " Avoid
    " Avoid indents when pasting from system clipboard.
        let &t_SI .= "\<Esc>[?2004h"
        let &t_EI .= "\<Esc>[?2004l"

        inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

        function! XTermPasteBegin()
            set pastetoggle=<Esc>[201~
            set paste
            return ""
        endfunction
" ---------------------------------      Leader mappings    --------------
    let mapleader=" "

    " Toggles spell check with leader-s    
        nnoremap <leader>s :set spell! <CR>

    " Chnage line endings to dos
        map <leader>led :e ++ff=dos<CR>

    " Insert newline below using leader-j while in normal mode
        nnoremap <leader>j o<ESC>k

    " Auto complete lines
        inoremap <S-Tab> <C-x><C-l> 

    " Change directory shortcuts
        nnoremap <leader>cd :cd %:h<CR>
        nnoremap <leader>lcd :lcd %:h<CR>
" ---------------------------------      GUI/WINDOWS        --------------
    " General things
        au GUIEnter * simalt ~x " Open full screen
        autocmd GUIEnter * set vb t_vb= " Disable annoying bells

    " More minimal style
        set guioptions-=L "Remove scrollbar
        set guioptions-=T "Remove Toolbar
        set guioptions-=m "Remove Menubar

    "Start NERDTree always (unless on unix) and show bookmarks
        if has('unix') != 1
            autocmd VimEnter * NERDTree
        endif
        autocmd VimEnter * wincmd p
        
    " Colorscheme
        if has('unix') != 1
            colorscheme orbital
        endif
        if has('unix') == 1
            highlight Folded ctermbg=None ctermfg=Red
        endif
" ---------------------------------      Plugins            --------------
    " NERDTree
        let NERDTreeShowBookmarks=1
        "
        " leader-n toggles NERDTree
            autocmd VimEnter * nmap <leader>n :NERDTreeToggle<CR>
            
    " Lightline 
        " Lightline colorscheme and make it reload when changing buffer
        let g:lightline = {'colorscheme': 'darcula'} "Lightline changes the status bar colour scheme"
        autocmd BufEnter * call lightline#enable()
" ---------------------------------      Folding            --------------
    " Enable folding
        set foldenable          

    " 10 nested fold max
        set foldnestmax=10      

    "leader-f open a folds at cursor and leader-qf opens all folds at cursor
        nnoremap <leader>f za
        nnoremap <leader>qf zO

    " fold based on indent level
        set foldmethod=indent 
    
    " Toggle folding only the modified lines from gitgutter
        nnoremap <leader>qg :GitGutterFold<CR>

    " Map leader-t to toggle tagbar
        nmap <leader>t :TagbarToggle<CR>
" ---------------------------------      Python             --------------
    " Auto-indent
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
    autocmd FileType python nnoremap <leader>g :w<CR>:!python main.py<CR>
    autocmd FileType python3 nnoremap <leader>g :w<CR>:!python main.py<CR>
    nnoremap <leader>qg :call PythonSetRunFile(@%)<CR>
    function! PythonSetRunFile(python_file)
        execute 'autocmd FileType python nnoremap <leader>g :w<CR>:!python '.a:python_file.'<CR>'
        execute 'autocmd FileType python3 nnoremap <leader>g :w<CR>:!python '.a:python_file.'<CR>'
        :e
    endfunction

    autocmd FileType python3 nnoremap <buffer> <F7> :w<CR>:!python -m unittest<CR>
    autocmd FileType python nnoremap <buffer> <F7> :w<CR>:!python -m unittest<CR>
        
    " leader-dj means running django, so qjd starts runserver
        map <leader>qjd :w <CR> :!python manage.py runserver<CR>

    " Make python code pretty
        let python_highlight_all=1

    " Direct python output to a vim window, not to the external shell
        autocmd Filetype python nnoremap <buffer> <F6> :w<CR>:ter python "%"<CR>

    " Macros - add exit() and breakpoint()
        autocmd Filetype python nnoremap <buffer> <leader>e oexit() 
        autocmd Filetype python nnoremap <buffer> <leader>e obreakpoint()
" ---------------------------------      Pymode             --------------
    " Settings
        let g:pymode_options_max_line_length = 99
        let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
        let g:pymode_options_colorcolumn = 1
       
    :filetype indent on
    " Pymode uses python 2 by default. Make it use python 3
        let g:pymode_python = 'python3'

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
" ---------------------------------      Latex Suite        --------------
    " REQUIRED.
    " This makes vim invoke Latex-Suite when you open a tex file.
    " IMPORTANT: win32 users will need to have 'shellslash' set so that latex
    " can be called correctly.
    set shellslash

    " OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
    " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
    " The following changes the default filetype back to 'tex':
    let g:tex_flavor='latex'
" ---------------------------------      Tex                --------------
    " Avoids indents
    au BufNewFile,BufRead *.tex set textwidth=8000

     "autocmd BufEnter *.tex colorscheme atom

    " Save before compiling with leader t
    autocmd BufEnter *.tex map <Leader>g :w<CR><Leader>ll 
        
    "stop vim suite closing the file I compiled and opening something else
    let g:Tex_GotoError=0"

    let g:Tex_DefaultTargetFormat='pdf'
    let g:Tex_ViewRule_pdf='SumatraPDF'
    let g:Tex_ViewRule_dvi='SumatraPDF'
    let g:latex_viewer='SumatraPDF'
    let g:Tex_MultipleCompileFormats='pdf,bibtex,pdf'
" ---------------------------------      GAMS               --------------
    " Define file type
        au BufRead,BufNewFile *.gms set filetype=gams

    "leader-g runs the code.  Would be nice if it produced a log file.  
        autocmd FileType gams nnoremap <buffer> <leader>g :w !gams % errmsg=1<CR><CR>
    " Leader e goes to the next error
        autocmd BufRead,BufNewFile *.lst nnoremap <buffer> <leader>e :/\*\*\*\*<CR>
" ---------------------------------      Processing         --------------
    " Python
        if filereadable("_vimrc_processing")
            so _vimrc_processing
        else
            if filereadable("../_vimrc_processing")
                 so ../_vimrc_processing
            endif
        endif
    " Java
        " leader-g runs the sketch.
            autocmd FileType arduino nnoremap <buffer> <leader>g :w<CR>:!prun<CR>
" ---------------------------------      VIMRC              --------------
    " leader-rc opens
        if hostname == "MR"
            map <leader>rc :tabnew ~/vimfiles/vimrc<CR>
        elseif hostname() == "acer-artix"
            map <leader>rc :tabnew ~/.vim/vimrc<CR>
        endif 

    " leader-g saves, sources and re-opens
       au BufRead,BufNewFile vimrc nnoremap <buffer> <leader>g :w<CR>:so %<CR>:e %<CR>

    " leader-c cleans and leader-i installs
        nnoremap <leader>c :so %<CR>:PluginClean<CR>
        nnoremap <leader>i :so %<CR>:PluginInstall<CR>
" ---------------------------------      R                  --------------
    "leader-g runs
        autocmd FileType r nnoremap <buffer> <leader>g :w <CR> :!Rscript.exe %<CR>
" ---------------------------------      Markdown           --------------
    " Avoid autoindents
    au BufNewFile, BufRead *.md set textwidth=8000

    " set to 1, vim opens the preview window after entering the markdown buffer default: 0
    let g:mkdp_auto_start = 1
" ---------------------------------      CSV                --------------
    " Settings
        let g:csv_default_delim=','
        au BufNewFile,BufRead *.csv nnoremap <buffer> <CR> :HiColumn<CR>
" ---------------------------------      GAMS               --------------
    " <leader>g runs
        autocmd FileType gams nnoremap <buffer>g :w !gams % errmsg=1<CR><CR>
" ---------------------------------      txt files          --------------
    " Avoid autoindents
    au BufNewFile, BufRead *.txt set textwidth=8000
" ---------------------------------      Java               --------------
    " leader-g runs
        autocmd FileType javascript nnoremap <buffer> <leader>g :w<CR>:!clear && node %<CR>
" ---------------------------------      Shell              --------------
    " leader-g runs
        autocmd FileType sh nnoremap <buffer> <leader>g :w<CR>:! clear && ./%<CR>
" ---------------------------------      C                  --------------
    " leader-g runs
        autocmd FileType c nnoremap <buffer> <leader>g :w<CR>:!clear && gcc % -o %<.out  && ./%<.out<CR>
