local M = {}

M.base_30 = {
  white = "#FFFFFF",
  darker_black = "#1e1e1e",
  black = "#1E1E1E", --  nvim bg
  black2 = "#252525",
  one_bg = "#2d2c2c", -- real bg of onedark
  one_bg2 = "#363636",
  one_bg3 = "#252525",
  grey = "#474747",
  grey_fg = "#4e4e4e",
  grey_fg2 = "#555555",
  light_grey = "#606060",
  red = "#F38BA8",
  baby_pink = "#ffa5c3",
  pink = "#F5C2E7",
  line = "#383838", -- for lines like vertsplit
  green = "#ABE9B3",
  vibrant_green = "#b6f4be",
  nord_blue = "#89b4fa",
  blue = "#89B4FA",
  yellow = "#FAE3B0",
  sun = "#ffe9b6",
  purple = "#d0a9e5",
  dark_purple = "#c7a0dc",
  teal = "#B5E8E0",
  orange = "#F8BD96",
  cyan = "#89DCEB",
  statusline_bg = "#1e1e1e",
  lightbg = "#313131",
  pmenu_bg = "#ABE9B3",
  folder_bg = "#89B4FA",
  lavender = "#c7d1ff",
}

M.base_16 = {
  base00 = "#1e1e1e",
  base01 = "#282828",
  base02 = "#2f2f2f",
  base03 = "#383838",
  base04 = "#414141",
  base05 = "#bfc6d4",
  base06 = "#ccd3e1",
  base07 = "#D9E0EE",
  base08 = "#F38BA8",
  base09 = "#F8BD96",
  base0A = "#FAE3B0",
  base0B = "#ABE9B3",
  base0C = "#89DCEB",
  base0D = "#89B4FA",
  base0E = "#CBA6F7",
  base0F = "#F38BA8",
}

M.polish_hl = {
  treesitter = {
    ["@variable"] = { fg = M.base_30.lavender },
    ["@property"] = { fg = M.base_30.teal },
    ["@variable.builtin"] = { fg = M.base_30.red },
  },
}

M.type = "dark"

return M
