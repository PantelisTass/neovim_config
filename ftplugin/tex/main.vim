let maplocalleader = " "

" Use `dsm` to delete surrounding math (replacing the default shortcut `ds$`)
nmap dsm <Plug>(vimtex-env-delete-math)

" Use `<localleader>c` to trigger continuous compilation...
nmap <localleader>cc <Plug>(vimtex-compile)

nmap <localleader>cs :w<CR>:VimtexCompileSS<CR>

" Define a custom shortcut to trigger VimtexView
nmap <localleader>vv <plug>(vimtex-view)

" Define a custom shortcut to trigger VimtexStop
nmap <localleader>vs <plug>(vimtex-stop)

function! s:TexFocusVim() abort
  " Replace `TERMINAL` with the name of your terminal application
  " Example: execute "!open -a iTerm"  
  " Example: execute "!open -a Alacritty"
  silent execute "!open -a Terminal"
  redraw!
endfunction

augroup vimtex_event_focus
  au!
  au User VimtexEventViewReverse call s:TexFocusVim()
augroup END

