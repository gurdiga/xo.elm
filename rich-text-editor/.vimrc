set viminfo+=n.viminfo

let g:prettier#config#print_width = 120
let g:prettier#config#single_quote = 'false'
let g:prettier#config#bracket_spacing = 'false'
let g:prettier#config#trailing_comma = 'all'
let g:prettier#config#jsx_bracket_same_line = 'false'

autocmd BufWritePre *.ts,*tsx :PrettierAsync

