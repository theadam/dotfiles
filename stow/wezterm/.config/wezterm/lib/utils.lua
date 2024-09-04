local wezterm = require("wezterm")
local os = require("os")

local default_workspace = "home"

local PATH = "/usr/local/opt/grep/libexec/gnubin:"
	.. os.getenv("PATH")
	.. ":"
	.. table.concat({
		wezterm.home_dir .. "/.goenv/bin",
		"./node_modules/.bin",
		wezterm.home_dir .. "/.local/bin",
		"/usr/local/bin",
		wezterm.home_dir .. "/.config/emacs/bin",
		wezterm.home_dir .. "/.cargo/bin",
	}, ":")

return {
	workspace_projects = {
		"kanaha",
		"hookipa",
		"clifton",
		"data-producer",
		"netsuite-producers",
		"workday-producers",
		"sotavento",
	},

	get_base_config = function()
		if wezterm.config_builder then
			return wezterm.config_builder()
		else
			return {}
		end
	end,
	get_directory = function(window)
		return window:mux_window():active_pane():get_current_working_dir().file_path
	end,

	basename = function(directory)
		return string.gsub(directory, ".*/", "")
	end,

	cache_title = function(tab, title)
		wezterm.GLOBAL.tab_titles = (wezterm.GLOBAL.tab_titles or {})
		wezterm.GLOBAL.tab_titles[tostring(tab:tab_id())] = title
		return title
	end,

	title_from_cache = function(tab)
		return (wezterm.GLOBAL.tab_titles or {})[tostring(tab:tab_id())]
	end,

	dot = function(color)
		return wezterm.format({
			{ Foreground = { AnsiColor = color } },
			{ Attribute = { Intensity = "Bold" } },
			{ Text = "•" },
		})
	end,

	strip_ansi = function(str)
		return str:gsub("[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "")
	end,

	workspace_dir = function()
		local ws = wezterm.mux.get_active_workspace()
		if ws == default_workspace then
			return wezterm.home_dir
		else
			return ws
		end
	end,

	default_workspace = default_workspace,

	PATH = PATH,
	BASE_ENV = {
		PATH = PATH,
	},
}
