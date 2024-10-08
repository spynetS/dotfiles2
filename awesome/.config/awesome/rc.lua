-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
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

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

beautiful.init(gears.filesystem.get_themes_dir() .. "xresources/theme.lua")

beautiful.useless_gap = 3
beautiful.font = "hack 11"

-- This is used later as the default terminal and editor to run.
terminal   = "alacritty"
browser    = "firefox"
fm         = 'dolphin'
editor     = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    -- awful.layout.suit.fair, awful.layout.suit.floating,
    -- awful.layout.suit.fair.horizontal, awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    awful.layout.suit.max,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })


-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

widgets = require("widgets")

local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper

    -- Each screen has its own tag table.
    -- awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
    layouts = awful.layout.layouts
        tags = {
            names  = { " 1 ", " 2 ", " 3 ", "discord", " 5 ", "mail", "game", "music", " 9 "},
            layout = { layouts[1], layouts[1], layouts[1], layouts[1], layouts[1],
                       layouts[1], layouts[1], layouts[1], layouts[1]
    }}
    tags[s] = awful.tag(tags.names, s, tags.layout)

    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    s.mywibox = awful.wibox({ position = "top", screen = s, height=24, width=1920, opacity=0.8})
    local sep = wibox.widget{
        markup = ' ',
        align  = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
            spot_widget(),
        sep,
        },
        s.mytasklist,
        { -- Right widgets
        sep,
            layout = wibox.layout.fixed.horizontal,
            -- pacman_widget(),
            audioController(),
            battery(),
            wifi(),
            memory_widget(),
            cpu_widget(),
            wibox.widget.systray(),
            mykeyboardlayout,
            text_clock(),
            s.mylayoutbox,
        },
    }
end)

root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

clientkeys = gears.table.join(

    awful.key({ modkey,"Shift"}, "Tab",      function (c) c:move_to_screen() end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey, 'Control' }, 't',awful.titlebar.toggle,
            {description = 'toggle title bar', group = 'client'}),
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,    }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Shift" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, ",",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),

    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

    awful.key({ modkey,  }, "Left", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey,  }, "Right", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),

    awful.key({ modkey }, "o",function() require("awful").screen.focused().selected_tag.gap = require("awful").screen.focused().selected_tag.gap+1 end,
              {description="increase gaps", group="awesome"}),

    awful.key({ modkey,"Shift"}, "o",function() require("awful").screen.focused().selected_tag.gap = require("awful").screen.focused().selected_tag.gap-1 end,
              {description="decrease gaps", group="awesome"}),

    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Control"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            awful.client.focus.bydirection("down")
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.bydirection("up")
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "h",
        function ()
            awful.client.focus.bydirection("left")
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "l",
        function ()
            awful.client.focus.bydirection("right")
        end,
        {description = "focus previous by index", group = "client"}
    ),

    awful.key({ modkey, "Control" }, ",",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
    --           {description = "go back", group = "tag"}),

    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incmwfact( 0.02)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,  "Control"}, "h",     function () awful.tag.incmwfact(-0.02)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Control" }, "j",     function () awful.client.incwfact( 0.08)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,  "Control"}, "k",     function () awful.client.incwfact(-0.08)          end,
              {description = "decrease master width factor", group = "layout"}),


    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),

    awful.key({ modkey,"Shift"}, "q", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey,    }, "q", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey,"Shift"}, "s",function() awful.spawn.with_shell("maim -s --format=png /dev/stdout | xclip -selection clipboard -t image/png -i")  end ,
    {description = "go back", group = "tag"}),

    awful.key({ modkey,"Control"}, "s",function() awful.spawn.with_shell("maim -s ~/Pictures/Screenshots/$(date +%s).png")  end ,
    {description = "go back", group = "tag"}),

    awful.key({ modkey,"Shift"}, "w",function() awful.spawn.with_shell("rofi -show window")  end ,
    {description = "Rofi show window", group = "rofi"}),
    awful.key({ modkey,           }, "n", function () awful.spawn.with_shell("~/.config/rofi/applets/bin/mpd.sh") end,
              {description="rofi mpd", group="rofi"}),
    awful.key({ modkey,           }, "v", function () awful.spawn.with_shell("~/.config/rofi/applets/bin/volume.sh") end,
              {description="rofi volume", group="rofi"}),
    awful.key({ modkey,           }, "b", function () awful.spawn.with_shell("~/.config/rofi/applets/bin/battery.sh") end,
              {description="rofi battery", group="rofi"}),
    awful.key({ modkey,"Shift"           }, "b", function () awful.spawn.with_shell("~/.config/rofi/applets/bin/brightness.sh") end,
              {description="rofi brightness", group="rofi"}),
    awful.key({ modkey,           }, "p", function () awful.spawn.with_shell("~/.config/rofi/applets/bin/powermenu.sh") end,
              {description="rofi powermenu", group="rofi"}),
    -- awful.key({ modkey,           }, "a", function () awful.spawn.with_shell("~/.config/rofi/applets/bin/apps.sh") end,
    --           {description="rofi apps", group="rofi"}),
    awful.key({ modkey,           }, "d", function () awful.spawn.with_shell("~/.config/rofi/launchers/type-6/launcher.sh") end,
              {description = "open rofi", group = "rofi"}),
    --- end rofi

    awful.key({}, "XF86AudioPlay",
        function () awful.spawn("playerctl play-pause") end,
        {description = "play-pause playerctl", group = "client"}
    ),
    awful.key({}, "XF86AudioRaiseVolume",
        function () awful.spawn("playerctl volume 0.05+") end,
        {description = "raise playerctl volume", group = "client"}
    ),
    awful.key({}, "XF86AudioLowerVolume",
        function () awful.spawn("playerctl volume 0.05-") end,
        {description = "lower playerctl volume", group = "client"}
    ),

    awful.key({ modkey,"Shift"}, "c",function() awful.spawn(terminal.." -e --class calcer calc ")  end,
              {description="spawn calculatro", group="apps"}),

    awful.key({"Control", "Shift"          }, "k",      function() awful.spawn.with_shell("setxkbmap us") end,
              {description="sets kayboard to us", group="awesome"}),
    awful.key({"Control", "Shift"           }, "l",      function() awful.spawn.with_shell("setxkbmap se") end,
              {description="sets kayboard to se", group="awesome"}),

    awful.key({ modkey,           }, "w", function () awful.spawn(browser) end,
              {description = "open browser", group = "launcher"}),
    awful.key({ modkey, "Control"}, "w", function () awful.spawn.with_shell(terminal .. " -e /home/spy/dotfiles2/opener/opener.sh") end,
              {description = "open opener which will open browser", group = "launcher"}),

    awful.key({ modkey, ""}, "a", function () awful.spawn.with_shell(terminal .. " --class ncmpcpp -e  ncmpcpp") end,
              {description = "oppens ncmpcpp", group = "launcher"}),

    awful.key({ modkey,      "Shift"}, "e", function () awful.spawn.with_shell(terminal .. " -e oec") end,
              {description = "open emacs client fzf", group = "launcher"}),
    awful.key({ modkey,     }, "e", function () awful.spawn.with_shell("emacsclient -c -a ''") end,
              {description = "open emacs client fzf", group = "launcher"}),

    awful.key({ modkey,           }, "f3", function () awful.spawn(fm) end,
              {description = "open fm", group = "launcher"}),
    awful.key({ modkey,   "Shift"}, "f", function () awful.spawn("emacsclient -c -e '(dired \"./\")'") end,
              {description = "open fm", group = "launcher"}),

    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),

    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    awful.key({ modkey,"Shift" }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                              tag:view_only()
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        awful.key({ modkey, "Ctrl" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

awful.rules.rules = {

    { rule = { },
      properties = { border_width = 2,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    { rule = { class = "discord" },
      properties = { screen = 1, tag = "discord" } },
    { rule = { class = "steam" },
      properties = { screen = 1, tag = "game" } },

    { rule = { class = "ncmpcpp" },
      properties = { screen = 1, tag = "music" } },

    { rule = { class = "thunderbird" },
      properties = { screen = 1, tag = "mail" } },

}

client.connect_signal("property::floating", function(c)
  if c.floating and not c.requests_no_titlebar then
    awful.titlebar.show(c)
  else
    awful.titlebar.hide(c)
  end
end)

client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = true})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

awful.spawn.with_shell("export QT_QPA_PLATFORMTHEME=qt6ct")
awful.spawn.with_shell("export TERM=" .. terminal)
awful.spawn.with_shell("touch /home/spy/"..terminal)


awful.spawn.with_shell("picom")
awful.spawn.with_shell("wal -R -a 75")
awful.spawn.with_shell("mpd")
awful.spawn.with_shell("mpDris2")
awful.spawn.with_shell("nitrogen --restore")
awful.spawn.with_shell("emacs --daemon")
awful.spawn.with_shell("./.screenlayout/main.sh")
