local wezterm = require("wezterm")
local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main
local helpers = require("helpers")

local M = {}

local scheme = wezterm.get_builtin_color_schemes()["rose-pine"]

scheme.selection_fg = "white"
scheme.selection_bg = "teal"
scheme.copy_mode_active_highlight_bg = { AnsiColor = "Teal" }
scheme.copy_mode_active_highlight_fg = { AnsiColor = "White" }
scheme.copy_mode_inactive_highlight_bg = { AnsiColor = "Silver" }
scheme.copy_mode_inactive_highlight_fg = { AnsiColor = "Black" }

function M.apply_to_config(config)
	config.color_schemes = {
		["rose-pine"] = scheme,
	}
	config.color_scheme = "rose-pine"
	config.font = wezterm.font("VictorMono Nerd Font", { weight = "DemiBold", stretch = "Normal", style = "Normal" })
	config.font_size = 18.5
	config.window_decorations = "RESIZE"
	config.window_padding = helpers.get_padding(20, 15)
	config.window_background_opacity = 0.97
	config.macos_window_background_blur = 30
	config.command_palette_font_size = 19
	config.command_palette_fg_color = theme.colors().foreground
	config.command_palette_bg_color = theme.colors().tab_bar.active_tab.bg_color
end

return M
