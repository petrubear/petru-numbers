# petru-numbers.nvim

A Neovim plugin that shows **absolute** and **relative** line numbers simultaneously in the gutter — absolute on the left, relative on the right.

```
  1  12  local M = {}
  2  11
  3  10  M.config = {
  4   9    separator = " ",
  5   8    ...
  6   7  }
  7   6
  8   5  function M.setup(opts)   ← cursor is here (line 8, relative = 0 is hidden)
  9   4
 10   3
```

## Requirements

- Neovim **0.9+** (requires `statuscolumn` support)

## Installation

### lazy.nvim / LazyVim

```lua
{
  "petrubear/petru-numbers",
  opts = {},
}
```

### With custom options

```lua
{
  "petrubear/petru-numbers",
  opts = {
    separator = " ",                    -- characters between the two columns
    abs_hl    = "PetruNumbersAbsolute", -- highlight group for the absolute column
    rel_hl    = "PetruNumbersRelative", -- highlight group for the relative column
    width     = 0,                      -- min column width; 0 = auto from line count
  },
}
```

## Default Config

| Option | Default | Description |
|--------|---------|-------------|
| `separator` | `" "` | String rendered between the absolute and relative columns |
| `abs_hl` | `"PetruNumbersAbsolute"` | Highlight group for absolute numbers (links to `LineNr`) |
| `rel_hl` | `"PetruNumbersRelative"` | Highlight group for relative numbers (links to `LineNr`) |
| `width` | `0` | Minimum digit width per column; `0` = derived from total line count |

## Highlight Groups

| Group | Default Link | Purpose |
|-------|-------------|---------|
| `PetruNumbersAbsolute` | `LineNr` | Absolute number column |
| `PetruNumbersRelative` | `LineNr` | Relative number column |

Override in your colorscheme or config:

```lua
vim.api.nvim_set_hl(0, "PetruNumbersAbsolute", { fg = "#888888" })
vim.api.nvim_set_hl(0, "PetruNumbersRelative", { fg = "#5c6370" })
```

## How It Works

The plugin sets `vim.opt.statuscolumn` to a Lua expression evaluated per line. On each line it renders:

- **Left column** — the absolute line number (`v:lnum`)
- **Separator** — configurable string between the two columns
- **Right column** — the relative line number (`v:relnum`), blank on the current line

## License

MIT
