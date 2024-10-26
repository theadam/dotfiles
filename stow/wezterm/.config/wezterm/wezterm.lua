local wezterm = require("wezterm")
local utils = require("lib/utils")
local colors = require("lib/colors")
local status = require("lib/status")
local keys = require("lib/keys")
local tabs = require("lib/tabs")

-- This table will hold the configuration.
local config = utils.get_base_config()

config.front_end = "WebGpu"
config.set_environment_variables = utils.BASE_ENV
config.default_workspace = utils.default_workspace

config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Book" })
config.font_size = 12.5

config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.window_padding = {
	bottom = 0,
}

colors.apply(config)
status.apply(config)
tabs.apply(tabs)
keys.apply(config)

return config
