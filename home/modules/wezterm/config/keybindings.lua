local wezterm = require("wezterm")
local helpers = require("helpers")
local projects = require("projects")

local M = {}

function M.apply_to_config(config)
	config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }

	config.keys = {
		-- Window/Pane Management
		{
			key = "|",
			mods = "LEADER",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "-",
			mods = "LEADER",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "-",
			mods = "LEADER",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "x",
			mods = "LEADER",
			action = wezterm.action.CloseCurrentPane({ confirm = true }),
		},
		{
			mods = "LEADER",
			key = "z",
			action = wezterm.action.TogglePaneZoomState,
		},
		{
			mods = "LEADER",
			key = "u",
			action = wezterm.action.PaneSelect({
				mode = "SwapWithActive",
			}),
		},
		{
			key = "X",
			mods = "CTRL",
			action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
		},
		{
			key = "L",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
		},
		-- Navigation
		helpers.split_nav("move", "h"),
		helpers.split_nav("move", "j"),
		helpers.split_nav("move", "k"),
		helpers.split_nav("move", "l"),
		helpers.split_nav("resize", "h"),
		helpers.split_nav("resize", "j"),
		helpers.split_nav("resize", "k"),
		helpers.split_nav("resize", "l"),
		-- Workspaces
		{
			key = "s",
			mods = "LEADER",
			action = projects.choose(),
		},
		{
			key = "w",
			mods = "LEADER",
			-- Present a list of existing workspaces
			action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
		},
		-- Misc
		{
			key = " ",
			mods = "LEADER",
			action = wezterm.action.ActivateCommandPalette,
		},
		{
			key = "[",
			mods = "LEADER",
			action = wezterm.action.ActivateCopyMode,
		},
		{
			key = "c",
			mods = "LEADER",
			action = wezterm.action.SpawnTab("CurrentPaneDomain"),
		},
	}

	for i = 1, 8 do
		table.insert(config.keys, {
			key = tostring(i),
			mods = "LEADER",
			action = wezterm.action.ActivateTab(i - 1),
		})
	end
end

return M
