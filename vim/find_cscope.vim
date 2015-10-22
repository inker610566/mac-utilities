python << ENDPYTHON
def FindCscope():
    from os import path
    import vim
    curpath, dirpath  = '', vim.eval('expand(\'%:p:h\')')
    while curpath != dirpath:
        curpath = dirpath
        if path.isfile(path.join(curpath, 'cscope.out')):
            vim.command("cs add %s" % path.join(curpath, 'cscope.out'))
            break
        dirpath, _ = path.split(curpath)
ENDPYTHON

if has('cscope')
    python FindCscope()
end
