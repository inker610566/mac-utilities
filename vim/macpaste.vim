if !exists('g:macpaste')
    let g:macpaste = 1
    command Paste call g:MacPaste()
endif

func! g:MacPaste()
    let paste = system('pbpaste')[:-1]
    if v:shell_error == 0
        let rega = getreg('a')
        call setreg('a', paste)
        normal "ap
        call setreg('a', rega)
    else
        echoerr 'pbpaste failed'
    endif
endfunc
