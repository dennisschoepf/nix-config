-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

local function filter(arr, fn)
  if type(arr) ~= "table" then
    return arr
  end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then
      table.insert(filtered, v)
    end
  end

  return filtered
end

local function filterReactDTS(value)
  -- Depending on typescript version either uri or targetUri is returned
  if value.uri then
    return string.match(value.uri, "%.d.ts") == nil
  elseif value.targetUri then
    return string.match(value.targetUri, "%.d.ts") == nil
  end
end

local project_types = {
  ["main.odin"] = "odin run .",
  ["package.json"] = "pnpm run dev",
  ["Makefile"] = "make",
}

local function find_project_type()
  for marker, _ in pairs(project_types) do
    if vim.fn.glob(marker) ~= "" then
      return marker
    end
  end
  return nil
end

local function compile_project()
  local marker = find_project_type()

  if not marker then
    vim.notify("No recognized project type found", vim.log.levels.WARN)
    return
  end

  local cmd = project_types[marker]

  -- Create a new terminal buffer and run the command
  vim.cmd("botright new") -- Create new window at bottom
  vim.cmd("terminal " .. cmd)

  -- Enter normal mode and hide the buffer number
  vim.cmd("setlocal nonumber")
  vim.cmd("setlocal norelativenumber")
  vim.cmd("startinsert")
end

return {
  compile_project = compile_project,
  filter = filter,
  filterReactDTS = filterReactDTS,
}
