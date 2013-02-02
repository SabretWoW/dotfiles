set guifont=Inconsolata-dz\ for\ Powerline:h12

if has('gui_macvim')
  " Please don't beep.
  set visualbell

  set clipboard=unnamed

  set transparency=5
  " Also, axe that toolbar.
  set guioptions-=T
  " Probably a better way to write this; disable scrollbars and selectcopy.
  set guioptions=aAce
  set guioptions-=a
  set guioptions-=A
  set guioptions-=aA

  " Repurposing Command-T for command-t plugin
  macmenu &File.New\ Tab key=<D-T>
  map <D-t> :CommandT<CR>
  imap <D-t> <Esc>:CommandT<CR>
  
  " Bind Cmd-Shift-F to :Ack
  map <D-F> :Ack<space>

  " Bind Cmd-E to ConqueTerm.
  map <D-e> :call StartTerm()<CR>

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

" Load extra scripts, too.
if filereadable(expand('~/.vim/scripts/nerdtree.vim'))
  source ~/.vim/scripts/nerdtree.vim
endif

function StartTerm()
  " This opens up a split on the right with a new terminal session.
  execute 'rightbelow vnew'
  execute 'ConqueTerm ' . $SHELL . ' --login'
  setlocal listchars=tab:\ \
endfunction
