-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

function tbl_flatten(t)
  --- @diagnostic disable-next-line:deprecated
  return nvim_eleven and vim.iter(t):flatten(math.huge):totable() or vim.tbl_flatten(t)
end

function search_ancestors(startpath, func)
  if nvim_eleven then
    validate('func', func, 'function')
  end
  if func(startpath) then
    return startpath
  end
  local guard = 100
  for path in vim.fs.parents(startpath) do
    -- Prevent infinite recursion if our algorithm breaks
    guard = guard - 1
    if guard == 0 then
      return
    end

    if func(path) then
      return path
    end
  end
end

local function escape_wildcards(path)
  return path:gsub('([%[%]%?%*])', '\\%1')
end

function strip_archive_subpath(path)
  -- Matches regex from zip.vim / tar.vim
  path = vim.fn.substitute(path, 'zipfile://\\(.\\{-}\\)::[^\\\\].*$', '\\1', '')
  path = vim.fn.substitute(path, 'tarfile:\\(.\\{-}\\)::.*$', '\\1', '')
  return path
end

local function root_pattern(...)
  local patterns = tbl_flatten({ ... })
  return function(startpath)
    startpath = strip_archive_subpath(startpath)
    for _, pattern in ipairs(patterns) do
      local match = search_ancestors(startpath, function(path)
        for _, p in ipairs(vim.fn.glob(table.concat({ escape_wildcards(path), pattern }, "/"), true, true)) do
          if vim.loop.fs_stat(p) then
            return path
          end
        end
      end)

      if match ~= nil then
        return match
      end
    end
  end
end

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
  root_pattern = root_pattern
}
