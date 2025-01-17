local git = require 'visimp.pak.git'
local logic = require 'visimp.pak.logic'
local window = require 'visimp.pak.window'

local M = {
  register = logic.register,
  any_missing = logic.any_missing,
  list = logic.list,
  install = git.install,
  update = git.update,
  clean = git.clean,
}

--- Runs a package manager command setting up the visual menu
-- @param cmd The method name
function M.run(cmd)
  window.init()
  window.open()
  if M[cmd] ~= nil then
    M[cmd]()
  else
    error('Invalid pak call: ' .. cmd)
  end
end

do
  vim.tbl_map(vim.cmd, {
    'command! -nargs=1 PakAdd lua local t=require(\'visimp.pak\') t.register({url = <q-args>}) vim.cmd(\'PakInstall\')',
    'command! PakInstall  lua require(\'visimp.pak\').run(\'install\')',
    'command! PakUpdate   lua require(\'visimp.pak\').run(\'update\')',
    'command! PakClean    lua require(\'visimp.pak\').run(\'clean\')',
    'command! PakList     lua require(\'visimp.pak\').run(\'list\')',
  })
end

return M
