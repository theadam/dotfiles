"if executable('pipenv')
"  let pipenv_py = substitute(system('pipenv --py'), '\n*$', '', '')
"  if filereadable(pipenv_py)
"    let raw_version = system(pipenv_py . ' --version')
"    let py_version = split(split(raw_version, ' ')[1], '\.')[0]
"
"    let bin = substitute(system('pipenv --venv'), '\n*$', '', '') . '/bin'
"    let activate_script = bin . '/activate_this.py'
"    let globals = "dict(__file__='" . activate_script . "')"
"
"    let $PATH = bin . ':' . $PATH
"
"    if py_version == '2'
"      execute("python execfile('" . activate_script . "', " . globals . ')')
"    else
"      execute("python3 exec(open('" . activate_script . "').read(), " . globals . ')')
"    endif
"  endif
"endif
