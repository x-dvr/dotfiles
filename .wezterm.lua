-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.enable_wayland = true

-- setup window
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 1,
  right = 1,
  top = 0,
  bottom = 0,
}

-- disable tab bars
-- wezterm.on('update-right-status', function(window, pane)
--   window:set_left_status ''
--   window:set_right_status ''
-- end)

config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
-- end of disable tab bars

-- color scheme:
config.color_scheme = 'Catppuccin Macchiato'

config.window_background_opacity = 0.9

config.font = wezterm.font 'JetBrainsMono NF Light'
config.font_size = 10.5
config.cell_width = 1.1
config.line_height = 1.0

-- and finally, return the configuration to wezterm
return config