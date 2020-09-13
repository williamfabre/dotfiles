" vim:ts=4:sw=4:ai:foldmethod=marker:foldlevel=0:
""Plugin {{{
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'arcticicestudio/nord-vim'
Plugin 'ap/vim-css-color'
Plugin 'tpope/vim-surround'
Plugin 'w0rp/ale'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
call vundle#end()

filetype plugin indent on
""}}}

"""Colors {{{
    syntax enable
    colorscheme nord
    "" hi Normal guibg=black ctermbg=black
    set t_ut=                           "" Disable Background Color Erase so that Vim redraws the bg
"""}}}

"""Misc {{{
    let mapleader=","
    set backspace=indent,eol,start
"""}}}

"""Spaces & Tabs {{{
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set expandtab

"""}}}

"""UI Layout {{{
    set number                          " Show line numbering
    set showcmd                         " Show the last command in the very bottom right
    set cursorline                      " Highlight the current line

    set wildmenu                        " Enables autocomplete menu (like zsh's when tapping <TAB> after an incomplete filename)
    set lazyredraw                      " Only redraw what needs to be
    set showmatch                       " highlights matching bracket
"""}}}

"""Searching {{{
    set incsearch                       " Search as characters are entered
    set hlsearch                        " Highlights matches
    " Stops highlighting search results once you type <space>
    nnoremap <leader><space> :nohlsearch<CR>
"""}}}

"""Folding {{{
    set foldenable                      " Enables folding
    set foldlevelstart=10               " Open folds less than 10-fold deep
    set foldnestmax=10                  " Gives up on the folding mechanism after 10 levels deep folds (i.e. JavaScript hell)
    " Binds *vanilla* space to open/closes folds
    nnoremap <space> za
    set foldmethod=indent               " Folds based on the indentation level (i.e. Python)
"""}}}

"""Templates {{{
if has("autocmd")
    function LoadSkeleton(extension, line)
        let skel = '~/.vim/templates/skeleton.'.a:extension
        execute '0r '.skel
        execute 'silent ! chmod +x '.skel
        execute a:line
    endfunction

    augroup templates
        autocmd BufNewFile *.sh call LoadSkeleton("sh", "2")
        autocmd BufNewFile *.py call LoadSkeleton("py", "10")
    augroup END
endif
"""}}}

"""Shortcuts {{{
" Autoclosing
" PS: This is really frustrating in practice, use a real plugin ffs
" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O

" Hardmode wannabe
" Normal mode remaps
nnoremap <Up> :echo "No up for you!"<CR>
nnoremap <Left> :echo "No left for you!"<CR>
nnoremap <Down> :echo "No down for you!"<CR>
nnoremap <Right> :echo "No right for you!"<CR>

" Visual mode remaps
vnoremap <Up> :echo "No up for you!"<CR>
vnoremap <Left> :echo "No left for you!"<CR>
vnoremap <Down> :echo "No down for you!"<CR>
vnoremap <Right> :echo "No right for you!"<CR>

" Insert mode remaps
""inoremap <Up>   <nop>
""inoremap <Left> <nop>
""inoremap <Down> <nop>
""inoremap <Right> <nop>

vmap ,g :s/<C-R>//
map ,g :s/<C-R>//

" Runs the current script 
nnoremap <leader>f :w\|:set autoread\|:!chmod +x %:p<CR>\|:!%:p<CR>
" Adds a newline after/before the current line WITHOUT LEAVING NORMAL MODE
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>

" Go to end of line vithout including the newline
vnoremap 4 $h

" Prevent copying when pasting over selection
" vnoremap p "_dp

""" }}}

""" Plugin Config {{{

let g:ale_lint_on_text_changed = "always"

"" INFO ABOUT JEDI AND NUMPY:
"" 1) You can set precise version numbers below (like 3.8.3)
"" 2) By default, jedi will use the env's python3 version, i.e. pyenv or brew
"" 3) To make jedi work with numpy, you have to install numpy AND numpydoc in
""    in the interpreter that jedi is using.
"" 4) To do that, find what python3 version jedi is using, then run
""    python3 -c "import site; print(site.getsitepackages()[0])" to get the
""    site package location AND ADD IT TO THE $PYTHONPATH global variable
"" 5) Then, check that pip3 list and ls path/to/sitepackage checks out and if
""    so, run pip3 install numpy numpydoc
"" 6) To make sure it now works, run the following:
""    import jedi; print(jedi.Script('import numpy; a = numpy.array([0]); a.').complete())
""    If you get an empty array, it doesn't work. If you get a bunch of stuff,
""    it works !
""
""    TL;DR: Make sure that Jedi's Python interpreter has numpydoc installed
""    Tips: If jedi uses homebrew python, but you use pyenv to manage
""          versions, symlink brew python to pyenv like such:
""          ln -s $(brew --cellar python@3.8)/* ~/.pyenv/versions/
""          Replace python@3.8 by the Python version that Vim was compiled with 

let g:jedi#use_python=3
let g:jedi#force_py_version=3
let g:jedi#popup_select_first = 0       " Prevent Jedi from selecting the 1st recommendation
let g:jedi#documentation_command = "<C-j>"
autocmd FileType python setlocal completeopt-=preview " Disable docstring window 

""" }}}
