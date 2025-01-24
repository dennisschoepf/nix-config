local wezterm = require("wezterm")

local M = {}

function M.project_dir()
	return wezterm.home_dir .. "/dev"
end

function M.project_dirs()
	local projects = { wezterm.home_dir }

	for _, dir in ipairs(wezterm.glob(M.project_dir() .. "/*")) do
		table.insert(projects, dir)
	end

	return projects
end

function M.get_outdated_packages()
	local success, stdout, stderr =
		wezterm.run_child_process({ "sh", "-c", "/opt/homebrew/bin/brew outdated -q | wc -l" })

	if success ~= true then
		wezterm.log_error(stderr)

		return "X"
	end

	return stdout:gsub("%s+", "")
end

function M.get_primary_battery_state()
	local battery_info = wezterm.battery_info()

	return string.format("%.0f%%", battery_info[1].state_of_charge * 100)
end

function M.get_padding(padding, remove_padding_bottom)
	return {
		left = padding,
		right = padding,
		top = padding,
		bottom = padding - remove_padding_bottom,
	}
end

function M.move_pane(key, direction)
	return {
		key = key,
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection(direction),
	}
end

return M
