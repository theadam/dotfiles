local color_scheme = require 'color_scheme'

return {
  apply = function(config)
    config.color_schemes = {}
    config.color_schemes[color_scheme.name] = color_scheme.scheme
    config.color_scheme = color_scheme.name

    config.window_frame = {
      active_titlebar_bg = color_scheme.scheme.background,
      inactive_titlebar_bg = color_scheme.scheme.background,
    }

    config.command_palette_bg_color = color_scheme.scheme.cursor_fg
    config.command_palette_fg_color = color_scheme.scheme.foreground

    config.colors = {
      background = color_scheme.scheme.background,
      tab_bar = {
        inactive_tab_edge = color_scheme.scheme.background,
        background = color_scheme.scheme.background,
        active_tab = {
          bg_color = color_scheme.scheme.background,
          fg_color = color_scheme.scheme.brights[8],
          intensity = 'Bold'
        },

        inactive_tab = {
          bg_color = color_scheme.scheme.background,
          fg_color = color_scheme.scheme.brights[1],
          intensity = 'Bold'
        },

        inactive_tab_hover = {
          bg_color = color_scheme.scheme.background,
          fg_color = color_scheme.scheme.brights[1],
          intensity = 'Bold'
        },

        new_tab = {
          bg_color = color_scheme.scheme.background,
          fg_color = color_scheme.scheme.background,
          intensity = 'Bold'
        },

        new_tab_hover = {
          bg_color = color_scheme.scheme.ansi[1],
          fg_color = color_scheme.scheme.brights[8],
          intensity = 'Bold'
        },
      }
    }
  end
}
