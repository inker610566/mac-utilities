if !exists('g:maccopy')
    let g:maccopy = 1
    command -range=% Copy call g:MacCopy(<count>)
endif

function! s:CopyThruExFile(lines)
    " open exeternal file may failed
    let tempfile = tempname()
    call writefile(a:lines, tempfile)
    call system('pbcopy < '.tempfile)
    call delete(tempfile)
endfunc

func! g:MacCopy(number)
    if a:number == -1
        call system('pbcopy < '.expand('%'))
    else
        "y
        "echoerr getpos("'<")[1]
        "x
        "echoerr getpos("'<")[2]
        "join(getline("'<", "'>"), "\n")
        let sx = getpos("'<")[2]
        let sy = getpos("'<")[1]
        let dx = getpos("'>")[2]
        let dy = getpos("'>")[1]
        if dy < sy
            let tmp = sx
            let sx = dx
            let dx = tmp
            let tmp = sy
            let sy = dy
            let dy = tmp
        endif
        
        if sy == dy
            if sx > dx
                let tmp = sx
                let sx = dx
                let dx = tmp
            endif
            let output = [getline(sy)[sx-1:dx-1]]
        else
            let output = [getline(sy)[sx-1:]]
            for i in range(sy+1, dy-1)
                let output = add(output, getline(i))
            endfor
            let output = add(output, getline(sy)[:dx-1])
        endif
        call s:CopyThruExFile(output)
    endif
endfunc
