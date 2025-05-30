local wezterm = require("wezterm")
local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main
local helpers = require("helpers")

local M = {}

local function get_elements(for_window)
	return {
		{ Background = { Color = theme.colors().tab_bar.background } },
		{ Foreground = { Color = theme.colors().tab_bar.inactive_tab.fg_color } },
		{ Text = "h:" .. wezterm.hostname() .. "  " },
		{ Text = "upgrades:" .. helpers.get_outdated_packages() .. "  " },
		{ Text = "bat:" .. helpers.get_primary_battery_state() .. "  " },
		{ Background = { Color = theme.colors().tab_bar.active_tab.bg_color } },
		{ Foreground = { Color = theme.colors().tab_bar.active_tab.fg_color } },
		{ Text = " session >> " .. for_window:active_workspace() .. " " },
	}
end

wezterm.on("update-right-status", function(window, _)
	window:set_right_status(wezterm.format(get_elements(window)))
end)

function M.apply_to_config(config)
	config.enable_tab_bar = true
	config.use_fancy_tab_bar = true
	config.tab_bar_at_bottom = false

	config.window_frame = {
		inactive_titlebar_bg = theme.colors().tab_bar.background,
		active_titlebar_bg = theme.colors().tab_bar.background,
		font = wezterm.font({ family = "Victor Mono", weight = "Bold" }),
	}

	config.colors = {
		tab_bar = theme.colors().tab_bar,
	}
end

return M
