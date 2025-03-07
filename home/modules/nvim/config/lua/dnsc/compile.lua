-- Map of file markers to their compile commands
local project_types = {
  ["main.odin"] = "odin build . -file",
  ["package.json"] = "npm run build",
  ["go.mod"] = "go build ./...",
  ["Cargo.toml"] = "cargo build",
  ["CMakeLists.txt"] = "cmake --build build",
  ["Makefile"] = "make",
}

local function find_project_type()
  -- Search for known project markers in the current directory
  for marker, _ in pairs(project_types) do
    -- Use vim.fn.glob() to check if file exists in current directory
    if vim.fn.glob(marker) ~= "" then
      return marker
    end
  end
  return nil
end

local function compile()
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
  compile,
}
