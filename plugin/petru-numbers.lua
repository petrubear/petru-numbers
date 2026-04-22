-- auto-load guard: prevent double initialization
if vim.g.petru_numbers_loaded then
  return
end
vim.g.petru_numbers_loaded = true
