local wezterm = require("wezterm")
local io = require("io")
local os = require("os")

local default_workspace = "home"

return {
	workspace_base = wezterm.home_dir .. "/Documents/workspace",

	workspace_projects = {
		"kanaha",
		"hookipa",
		"clifton",
		"data-producer",
		"netsuite-producers",
		"workday-producers",
		"sotavento",
		"snaplogic",
		"netsuite-mcp",
	},

	-- Returns list of {name, path} for worktree entries (master first), or nil if not a worktree root
	get_worktree_entries = function(project_path)
		local f = io.open(project_path .. "/.worktree-root", "r")
		if not f then
			return nil
		end
		f:close()

		local all = wezterm.glob(project_path .. "/*")
		local master = nil
		local others = {}

		for _, path in ipairs(all) do
			local name = path:match("([^/]+)$")
			if name == "master" then
				master = { name = name, path = path }
			elseif name then
				others[#others + 1] = { name = name, path = path }
			end
		end

		table.sort(others, function(a, b)
			return a.name < b.name
		end)

		local result = {}
		if master then
			result[#result + 1] = master
		end
		for _, e in ipairs(others) do
			result[#result + 1] = e
		end

		return result
	end,

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
}
