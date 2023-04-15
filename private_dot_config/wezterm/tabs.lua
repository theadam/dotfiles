local wezterm = require 'wezterm'
local utils = require 'utils'

return {
  apply = function(_)
    wezterm.on('format-tab-title', function(tab_info, tabs, panes, effective_config)
      local tab = wezterm.mux.get_tab(tab_info.tab_id)
      local proc_info = tab:active_pane():get_foreground_process_info()
      if proc_info == nil then
        return ''
      end

      local base_name
      if tab:get_title() ~= '' then
        base_name = tab:get_title()
      elseif #proc_info.argv > 0 and proc_info.argv[1] == 'xonsh' then
        base_name = 'xonsh'
      else
        base_name = proc_info.name
      end

      local prefix
      if tab:window():active_tab():tab_id() == tab:tab_id() then
        prefix = utils.dot('Green')
      else
        prefix = utils.dot('Yellow')
      end

      local base_text =  prefix .. ' ' .. base_name
      local padded_text = base_text
      return utils.cache_title(tab, ' ' .. padded_text .. '  ')
    end)
  end
}
