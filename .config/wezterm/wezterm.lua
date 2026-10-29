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
config.font = wezterm.font 'Maple Mono NF'
config.font_size = 14.0

-- Color scheme:
-- config.color_scheme = 'AdventureTime'
config.color_scheme = 'carbonfox'

config.colors = {
    -- Default text color
    foreground = '#44FF44',
    -- Default background color
    background = 'black',

    cursor_bg = '#44FF44',
    cursor_fg = 'black',

    selection_fg = 'black',
    selection_bg = '#44ff44',

    split = '#444444',
}

config.cursor_blink_rate = 800

config.window_background_opacity = 0.75

-- Temporary fix for crashing when multiple windows opened. See https://github.com/wez/wezterm/issues/5103
config.front_end = 'WebGpu'
-- ix for failing to run on multiple screens, lauching wezterm GUI and crashing. See https://github.com/wezterm/wezterm/issues/3121
config.enable_wayland = false

-- and finally, return the configuration to wezterm
return config
