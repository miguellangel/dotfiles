local packer = nil
local function init()
  if packer == nil then
    packer = require 'packer'
    packer.init {
      disable_commands = true,
      display = {
        open_fn = function()
          local result, win, buf = require('packer.util').float {
            border = {
              { '╭', 'FloatBorder' },
              { '─', 'FloatBorder' },
              { '╮', 'FloatBorder' },
              { '│', 'FloatBorder' },
              { '╯', 'FloatBorder' },
              { '─', 'FloatBorder' },
              { '╰', 'FloatBorder' },
              { '│', 'FloatBorder' },
            },
          }
          vim.api.nvim_win_set_option(win, 'winhighlight', 'NormalFloat:Normal')
          return result, win, buf
        end,
      },
    }
  end

  local use = packer.use
  packer.reset()

  -- Packer



end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
