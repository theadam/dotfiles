local wezterm = require 'wezterm'
local utils = require 'lib/utils'


local function get_right_status(window)
  return utils.dot('Blue') .. ' ' .. wezterm.format({
    { Foreground = { AnsiColor = 'Grey' } },
    { Text = utils.basename(window:mux_window():get_workspace()) .. '  ' }
  })
end

local function get_left_status(window, right_status_width)
  local total_width = window:active_tab():get_size().cols

  local tabs_width = 0
  for _, tab in ipairs(window:mux_window():tabs()) do
    local title = utils.title_from_cache(tab)
    if title ~= nil then
      tabs_width = tabs_width + wezterm.column_width(utils.strip_ansi(title))
    end
  end

  local remaining = total_width - right_status_width - tabs_width

  return string.rep(' ', math.ceil(remaining / 2))
end

return {
  apply = function(_)
    wezterm.on('update-status', function(window, pane)
      local right_status = get_right_status(window)
      window:set_right_status(right_status)
      window:set_left_status(get_left_status(window, wezterm.column_width(utils.strip_ansi(right_status))))
    end)
  end
}

