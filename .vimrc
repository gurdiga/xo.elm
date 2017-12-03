set viminfo+=n.viminfo

let g:elm_format_autosave = 1

" Make the selected text a comment, then wrap lines.
vmap gC gcgpgq

autocmd BufWritePost *.elm silent !rm tags; ctags -R src &
autocmd BufEnter *.elm syntax keyword elmTodo TODO LATER contained


source rich-text-editor/.vimrc
