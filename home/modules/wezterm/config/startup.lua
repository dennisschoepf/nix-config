local wezterm = require("wezterm")
local mux = wezterm.mux
local helpers = require("helpers")

local M = {}

wezterm.on("gui-startup", function(cmd)
	local args = {}
	if cmd then
		args = cmd.args
	end

	-- WORKSPACES
	-- W: dennis
	local _, _, _ = mux.spawn_window({
		workspace = "dennis",
		cwd = wezterm.home_dir,
		args = args,
	})

	mux.set_active_workspace("dennis")
end)

function M.apply_to_config(config)
	return config
end

return M
