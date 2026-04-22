local M = {}

M.config = {
  separator = " ",
  abs_hl = "PetruNumbersAbsolute",
  rel_hl = "PetruNumbersRelative",
  width = 0,
}

-- Returns the statuscolumn string for the current line.
-- Called per-line by Neovim via the statuscolumn expression.
function M.render_column()
  local lnum = vim.v.lnum
  local relnum = vim.v.relnum

  local width = M.config.width > 0 and M.config.width or #tostring(vim.fn.line("$"))
  local sep = M.config.separator

  local abs_str = string.format("%" .. width .. "d", lnum)
  local abs = "%#" .. M.config.abs_hl .. "#" .. abs_str .. "%#Normal#"

  -- On the current line, hide the relative number
  if relnum == 0 then
    return abs .. sep .. string.rep(" ", width)
  end

  local rel_str = string.format("%" .. width .. "d", relnum)
  local rel = "%#" .. M.config.rel_hl .. "#" .. rel_str .. "%#Normal#"

  return abs .. sep .. rel
end

local function set_highlights()
  vim.api.nvim_set_hl(0, "PetruNumbersAbsolute", { link = "LineNr", default = true })
  vim.api.nvim_set_hl(0, "PetruNumbersRelative", { link = "LineNr", default = true })
end

function M.setup(opts)
  if vim.fn.has("nvim-0.9") == 0 then
    vim.notify(
      "petru-numbers.nvim requires Neovim >= 0.9 (statuscolumn support)",
      vim.log.levels.ERROR
    )
    return
  end

  M.config = vim.tbl_extend("force", M.config, opts or {})

  set_highlights()

  -- statuscolumn needs these enabled to populate v:lnum / v:relnum
  vim.opt.number = true
  vim.opt.relativenumber = true

  vim.opt.statuscolumn = "%!v:lua.require('petru-numbers').render_column()"
end

return M
