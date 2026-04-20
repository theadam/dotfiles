local wezterm = require("wezterm")
local io = require("io")

local utils = require("lib/utils")

return {
	apply = function(config)
		config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

		config.keys = {
			-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
			{
				key = "a",
				mods = "LEADER|CTRL",
				action = wezterm.action.SendString("\x01"),
			},
			{
				key = "x",
				mods = "LEADER",
				action = wezterm.action.CloseCurrentPane({ confirm = true }),
			},
			{
				key = "[",
				mods = "LEADER",
				action = wezterm.action.ActivateCopyMode,
			},
			{
				key = "{",
				mods = "LEADER|SHIFT",
				action = wezterm.action_callback(function(window, pane)
					-- Retrieve the current viewport's text.
					-- Pass an optional number of lines (eg: 2000) to retrieve
					-- that number of lines starting from the bottom of the viewport
					local scrollback = pane:get_logical_lines_as_text(window:effective_config().scrollback_lines)

					-- Create a temporary file to pass to vim
					local name = os.tmpname()
					wezterm.log_info(name)
					local f = io.open(name, "w+")
					f:write(scrollback)
					f:flush()
					f:close()

					local tab_index
					for _, tab_info in ipairs(window:mux_window():tabs_with_info()) do
						if tab_info.is_active then
							tab_index = tab_info.index
						end
					end

					-- Open a new window running vim and tell it to open the file
					window:perform_action(
						wezterm.action({
							SpawnCommandInNewTab = {
								args = {
									"/usr/local/bin/nvim",
									name,
									"+:enew | read"
										.. name
										.. " | setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile | $,$d | $",
								},
								set_environment_variables = utils.BASE_ENV.set_environment_variables,
							},
						}),
						pane
					)

					window:perform_action(wezterm.action.MoveTab(tab_index), pane)

					-- wait "enough" time for vim to read the file before we remove it.
					-- The window creation and process spawn are asynchronous
					-- wrt. running this script and are not awaitable, so we just pick
					-- a number.
					wezterm.sleep_ms(1000)
					os.remove(name)
				end),
			},
			{
				key = "|",
				mods = "LEADER|SHIFT",
				action = wezterm.action_callback(function(window, pane)
					window:perform_action(wezterm.action.SplitHorizontal({ cwd = utils.workspace_dir() }), pane)
				end),
			},
			{
				key = "-",
				mods = "LEADER",
				action = wezterm.action_callback(function(window, pane)
					window:perform_action(wezterm.action.SplitVertical({ cwd = utils.workspace_dir() }), pane)
				end),
			},
			{
				key = "h",
				mods = "LEADER",
				action = wezterm.action.ActivatePaneDirection("Left"),
			},
			{
				key = "l",
				mods = "LEADER",
				action = wezterm.action.ActivatePaneDirection("Right"),
			},
			{
				key = "j",
				mods = "LEADER",
				action = wezterm.action.ActivatePaneDirection("Down"),
			},
			{
				key = "k",
				mods = "LEADER",
				action = wezterm.action.ActivatePaneDirection("Up"),
			},
			{
				key = "c",
				mods = "LEADER",
				action = wezterm.action_callback(function(window, pane)
					window:perform_action(wezterm.action.SpawnCommandInNewTab({ cwd = utils.workspace_dir() }), pane)
				end),
			},
			{
				key = "n",
				mods = "LEADER",
				action = wezterm.action.ActivateTabRelative(1),
			},
			{
				key = "p",
				mods = "LEADER",
				action = wezterm.action.ActivateTabRelative(-1),
			},
			{
				key = "s",
				mods = "LEADER",
				action = wezterm.action_callback(function(window, pane)
					local names = wezterm.mux.get_workspace_names()
					local active = wezterm.mux.get_active_workspace()

					-- Separate default workspace from the rest
					local workspaces = {}
					local has_default = false
					for _, name in ipairs(names) do
						if name == config.default_workspace then
							has_default = true
						else
							workspaces[#workspaces + 1] = name
						end
					end

					-- Detect worktree groups: check if any workspace is under a worktree-root dir
					local worktree_roots = {} -- container_path -> true
					local worktree_master = {} -- container_path -> master_path
					for _, name in ipairs(workspaces) do
						local parent = name:match("^(.+)/[^/]+$")
						if parent and not worktree_roots[parent] then
							local f = io.open(parent .. "/.worktree-root", "r")
							if f then
								f:close()
								worktree_roots[parent] = true
								worktree_master[parent] = parent .. "/master"
							end
						end
					end

					-- For each worktree root, add container and scan for all children
					for root_path, _ in pairs(worktree_roots) do
						local has_root = false
						for _, name in ipairs(workspaces) do
							if name == root_path then
								has_root = true
								break
							end
						end
						if not has_root then
							workspaces[#workspaces + 1] = root_path
						end

						local entries = utils.get_worktree_entries(root_path)
						if entries then
							for _, entry in ipairs(entries) do
								local found = false
								for _, name in ipairs(workspaces) do
									if name == entry.path then
										found = true
										break
									end
								end
								if not found then
									workspaces[#workspaces + 1] = entry.path
								end
							end
						end
					end

					table.sort(workspaces)

					-- Build parent-child relationships (worktrees are subdirectories)
					local children_of = {}
					local is_child = {}

					for _, name in ipairs(workspaces) do
						for _, parent in ipairs(workspaces) do
							if name ~= parent and string.sub(name, 1, #parent + 1) == parent .. "/" then
								-- Ensure this is the most direct parent (no closer intermediate)
								local has_closer_parent = false
								for _, other in ipairs(workspaces) do
									if other ~= name and other ~= parent
										and string.sub(other, 1, #parent + 1) == parent .. "/"
										and string.sub(name, 1, #other + 1) == other .. "/"
									then
										has_closer_parent = true
										break
									end
								end
								if not has_closer_parent then
									children_of[parent] = children_of[parent] or {}
									table.insert(children_of[parent], name)
									is_child[name] = true
								end
							end
						end
					end

					-- For worktree roots, remove master from children (parent entry represents master)
					for root_path, _ in pairs(worktree_roots) do
						local kids = children_of[root_path]
						if kids then
							local filtered = {}
							for _, child in ipairs(kids) do
								if child ~= worktree_master[root_path] then
									filtered[#filtered + 1] = child
								end
							end
							children_of[root_path] = #filtered > 0 and filtered or nil
						end
						-- Master is hidden as a child; mark so it doesn't appear top-level
						is_child[worktree_master[root_path]] = true
					end

					-- Collect top-level workspaces (not a child of anything)
					local top_level = {}
					for _, name in ipairs(workspaces) do
						if not is_child[name] then
							top_level[#top_level + 1] = name
						end
					end

					-- Find the root parent of the active workspace
					local active_root = active
					for _, name in ipairs(top_level) do
						if active == name or string.sub(active, 1, #name + 1) == name .. "/" then
							active_root = name
							break
						end
					end

					-- Sort: active's root first, then by most recently selected, then alphabetical
					local timestamps = wezterm.GLOBAL.workspace_timestamps or {}
					table.sort(top_level, function(a, b)
						if a == active_root then return true
						elseif b == active_root then return false
						else
							local ta = timestamps[a] or 0
							local tb = timestamps[b] or 0
							if ta ~= tb then return ta > tb end
							return a < b
						end
					end)

					-- Build choices with tree hierarchy
					local choices = {}

					local function add_children(parent_name, prefix, root_tag)
						local kids = children_of[parent_name]
						if not kids then return end
						for i, child in ipairs(kids) do
							local is_last = (i == #kids)
							local connector = is_last and "└── " or "├── "
							local next_prefix = prefix .. (is_last and "    " or "│   ")
							local label = prefix .. connector .. utils.basename(child)
							if root_tag then
								label = label .. "  [" .. root_tag .. "]"
							end
							if child == active then
								label = label .. " ●"
							end
							choices[#choices + 1] = { label = label, id = child }
							add_children(child, next_prefix, root_tag)
						end
					end

					local function add_top_level_entry(name)
						if name == config.default_workspace then
							local label = config.default_workspace
							if active == config.default_workspace then
								label = "● " .. label
							end
							choices[#choices + 1] = { label = label, id = config.default_workspace }
						elseif worktree_roots[name] then
							local root_base = utils.basename(name)
							local label = root_base
							if worktree_master[name] == active then
								label = "● " .. label
							end
							choices[#choices + 1] = { label = label, id = name }
							add_children(name, "  ", root_base)
						else
							local label = utils.basename(name) .. " (" .. name .. ")"
							if name == active then
								label = "● " .. label
							end
							choices[#choices + 1] = { label = label, id = name }
							add_children(name, "  ")
						end
					end

					-- Add active's root group first
					for _, name in ipairs(top_level) do
						if name == active_root then
							add_top_level_entry(name)
							break
						end
					end

					-- Sort default workspace into the MRU list
					local rest = {}
					if has_default then
						rest[#rest + 1] = config.default_workspace
					end
					for _, name in ipairs(top_level) do
						if name ~= active_root then
							rest[#rest + 1] = name
						end
					end
					table.sort(rest, function(a, b)
						local ta = timestamps[a] or 0
						local tb = timestamps[b] or 0
						if ta ~= tb then return ta > tb end
						return a < b
					end)

					for _, name in ipairs(rest) do
						add_top_level_entry(name)
					end

					window:perform_action(
						wezterm.action.InputSelector({
							title = "Select a Workspace",
							action = wezterm.action_callback(function(_, _, id, _)
								if id then
									wezterm.GLOBAL.workspace_timestamps = wezterm.GLOBAL.workspace_timestamps or {}
									-- Timestamp the root parent so worktree selection bubbles up the group
									local ts_key = id
									for _, tl in ipairs(top_level) do
										if id == tl or string.sub(id, 1, #tl + 1) == tl .. "/" then
											ts_key = tl
											break
										end
									end
									wezterm.GLOBAL.workspace_timestamps[ts_key] = os.time()

									-- If a worktree root container is selected, go to master
									local actual_id = worktree_master[id] or id

									window:perform_action(
										wezterm.action.SwitchToWorkspace({
											name = actual_id,
											spawn = { cwd = actual_id },
										}),
										pane
									)
								end
							end),
							choices = choices,
							fuzzy = true,
							fuzzy_description = "Select a Workspace: ",
						}),
						pane
					)
				end),
			},
			{
				key = "w",
				mods = "LEADER",
				action = wezterm.action_callback(function(window, pane)
					local cwd = pane:get_current_working_dir().file_path

					-- Walk up to find the worktree root container (.worktree-root marker)
					local worktree_root = nil
					local check = cwd
					while check and check ~= "/" and check ~= "" do
						local parent = check:match("^(.+)/[^/]+$")
						if parent then
							local f = io.open(parent .. "/.worktree-root", "r")
							if f then
								f:close()
								worktree_root = parent
								break
							end
						end
						check = parent
					end

					if not worktree_root then
						window:toast_notification("wezterm", "Not in a worktree-managed project", nil, 4000)
						return
					end

					-- Git fetch to get latest refs
					wezterm.run_child_process({ "git", "-C", cwd, "fetch" })

					-- Prompt for worktree name
					window:perform_action(
						wezterm.action.PromptInputLine({
							description = "New worktree name: ",
							action = wezterm.action_callback(function(inner_window, inner_pane, line)
								if not line or line == "" then
									return
								end

								-- Sanitize for directory name (strip special chars)
								local dir_name = line
									:gsub("%s+", "-")
									:gsub("[/\\:*?\"<>|#]+", "-")
									:gsub("%-+", "-")
									:gsub("^%-", "")
									:gsub("%-$", "")

								if dir_name == "" then
									return
								end

								-- Use original input as branch name (trim whitespace)
								local branch_name = line:match("^%s*(.-)%s*$")
								local worktree_path = worktree_root .. "/" .. dir_name

								-- Create git worktree with original name as branch
								local success, _, stderr = wezterm.run_child_process({
									"git",
									"-C",
									cwd,
									"worktree",
									"add",
									"-b",
									branch_name,
									worktree_path,
								})

								if not success then
									inner_window:toast_notification(
										"wezterm",
										"Failed to create worktree: " .. (stderr or "unknown error"),
										nil,
										4000
									)
									return
								end

								-- Switch to new workspace
								inner_window:perform_action(
									wezterm.action.SwitchToWorkspace({
										name = worktree_path,
										spawn = { cwd = worktree_path },
									}),
									inner_pane
								)
							end),
						}),
						pane
					)
				end),
			},
			{
				key = "W",
				mods = "LEADER|SHIFT",
				action = wezterm.action_callback(function(window, pane)
					local cwd = pane:get_current_working_dir().file_path

					-- Walk up to find the worktree root container
					local worktree_root = nil
					local check = cwd
					while check and check ~= "/" and check ~= "" do
						local parent = check:match("^(.+)/[^/]+$")
						if parent then
							local f = io.open(parent .. "/.worktree-root", "r")
							if f then
								f:close()
								worktree_root = parent
								break
							end
						end
						check = parent
					end

					if not worktree_root then
						window:toast_notification("wezterm", "Not in a worktree-managed project", nil, 4000)
						return
					end

					-- Find which worktree subdir we're in
					local after_root = cwd:sub(#worktree_root + 2)
					local worktree_name = after_root:match("^([^/]+)")

					if not worktree_name or worktree_name == "master" then
						window:toast_notification("wezterm", "Cannot destroy the master worktree", nil, 4000)
						return
					end

					local worktree_path = worktree_root .. "/" .. worktree_name
					local master_path = worktree_root .. "/master"

					-- Check for uncommitted changes or untracked files
					local _, status_out = wezterm.run_child_process({
						"git", "-C", worktree_path, "status", "--porcelain",
					})
					local is_dirty = status_out and status_out:match("%S") ~= nil

					local confirm_msg = "Remove worktree '" .. worktree_name .. "'?"
					if is_dirty then
						confirm_msg = "'" .. worktree_name .. "' has uncommitted changes! Remove anyway?"
					end

					window:perform_action(
						wezterm.action.InputSelector({
							title = confirm_msg,
							choices = {
								{ label = "No", id = "no" },
								{ label = "Yes, remove it", id = "yes" },
							},
							action = wezterm.action_callback(function(inner_window, inner_pane, id)
								if id ~= "yes" then
									return
								end

								-- Collect panes in the worktree workspace to close
								local current_pane_id = inner_pane:pane_id()
								local other_panes = {}
								for _, mux_win in ipairs(wezterm.mux.all_windows()) do
									if mux_win:get_workspace() == worktree_path then
										for _, tab in ipairs(mux_win:tabs()) do
											for _, p in ipairs(tab:panes()) do
												if p:pane_id() ~= current_pane_id then
													other_panes[#other_panes + 1] = p
												end
											end
										end
									end
								end

								-- Close other panes in the workspace
								for _, p in ipairs(other_panes) do
									inner_window:perform_action(
										wezterm.action.CloseCurrentPane({ confirm = false }),
										p
									)
								end

								-- Switch to master workspace
								inner_window:perform_action(
									wezterm.action.SwitchToWorkspace({
										name = master_path,
										spawn = { cwd = master_path },
									}),
									inner_pane
								)

								-- Close the last pane from the old workspace
								inner_window:perform_action(
									wezterm.action.CloseCurrentPane({ confirm = false }),
									inner_pane
								)

								-- Remove the git worktree
								local cmd = { "git", "-C", master_path, "worktree", "remove", worktree_path }
								if is_dirty then
									cmd[#cmd + 1] = "--force"
								end
								local success, _, stderr = wezterm.run_child_process(cmd)

								if not success then
									inner_window:toast_notification(
										"wezterm",
										"Failed to remove worktree: " .. (stderr or "unknown error"),
										nil,
										4000
									)
								end
							end),
						}),
						pane
					)
				end),
			},
			{
				key = "z",
				mods = "LEADER",
				action = wezterm.action_callback(function(window, pane)
					wezterm.log_info(pane:get_foreground_process_info())
				end),
			},
			{
				key = " ",
				mods = "LEADER",
				action = wezterm.action_callback(function(window, pane)
					local names = utils.workspace_projects

					local choices = {}
					for _, name in ipairs(names) do
						local project_path = utils.workspace_base .. "/" .. name
						local entries = utils.get_worktree_entries(project_path)

						if entries then
							-- Worktree root: project name selects master
							choices[#choices + 1] = {
								label = name,
								id = project_path .. "/master",
							}
							-- Add non-master worktrees as children
							local non_master = {}
							for _, entry in ipairs(entries) do
								if entry.name ~= "master" then
									non_master[#non_master + 1] = entry
								end
							end
							for i, entry in ipairs(non_master) do
								local is_last = (i == #non_master)
								local connector = is_last and "└── " or "├── "
								choices[#choices + 1] = {
									label = "  " .. connector .. entry.name,
									id = entry.path,
								}
							end
						else
							choices[#choices + 1] = {
								label = name,
								id = project_path,
							}
						end
					end

					window:perform_action(
						wezterm.action.InputSelector({
							title = "Select a Workspace",
							action = wezterm.action_callback(function(_, _, id, _)
								if id then
									window:perform_action(
										wezterm.action.SwitchToWorkspace({
											name = id,
											spawn = {
												cwd = id,
											},
										}),
										pane
									)
								end
							end),
							choices = choices,
							fuzzy = true,
							fuzzy_description = "Select a Workspace: ",
						}),
						pane
					)
				end),
			},
			{
				key = ".",
				mods = "LEADER",
				action = wezterm.action_callback(function(window, pane)
					local directory = utils.get_directory(window)

					local workspace_name = directory
					if directory == wezterm.home_dir then
						workspace_name = "home"
					end

					window:perform_action(
						wezterm.action.SwitchToWorkspace({
							name = workspace_name,
						}),
						pane
					)
				end),
			},
			{
				key = "Enter",
				mods = "LEADER",
				action = wezterm.action.SwitchToWorkspace({
					name = config.default_workspace,
				}),
			},
			{
				key = "d",
				mods = "LEADER",
				action = wezterm.action.SwitchToWorkspace({
					name = config.default_workspace,
				}),
			},
			{
				key = "p",
				mods = "CMD",
				action = wezterm.action.ActivateCommandPalette,
			},
		}

		for i = 0, 9 do
			table.insert(config.keys, {
				key = tostring(i),
				mods = "LEADER",
				action = wezterm.action.ActivateTab(i),
			})
		end
	end,
}
