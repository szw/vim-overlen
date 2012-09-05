" vim-overlen
"
" Highlight overlength lines in insert mode
"
" Maintainer:   Szymon Wrozynski
" Version:      0.0.1
"
" Installation:
" Place in ~/.vim/ or in case of Pathogen:
"
"     cd ~/.vim/bundle
"     git clone https://github.com/szw/vim-overlen.git
"
" License:
" Copyright (c) 2012 Szymon Wrozynski. Distributed under the same terms as Vim itself.
" See :help license
"
" Usage:
" https://github.com/szw/vim-overlen/blob/master/README.md

if exists("g:loaded_overlen") || &cp || v:version < 700
    finish
endif

let g:loaded_overlen = 1

if !exists('g:overlen_line_lengths')
    let g:overlen_line_lengths = [['*', 0]]
end

if !exists('g:overlen_highlight_name')
    let g:overlen_highlight_name = 'Error'
end

augroup Overlen
    au!
    au InsertEnter * call s:highlight_overlength()
    au InsertLeave * call clearmatches()
augroup END

fun s:highlight_overlength()
    for entry in g:overlen_line_lengths
        if entry[1] > 0
            for ft in split(entry[0], ',')
                if ft == &ft || ft == '*'
                    return matchadd(g:overlen_highlight_name, '\%>' . entry[1] . 'v.\+', -1)
                endif
            endfor
        endif
    endfor
endfun
