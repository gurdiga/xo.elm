set viminfo+=n.viminfo

let g:elm_format_autosave = 1

" Make the selected text a comment, then wrap lines.
vmap gC gcgpgq

autocmd BufWritePost *.elm :silent !ctags -R src &

source rich-text-editor/.vimrc
