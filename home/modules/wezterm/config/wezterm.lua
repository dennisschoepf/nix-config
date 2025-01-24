local wezterm = require("wezterm")
local appearance = require("appearance")
local tab_bar = require("tab_bar")
local startup = require("startup")
local keybindings = require("keybindings")
local overrides = require("overrides")

local config = {}

if wezterm.config_builder then
	---@diagnostic disable-next-line: lowercase-global
	config = wezterm.config_builder()
end

appearance.apply_to_config(config)
tab_bar.apply_to_config(config)
startup.apply_to_config(config)
keybindings.apply_to_config(config)
overrides.apply_to_config(config)

return config
