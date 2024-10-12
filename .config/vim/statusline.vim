" SET UP STATUSLINE "
set laststatus=2      " Always show the statusline at the bottom
set shortmess-=S      " Show ?/?? match count in the searchbar

" Build content of the status line from empty
set statusline=                         " Initialise empty
set statusline+=%#LineNr#               " Set colour
set statusline+=%{g:gitbranchname}      " Git branch (use global variable)
set statusline+=\ %f                    " File name
set statusline+=%=                      " Fill space to push rest right
set statusline+=[%l:%c\ %p%%]           " Line number and column, with percentage

" Functions to retrieve git branch of root directory and show in statusline
let g:gitbranchname = ' '
function! UpdateGitBranch()
  let l:rawbranchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  let g:gitbranchname = strlen(l:rawbranchname) > 0?'['.l:rawbranchname.']':''
endfunction

" To limit resource usage only update git branch when changing buffer
augroup UPDATE_GITBRANCH
  " clear old commands
  autocmd!

  " update git branch
  autocmd BufWritePre * :call UpdateGitBranch()
  autocmd BufReadPost * :call UpdateGitBranch()
  autocmd BufEnter * :call UpdateGitBranch()
augroup END
