function! s:path_separator()
    if has('win16') || has('win32') || has('win64')
        return ';'
    else
        return ':'
    endif
endfunction

let s:source = {
    \ 'name' : 'path',
    \ 'description' : 'path',
    \ 'default_action' : {'cdable' : 'cd'},
    \}

call unite#define_source(s:source)

function! s:source.gather_candidates(args, context)"{{{
    let l:path = eval('$'.get(a:args, 0, 'PATH'))
    let l:separator = get(a:args, 1, s:path_separator())
    return map(split(l:path, l:separator), '{
        \ "word" : v:val,
        \ "source" : "path",
        \ "kind" : "cdable",
        \ "action__directory" : v:val,
        \ }')
endfunction"}}}

function! unite#sources#path#define()"{{{
    return s:source
endfunction"}}}

" vim: foldmethod=marker
