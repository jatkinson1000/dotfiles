-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.font_size = 10.0

-- Color scheme:
-- config.color_scheme = 'AdventureTime'

config.colors = {
    -- Default text color
    foreground = '#00FF00',
    -- Default background color
    background = 'black',

    cursor_bg = '#00FF00',
    cursor_fg = 'black',

    selection_fg = 'black',
    selection_bg = '#00ff00',

    split = '#444444',
}

config.cursor_blink_rate = 800

config.window_background_opacity = 0.75

-- Temporary fix for crashing when multiple windows opened. See https://github.com/wez/wezterm/issues/5103
config.front_end = 'WebGpu'

-- and finally, return the configuration to wezterm
return config
