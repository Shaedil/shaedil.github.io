" Author:        Shaedil D.

" Maintainer:    Shaedil D.

" Website Link:  https://github.com/Shaedil/vim-config

" Description:   My personal .vimrc used for TUI and GUI Vim/NVim

" Last Modified: 04/07/22

" VIM PLUGINS SECTION
" ================
" These following plugins are extremely useful and used on a day to day basis.
call plug#begin('~/.vim/plugged')

" vim-plug is the best way to manage plugins for vim, it uses git's command
" tooling to install, update and remove plugins from within vim itself.
" Pathogen sucks now, use vim-plug instead. Hell, even Bram Moolenar uses
" vim-plug.
Plug 'junegunn/vim-plug'
" vim visual star search is very useful for working with csv files where you
" want to search for multi-line terms in a file. This is something I've caught
" myself mistakenly doing in the past before I had this plugin and it is
" something that is intuitive to me.
Plug 'bronson/vim-visual-star-search'
" vim-commentary is the best way to comment code in vim. You only need to know
" 5 keybinds to effectively use this plugin
Plug 'tpope/vim-commentary'
" vim-textmanip is a plugin I find myself using time and time again. It allows
" you to move or copy lines of text up or down or shifted left or right. Use
" my mappings, becaus they are easier to memorize understand
Plug 't9md/vim-textmanip'
" vim-gutentags. proper tag usage for vim, this plugin takes care of all the
" manual labor of creating and updating tag files in your project directory
" automatically. You will need ctags installed. I got mine from sourceforge.
Plug 'ludovicchabant/vim-gutentags'
" Autopairs is self explanatory, they are useful in order to prevent those
" moments where you are working with javascript or lisp and you forget an
" ending parenthesis.
Plug 'jiangmiao/auto-pairs'
" ALE has a well deserved seat in this config file because it does so many
" useful things while still remaining one of the lighter linters available for
" vim. While I have not yet used its quick fix features, I can say that the
" linting features such as in-line linting errors, and built in parsers for
" linting scripts is well thought of.
Plug 'dense-analysis/ale'
" Vim git integration. It allows you to add, commit and push from within vim.
" Think of it as a wrapper on top of git, you can do most if not all from git
" within vim. The merge tool is easy to use.
Plug 'tpope/vim-fugitive'

" Aesthetics / eye candy
" ================
" Polyglot just has more syntax highlighting rule files for less popular
" syntax and filetypes. It does not slow down vim at all as you may suspect.
Plug 'sheerun/vim-polyglot'
" Highlights yanked text; extremely useful for knowing what and if you copied
" text within vim.
Plug 'machakann/vim-highlightedyank'
" Highlights html color names, hex, rgb, etc; useful for dealing with css
Plug 'RRethy/vim-hexokinase', {'do': 'make hexokinase'}
" Nerdtree is a file explorer/tree, most similar to vscode's file
" explorer/tree. debatably fast and easy to use. Although Netrw does exist by
" default. i.e. do :e . and you'll get the same thing as nerdtree.
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" A better looking statusline for mostly aesthetics but sometimes useful for
" editing. Knowing if you are in insert mode or any other plugin functionality
" will work alongside this plugin to deliver information easily to the user.
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Similar to most heavy-duty IDE startup pages, you can select multiple files
" to open in various configurations. You can create, read, update, delete
" vim sessions and you can open MRUs and bookmarked files. It also looks nice
Plug 'mhinz/vim-startify'
" Self explanatory, useful for journaling or writing down ideas or project
" managment.
Plug 'vimwiki/vimwiki'
" For nvim only plugins
if has("nvim")
    " My favorite colorscheme
    Plug 'glepnir/zephyr-nvim'
    " Treesitter is such a pain to set up, but it gives you AST like
    " syntax highlighting, which goes well with my favorite colorscheme
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif
" Mandatory to be the last plugin to load, this plugin is useful for displaying
" quick information in other various vim plugins and status bars using
" specific characters in a specific formatted font that is compatible with
" vim-devicons.
Plug 'ryanoasis/vim-devicons'
call plug#end()

" Required lua config for nvim-treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
    },
}
EOF

" Default vim settings
" ================
" Loads autocommands in plugins which sources filetype plugins associated to
" current filetype. Required to use plugins.
filetype plugin on
" Allows using :highlight commands to overrule vim default syntax
" highlighting. Required to use non-default colorschemes.
syntax on
" Disables vi compatibility mode because we want vim not vi.
set nocompatible
" Recommended character encoding for vim, reduces encoding conversion overhead
set encoding=utf8
" Show last used command in last line of vim screen
set showcmd
" Splits vim windows below and to the right of the current window.
set splitbelow
set splitright
" Makes vim search for tag files named 'tags'
set tags=tags
" Disables annoying bell sound and replaces it with a visual flashing 
" (only on linux terminals)
set visualbell
" Highlight first 1000 characters in a column per line. Helps with loading
" files.
set synmaxcol=1000
" automatically change directory to file location (kinda annoying
" sometimes, but nice to have when dealing with a project)
set autochdir
" Don't show 'match 1 of 2' or 'The only match' messages
set shortmess+=c
" Sets title of program to: '[filename] [+] (cwd) - NVIM'
set title
" Enables number line and cursorline. To taste
set relativenumber
set number
set cursorline
" Enable full mouse support for copying or selecting text.
set mouse=a
" Correct MacOS backspace key
set backspace=indent,eol,start

" Fold settings. '{{{,}}}' is the default fold marker. Don't render deeply
" nested folds and set fold levels to 0 when working with multiple buffers.
set foldenable
set foldmethod=marker
set foldnestmax=10
set foldlevelstart=0
" Highlight searches and search while typing out the full search
set hlsearch
set incsearch
" Set Paste mode keybind, Paste mode is ful for using vim in a terminal and
" you need to copy text from one window in the terminal to the other.
set pastetoggle=<F2>
" Indentation rules. always keep tabstop = 8 spaces, shift text 4 spaces,
" convert tabs to spaces, minimum tab size = 4 spaces (useful formatting
" when printing files), auto copy indentation when using the "o" or "O"
" command, smarttab deletes a shiftwidth worth of space after a tab inserts
" blanks according to tabstop or softtabstop
set tabstop=8
set shiftwidth=4
set expandtab
set softtabstop=4
set autoindent
set smarttab
" Autocompletion
" ================
" Every directory gets searched when using 'gf' command
set path=.,**
" Enables command line completion
set wildmenu
" enables default code completion, completes based on syntax
set omnifunc=syntaxcomplete#Complete
" shows extra info about currently selected completion in preview window
set completeopt+=preview
" Order the completion suggestions by longest common string and full match.
set wildmode=longest:full
" character to press when starting completion in command line for macros only.
set wildcharm=<C-b>
" ignore these files when showing completion suggestions.
set wildignore=*.swip,*.bak
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user
set wildignore+=*.cache,*.dll,*.pdb,*.min.*
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=tags
set wildignore+=*.tar.*
" Custom Funcs, Cmds and AutoCmds
" ================
" Remove all buffers except current buffer
command! BufOnly silent! execute "%bd|e#|bd#"
" ToggleCursors
" ================
" Press F3 to find your cursor position
nmap <F3> :call ToggleCursors()<CR>
fun! ToggleCursors()
    if &cursorline && &cursorcolumn
        set nocursorcolumn
        set nocursorline
    else
        set cursorcolumn
        set cursorline
    endif
endfun

" Vullscreen
" ================
" Toggle gui options bar at the top of vim window, default is off
nnoremap <F11> :call VullScreen()<cr>
fun! VullScreen()
    if &go=~#'m'
        set go-=m
        set go-=T
        set go-=r
        set go-=R
        set go-=l
        set go-=L
    else
        set go+=m
        set go+=T
        set go+=r
        set go+=R
        set go+=l
        set go+=L
    endif
endfun
" Press F4 to highlight spelling errors in the english language.
nnoremap <F4> :setlocal spell! spelllang=en_us<cr>
" Use K to show documentation in another window/buffer
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Viewing Images
" ================
" Opens common img formats with default image viewer (linux only)
autocmd BufEnter *.png,*.jpg,*gif exec "!xdg-open ".expand("%") | :bw

" Graphical config
" ================

" Font and Colorscheme
" ================
set guifont=DroidSansMono\ NF:h11
" Use more highlighting options present in colorscheme files
" (e.g. guifg, guibg)
set termguicolors
colorscheme zephyr
let g:airline_theme='zenburn'
" Python lines of code should be under 80 characters, this sets a visual
" marker to help you prevent going past this limit.
autocmd FileType python set colorcolumn=80
" Airline Config
" ================

" Aesthetics purposes only, looks like powerline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#ale#checking_symbol = " \uf252 "
let g:airline#extensions#coc#error_symbol = ' ⓧ '
let g:airline#extensions#coc#warning_symbol = ' ⚠️'

" NERDTree config, self explanatory
" ================
let NERDTreeHighlightCursorline = 0

" Ale Config
" ================
" Aesthetics only, symbols appear left of numberline
let g:ale_sign_error = "✘"
let g:ale_sign_warning = ""
let g:ale_lint_on_enter = 1
let g:ale_fix_on_save = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
" If these linters are installed, ale will use them to find errors.
let g:ale_linters = {'python': ['pylint', 'flake8', 'pycodestyle'], 'vimscript': ['vint']}
" These symbols are found in hovered lines or the last line of vim screen
let g:ale_echo_msg_error = 'E'
let g:ale_echo_msg_warning = 'W'
" Seen on hover of line with error
let g:ale_echo_msg_format = '[%linter%] %code%: %s'
" Highlighting symbols for readability
highlight! ALEErrorSign ctermbg=NONE ctermfg=red guibg=NONE guifg=red
highlight! ALEWarningSign ctermbg=NONE ctermfg=yellow guibg=NONE guifg=yellow
highlight! ALEError ctermbg=NONE cterm=underline guifg=red gui=underline
highlight! ALEWarning ctermbg=NONE cterm=underline guifg=yellow gui=underline

" Vimwiki Config
" ================
" Defining where vimwiki should look for wiki files. It is possible to define 
" another wiki path that points to another separate wiki. Look to 
let wiki_1 = {}
let wiki_1.path = '~/vimwiki'
let wiki_1.index = 'index'
let g:vimwiki_list = [{'path': '~/vimwiki',
          \ 'template_path': '~/vimwiki_html/templates',
          \ 'template_default': 'default',
          \ 'template_ext': '.html'}]
" Make vimwiki look clean but having no extraneous information like numberline
" or folds
autocmd BufNewFile, BufRead *.wiki setlocal nonu nornu nofoldenable
" Fold based on wiki syntax
let g:vimwiki_folding = 'syntax'

" Startify Config
" ================
" Self explanatory
let g:startify_bookmarks = [
   \ { 'c': '~/.vimrc' },
   \ ]
let g:startify_commands = [
   \ { 'd': ['Vimwiki', ':VimwikiIndex'] },
   \ ]
let g:startify_lists = [
   \ { 'type': 'files',     'header': ['   MRU']            },
   \ { 'type': 'sessions',  'header': ['   Sessions']       },
   \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
   \ { 'type': 'commands',  'header': ['   Commands']       },
   \ ]
" Uses a bank of programming-related quotes, aesthetics only.
let g:startify_custom_header =
   \ startify#pad(startify#fortune#cowsay('', '═','║','╔','╗','╝','╚'))

" Keybindings
" ================

" Abbreviations
" ================
" Useful for when you mistype and accidentally capitalize the first character.
ca vsf vert sf
ca W w
ca Cd cd
ca Wq wq

" Navigating split windows
" ================
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>
" For the built-in vim terminal, see below
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

" Navigating Tabs
" ================
" Manage tabs easier with these
nnoremap gt :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>
nnoremap tc :tabclose<CR>

" Buffer management
" ================
nnoremap gb :ls<Cr>:b<Space>
map <C-Right> :bnext<CR>
map <C-Left> :bprev<CR>

" NERDTree mapping
" ================
noremap <C-N> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" TEXTMANIP Mappings
" ================
" Reminder: xmap = visual mode mapping and nmap = normal mode mapping.
let g:textmanip_enable_mappings = 1
xmap <Space>d <Plug>(textmanip-duplicate-down)
nmap <Space>d <Plug>(textmanip-duplicate-down)
xmap <Space>D <Plug>(textmanip-duplicate-up)
nmap <Space>D <Plug>(textmanip-duplicate-up)
xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)
" Toggle insert/replace with <F9>
nmap <F9> <Plug>(textmanip-toggle-mode)
xmap <F9> <Plug>(textmanip-toggle-mode)

" Git conflict management
" ================
" Fugitive Conflict Resolution:
" https://medium.com/prodopsio/solving-git-merge-conflicts-with-vim-c8a8617e3633
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" 'Replace all' is aliased to S
nnoremap S :%s//g<Left><Left>

" Vim airline config
" ================
" Disable last line of vim screen from showing '-- insert --'
set noshowmode

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Powerline symbols if using a powerline font
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰ '
let g:airline_symbols.maxlinenr = ''

" cd home always, just for personal preference
cd ~
