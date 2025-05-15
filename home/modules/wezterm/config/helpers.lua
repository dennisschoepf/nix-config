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

function M.is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

function M.split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if M.is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

return M
