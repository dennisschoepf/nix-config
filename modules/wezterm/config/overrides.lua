local wezterm = require("wezterm")
local hn = wezterm.hostname()
local helpers = require("helpers")

local M = {}

function M.apply_to_config(config)
	if hn == "dnsc-work" then
		config.window_background_opacity = 0.975
		config.font_size = 19
	end

	if hn == "dnsc-desktop" then
		config.font = wezterm.font("Victor Mono", { weight = "DemiBold" })
		config.font_size = 14
		config.window_decorations = "RESIZE"
		config.window_padding = helpers.get_padding(18, 6)
		config.window_background_opacity = 1
	end
end

return M
