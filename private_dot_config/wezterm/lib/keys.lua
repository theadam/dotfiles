local wezterm = require 'wezterm'
local io = require 'io';

local utils = require 'lib/utils';

return {
  apply = function(config)
    config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000}

    config.keys = {
      -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
      {
        key = 'a',
        mods = 'LEADER|CTRL',
        action = wezterm.action.SendString '\x01',
      },
      {
        key = 'x',
        mods = 'LEADER',
        action = wezterm.action.CloseCurrentPane { confirm = true },
      },
      {
        key = '[',
        mods = 'LEADER',
        action = wezterm.action.ActivateCopyMode,
      },
      {
        key = '{',
        mods = 'LEADER|SHIFT',
        action = wezterm.action_callback(function(window, pane)
          -- Retrieve the current viewport's text.
          -- Pass an optional number of lines (eg: 2000) to retrieve
          -- that number of lines starting from the bottom of the viewport
          local scrollback = pane:get_logical_lines_as_text(window:effective_config().scrollback_lines);

          -- Create a temporary file to pass to vim
          local name = os.tmpname();
          local f = io.open(name, "w+");
          f:write(scrollback);
          f:flush();
          f:close();

          local tab_index
          for _, tab_info in ipairs(window:mux_window():tabs_with_info()) do
            if tab_info.is_active then
              tab_index = tab_info.index
            end
          end

          -- Open a new window running vim and tell it to open the file
          window:perform_action(wezterm.action{SpawnCommandInNewTab={
            args={'lvim', '+:read ' .. name .. ' | setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile | $,$d | $'},
            set_environment_variables = utils.BASE_ENV.set_environment_variables
          }}, pane)

          window:perform_action(wezterm.action.MoveTab(tab_index), pane)

          -- wait "enough" time for vim to read the file before we remove it.
          -- The window creation and process spawn are asynchronous
          -- wrt. running this script and are not awaitable, so we just pick
          -- a number.
          wezterm.sleep_ms(1000);
          os.remove(name);
        end),
      },
      {
        key = '|',
        mods = 'LEADER|SHIFT',
        action = wezterm.action_callback(function(window, pane)
          window:perform_action(
            wezterm.action.SplitHorizontal { cwd = utils.workspace_dir() },
            pane
          )
        end)
      },
      {
        key = '-',
        mods = 'LEADER',
        action = wezterm.action_callback(function(window, pane)
          window:perform_action(
            wezterm.action.SplitVertical { cwd = utils.workspace_dir() },
            pane
          )
        end)
      },
      {
        key = 'h',
        mods = 'LEADER',
        action = wezterm.action.ActivatePaneDirection 'Left',
      },
      {
        key = 'l',
        mods = 'LEADER',
        action = wezterm.action.ActivatePaneDirection 'Right',
      },
      {
        key = 'j',
        mods = 'LEADER',
        action = wezterm.action.ActivatePaneDirection 'Down',
      },
      {
        key = 'k',
        mods = 'LEADER',
        action = wezterm.action.ActivatePaneDirection 'Up',
      },
      {
        key = 'c',
        mods = 'LEADER',
        action = wezterm.action_callback(function(window, pane)
          window:perform_action(
            wezterm.action.SpawnCommandInNewTab { cwd = utils.workspace_dir() },
            pane
          )
        end)
      },
      {
        key = 'n',
        mods = 'LEADER',
        action = wezterm.action.ActivateTabRelative(1)
      },
      {
        key = 'p',
        mods = 'LEADER',
        action = wezterm.action.ActivateTabRelative(-1)
      },
      {
        key = 's',
        mods = 'LEADER',
        action = wezterm.action_callback(function(window, pane)
          local names = wezterm.mux.get_workspace_names()

          table.sort(
            names,
            function(a, b)
              if a == wezterm.mux.get_active_workspace() then
                return true
              elseif b == wezterm.mux.get_active_workspace() then
                return false
              elseif a == config.default_workspace then
                return true
              elseif b == config.default_workspace then
                return false
              else
                return a < b
              end
            end
          )

          local choices = { }
          for _, name in ipairs(names) do
            local label
            if name == config.default_workspace then
              label = name
            else
              label = utils.basename(name) .. ' (' .. name .. ')'
            end
            choices[#choices + 1] = { label = label, id = name }
          end

          window:perform_action(
            wezterm.action.InputSelector {
              title = 'Select a Workspace',
              action = wezterm.action_callback(function(_, _, id, _)
                if id then
                  window:perform_action(
                    wezterm.action.SwitchToWorkspace {
                      name = id
                    },
                    pane
                  )
                end
              end),
              choices = choices,
            },
            pane
          )
        end),
      },
      {
        key = ' ',
        mods = 'LEADER',
        action = wezterm.action_callback(function(window, pane)

          local names = utils.workspace_projects

          local choices = { }
          for _, name in ipairs(names) do
            choices[#choices + 1] = { label = name, id = wezterm.home_dir .. '/Documents/workspace/' .. name }
          end

          window:perform_action(
            wezterm.action.InputSelector {
              title = 'Select a Workspace',
              action = wezterm.action_callback(function(_, _, id, _)
                if id then
                  window:perform_action(
                    wezterm.action.SwitchToWorkspace {
                      name = id,
                      spawn = {
                        cwd = id,
                      }
                    },
                    pane
                  )
                end
              end),
              choices = choices,
            },
            pane
          )
        end),
      },
      {
        key = '.',
        mods = 'LEADER',
        action = wezterm.action_callback(function (window, pane)
          local directory = utils.get_directory(window)

          local workspace_name = directory
          if directory == wezterm.home_dir then
            workspace_name = 'home'
          end

          window:perform_action(
            wezterm.action.SwitchToWorkspace {
              name = workspace_name,
            },
            pane
          )
        end)
      },
      {
        key = 'Enter',
        mods = 'LEADER',
        action = wezterm.action.SwitchToWorkspace {
          name = config.default_workspace
        }
      },
      {
        key = 'd',
        mods = 'LEADER',
        action = wezterm.action.SwitchToWorkspace {
          name = config.default_workspace
        }
      },
      {
        key = 'p',
        mods = 'CMD',
        action = wezterm.action.ActivateCommandPalette
      },
    }

    for i = 0, 9 do
      table.insert(config.keys, {
        key = tostring(i),
        mods = 'LEADER',
        action = wezterm.action.ActivateTab(i),
      })
    end

  end
}
