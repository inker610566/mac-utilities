python << ENDPYTHON
def FindCscope():
    from os import path
    import vim
    curpath, dirpath  = '', vim.eval('expand(\'%:p:h\')')
    while curpath != dirpath:
        curpath = dirpath
        if path.isfile(path.join(curpath, 'cscope.out')):
            print path.join(curpath, 'cscope.out')
            vim.command("call setline('.', '1122')")
            break
        dirpath, _ = path.split(curpath)
ENDPYTHON


autocmd Filetype java set nonu
