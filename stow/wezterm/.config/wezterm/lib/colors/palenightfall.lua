local M = {}

local base = {
  background = '#252837',
  foreground = '#959dcb',

  black = '#292d3e',
  red = '#ff5370',
  green = '#c3e88d',
  yellow = '#ffcb6b',
  blue = '#82aaff',
  purple = '#D49BFD',
  cyan = '#89ddff',
  white = '#a6accd',
}

local brights = {
  black = '#676e95',
  red = '#f07178',
  green = base.green,
  yellow = base.yellow,
  blue = base.blue,
  purple = '#c792ea',
  cyan = base.cyan,
  white = '#ffffff'
}


local scheme = {
  ansi = {
    base.black,
    base.red,
    base.green,
    base.yellow,
    base.blue,
    base.purple,
    base.cyan,
    base.white,
  },
  background = base.background,
  brights = {
    brights.black,
    brights.red,
    brights.green,
    brights.yellow,
    brights.blue,
    brights.purple,
    brights.cyan,
    brights.white,
  },
  cursor_bg = base.foreground,
  cursor_border = base.white,
  cursor_fg = base.black,
  foreground = base.foreground,
}

local active_tab = {
    bg_color = base.background,
    fg_color = brights.white,
    intensity = 'Bold',
}

local inactive_tab = {
    bg_color = base.background,
    fg_color = brights.black,
    intensity = 'Bold',
}

local inactive_tab_hover = {
  bg_color = base.background,
  fg_color = base.white,
  intensity = 'Bold'
}

local new_tab = {
  bg_color = base.background,
  fg_color = base.background,
  intensity = 'Bold'
}

local new_tab_hover = {
  bg_color = base.black,
  fg_color = base.white,
  intensity = 'Bold'
}

function M.colors()
    return {
        foreground = base.foreground,
        background = base.background,
        cursor_bg = base.foreground,
        cursor_border = brights.black,
        cursor_fg = base.black,
        selection_bg = brights.black,
        selection_fg = base.background,

        ansi = {
          base.black,
          base.red,
          base.green,
          base.yellow,
          base.blue,
          base.purple,
          base.cyan,
          base.white,
        },

        brights = {
          brights.black,
          brights.red,
          brights.green,
          brights.yellow,
          brights.blue,
          brights.purple,
          brights.cyan,
          brights.white,
        },

        tab_bar = {
            background = base.background,
            active_tab = active_tab,
            inactive_tab = inactive_tab,
            inactive_tab_hover = inactive_tab_hover,
            new_tab = new_tab,
            new_tab_hover = new_tab_hover,
            inactive_tab_edge = brights.black,
        },
    }
end

function M.window_frame() -- (Fancy tab bar only)
    return {
        active_titlebar_bg = base.background,
        inactive_titlebar_bg = base.background,
    }
end

return M
