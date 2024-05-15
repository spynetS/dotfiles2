local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

function audioController()
    local volume_widget = require('widgets-pack.volume-widget.volume')
    return volume_widget{
        widget_type = 'icon_and_text',
    }
end

function wifi()
 local net_speed_widget = require("widgets-pack.net-speed-widget.net-speed")   -- return widget
 return net_speed_widget()
end
function battery()
    local batteryarc_widget = require("widgets-pack.batteryarc-widget.batteryarc")
    return  batteryarc_widget({
            show_current_level = true,
            arc_thickness = 1,
        })
end

function memory_widget()
    -- local textbox = require("wibox.widget.textbox")
    -- local memory_widget = textbox()
    -- memory_widget.valign = 'center'

    -- local command = "free | grep Mem | awk '{print \"Mem use: \"  int($3 / $2 * 100) \"%\"  }'"
    -- timer {
    --     timeout = 1,
    --     autostart = true,
    --     callback = function ()
    --     memory_widget.markup = "<span  ><span foreground=\"#76b5c5\" > 💾</span> "..io.popen(command):read("*all").."</span>"
    --     end
    -- }
    -- memory_widget.markup = "<span  ><span foreground=\"#76b5c5\" > 💾</span> "..io.popen(command):read("*all").."</span>"

    -- return memory_widget
    local ram_widget = require("widgets-pack.ram-widget.ram-widget")
    return ram_widget()
end

function text_clock()
  return wibox.widget.textclock("%h%d(v%V)|%H:%M ")
end


function mpc_widget()
    return require("widgets-pack.mpdarc-widget.mpdarc")
end

function cpu_widget()
    local cpu_widget = require("widgets-pack.cpu-widget.cpu-widget")
    return cpu_widget({
            width = 70,
            step_width = 2,
            step_spacing = 0,
            color = '#434c5e'
        })
end

function pacman_widget()
    local pacman_widget = require('widgets-pack.pacman-widget.pacman')
    return pacman_widget {
                interval = 600,	-- Refresh every 10 minutes
                popup_bg_color = '#222222',
                popup_border_width = 1,
                popup_border_color = '#7e7e7e',
                popup_height = 10,	-- 10 packages shown in scrollable window
                popup_width = 300,
                polkit_agent_path = '/usr/bin/lxpolkit'
            }
end
function spot_widget()
    local spotify_widget = require('widgets-pack.spotify-widget.spotify')
    return spotify_widget ({
        -- font = 'Sans regular',
        play_icon = '/usr/share/icons/Papirus-Light/24x24/categories/spotify.svg',
        pause_icon = '/usr/share/icons/Papirus-Dark/24x24/panel/spotify-indicator.svg',
        dim_when_paused = true,
        dim_opacity = 0.5,
        max_length = -1,
        show_tooltip = false,
        -- sp_bin = gears.filesystem.get_configuration_dir() .. 'scripts/sp'
    })
end
