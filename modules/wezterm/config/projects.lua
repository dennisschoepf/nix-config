local wezterm = require("wezterm")
local helpers = require("helpers")

local M = {}

function M.choose()
	local choices = {}

	for _, value in ipairs(helpers.project_dirs()) do
		table.insert(choices, { label = value })
	end

	return wezterm.action.InputSelector({
		title = "Projects",
		choices = choices,
		fuzzy = true,
		action = wezterm.action_callback(function(child_window, child_pane, _, label)
			if not label then
				return
			end

			child_window:perform_action(
				wezterm.action.SwitchToWorkspace({
					name = label:match("([^/]+)$"),
					spawn = { cwd = label },
				}),
				child_pane
			)
		end),
	})
end

return M
