set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9 }
"
" " Track the engine.
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Initialize vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" List of plugins to be installed
Plug 'tpope/vim-sensible'
Plug 'lervag/vimtex'
Plug 'karb94/neoscroll.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/nvim-cmp'        " Completion plugin
Plug 'hrsh7th/cmp-buffer'      " Buffer completions
Plug 'hrsh7th/cmp-path'        " Path completions
Plug 'hrsh7th/cmp-cmdline'     " Command-line completions
Plug 'hrsh7th/cmp-nvim-lsp'    " LSP completions
Plug 'hrsh7th/cmp-nvim-lua'    " Lua completions for nvim config
Plug 'saadparwaiz1/cmp_luasnip' " Snippet completions
Plug 'L3MON4D3/LuaSnip'        " Snippet engine
Plug 'onsails/lspkind-nvim'    " VSCode-like pictograms for completion items

" nvim-cmp and related plugins
Plug 'quangnguyen30192/cmp-nvim-ultisnips'  " UltiSnips integration for nvim-cmp
Plug 'SirVer/ultisnips'  " Snippet engine

" Add the color scheme plugin
Plug 'morhetz/gruvbox'

" Add the OneDark color scheme plugin
Plug 'joshdick/onedark.vim'

" Add the Catppuccin color scheme plugin
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

Plug 'dracula/vim', { 'as': 'dracula' }

" End vim-plug section
call plug#end()

" Set the Catppuccin color scheme
	 colorscheme dracula


	" Optional: Customize background and other settings
	set background=dark " or "light" for light mode


	filetype plugin indent on

	" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
	" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
" This code should go in your vimrc or init.vim
let g:UltiSnipsExpandTrigger       = '<tab>'    " use Tab to expand snippets
let g:UltiSnipsJumpForwardTrigger  = '<s-j>'    " use Tab to move forward through tabstops
let g:UltiSnipsJumpBackwardTrigger = '<s-k>'  " use Shift-Tab to move backward through tabstops
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']  " using Neovim


" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Python directory
let g:python3_host_prog = '/Users/pantelistassopoulos/opt/anaconda3/bin/python3'

"Set leader key
let mapleader = " "

" Use <leader>u in normal mode to refresh UltiSnips snippets
nnoremap <leader>u <Cmd>call UltiSnips#RefreshSnippets()<CR>

" Use <leader>bn in normal mode to move to next buffer
nnoremap <leader>bn <CR>:bnext<CR>

" Use <leader>bp in normal mode to move to previous uffer
nnoremap <leader>bp <CR>:bprevious<CR>

nnoremap <s-s> <CR>:w<CR>

lua require('init')
