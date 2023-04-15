local wezterm = require 'wezterm'

local utils = require 'utils'
local colors = require 'colors'
local status = require 'status'
local keys = require 'keys'
local tabs = require 'tabs'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.front_end = 'WebGpu'
config.set_environment_variables = utils.BASE_ENV
config.default_workspace = utils.default_workspace

config.font = wezterm.font('JetBrains Mono', { weight = 'Light'})
config.font_size = 12.0

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.window_padding = {
  bottom = 0
}

colors.apply(config)
status.apply(config)
tabs.apply(tabs)
keys.apply(config)


return config
