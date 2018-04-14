set viminfo+=n.viminfo

" Make the selected text a comment, then wrap lines.
vmap gC gcgpgq

autocmd BufWritePost *.elm silent !rm tags; ctags -R src &
autocmd BufEnter *.elm syntax keyword elmTodo TODO LATER contained

source rich-text-editor/.vimrc

let g:ale_linters = {
\   'elm': [],
\}
