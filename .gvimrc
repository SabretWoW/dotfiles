set guifont=Inconsolata\ for\ Powerline:h14

if has('gui_macvim')
  " Please don't beep.
  set visualbell

  set clipboard=unnamed
  set lsp=2

  set transparency=5
  " Also, axe that toolbar.
  set guioptions-=T
  " Probably a better way to write this; disable scrollbars and selectcopy.
  set guioptions=aAce
  set guioptions-=a
  set guioptions-=A
  set guioptions-=aA

  " Bind Cmd-Shift-F to :Ack
  map <D-F> :Ack<space>

  " Bind Cmd-][ to indent
  vmap <D-]> >gv
  vmap <D-[> <gv

  " Bind Cmd-Opt-arrow to select view ports
  map <D-M-Up> <C-w>k
  imap <D-M-Up> <Esc> <C-w>k
  map <D-M-Down> <C-w>j
  imap <D-M-Down> <Esc> <C-w>j
  map <D-M-Right> <C-w>l
  imap <D-M-Right> <Esc> <C-w>l
  map <D-M-Left> <C-w>h
  imap <D-M-Left> <C-w>h

  " Adjust viewports to be the same size.
  map <Leader>= <C-w>=
  imap <Leader>= <Esc> <C-w>=
endif

