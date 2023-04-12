import sys
from sqlglot import parse_one, exp


def csvql(args):
    if len(args) != 1:
        print("Must only be given a single string arg", file=sys.stderr)
        return 1
    i = args[0]
    expr = parse_one(i)

    c = 0

    def new_alias():
        nonlocal c
        alias = f'a{c}'
        c = c + 1
        return alias
    
    file_to_name = []

    for table in expr.find_all(exp.Table):
        file = os.path.expanduser(table.this.this)
        if os.path.isfile(file):
            alias = new_alias()
            file_to_name.append((file, alias))
            table.this.args['this'] = alias

    imports = '\n'.join([f'.import "{k}" {v}' for (k, v) in file_to_name])

    script = f"""
.mode csv
.headers on

{imports}

{expr.sql()}
    """

    echo @(script) | sqlite3

aliases['csvql'] = csvql
    
