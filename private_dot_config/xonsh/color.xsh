def color(theme):
    $THEME=theme
    $[bash -c "source ~/.config/base16-shell/scripts/$THEME.sh"]

aliases['color'] = color
#color('base16-material-palenight')
