" Filter out some compilation warning messages from QuickFix display
let g:vimtex_quickfix_ignore_filters = [
      \ 'Underfull \\hbox',
      \ 'Overfull \\hbox',
      \ 'LaTeX Warning: .\+ float specifier changed to',
      \ 'LaTeX hooks Warning',
      \ 'Package siunitx Warning: Detected the "physics" package:',
      \ 'Package hyperref Warning: Token not allowed in a PDF string',
      \]
let g:vimtex_view_method = 'skim'
" Set latexmk as the default compiler
let g:vimtex_compiler_method = 'latexmk'

let g:vimtex_view_skim_sync = 1
let g:vimtex_view_skim_activate = 1
let g:vimtex_compiler_latexmk = {
    \ 'continuous' : 1,
    \ 'build_dir' : '',
    \ 'options' : [
    \   '-shell-escape',
    \ 	'-lualatex',
    \   '-pdf',
    \	'-f',
    \   '-bibtex-cond',
    \   '-bibtex',
    \   '-interaction=nonstopmode',
    \   '-synctex=1',
    \ ],
    \}
					
