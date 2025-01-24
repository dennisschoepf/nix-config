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

	-- W: dnsc-v2
	local dnsc_v2_root = helpers.project_dir() .. "/dnsc-v2"
	local _, dnsc_v2_root_pane, _ = mux.spawn_window({
		workspace = "dnsc-v2",
		cwd = dnsc_v2_root,
		args = args,
	})

	local _ = dnsc_v2_root_pane:split({
		direction = "Left",
		size = 0.7,
		cwd = dnsc_v2_root,
	})

	-- dnsc_v2_root_pane:send_text("npm run dev\n")

	-- W: freed
	local freed_root = helpers.project_dir() .. "/freed"
	local _, freed_root_pane, _ = mux.spawn_window({
		workspace = "freed",
		cwd = freed_root,
		args = args,
	})

	local _ = freed_root_pane:split({
		direction = "Left",
		size = 0.7,
		cwd = freed_root,
	})

	-- freed_root_pane:send_text("air\n")

	mux.set_active_workspace("dennis")
end)

function M.apply_to_config(config)
	return config
end

return M
