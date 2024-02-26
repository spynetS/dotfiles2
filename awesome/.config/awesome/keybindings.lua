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

modkey = "Mod4"


local function print_awesome_memory_stats(message)
    print(os.date(), "\nLua memory usage:", collectgarbage("count"))
    out_string = tostring(os.date()) .. "\nLua memory usage:"..tostring(collectgarbage("count")).."\n"
    out_string = out_string .. "Objects alive:"
    print("Objects alive:")
    for name, obj in pairs{ button = button, client = client, drawable = drawable, drawin = drawin, key = key, screen = screen, tag = tag } do
        out_string =out_string .. "\n" .. tostring(name) .. " = " ..tostring(obj.instances())
        print(name, obj.instances())
    end
    naughty.notify({title = "Awesome WM memory statistics " .. message, text = out_string, timeout=20,hover_timeout=20})
end

function clientkeys(gears, awful)
    return gears.table.join(
awful.key({modkey,"Control" }, "s", function()
    print_awesome_memory_stats("Precollect")
    collectgarbage("collect")
    collectgarbage("collect")
    gears.timer.start_new(20, function()
        print_awesome_memory_stats("Postcollect")
        return false
    end)
end, {description = "print awesome wm memory statistics", group="awesome"}),
    awful.key({ modkey,"Shift"}, "Tab",      function (c) c:move_to_screen()               end,
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
end

function global_keys(gears, awful)
  return gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,"Shift"}, "s",function() awful.spawn.with_shell("maim -s --format=png /dev/stdout | xclip -selection clipboard -t image/png -i")  end ,
    {description = "go back", group = "tag"}),
    awful.key({ modkey,"Shift"}, "w",function() awful.spawn.with_shell("rofi -show window")  end ,
    {description = "go back", group = "tag"}),

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

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
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

    -- My keysbindings :)))))
    -- awful.key({ modkey,           }, "l", function () awful.spawn.with_shell("~/.config/rofi/applets/bin/quicklinks.sh") end,
    --           {description="rofi links", group="rofi"}),
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
    awful.key({ modkey,           }, "a", function () awful.spawn.with_shell("~/.config/rofi/applets/bin/apps.sh") end,
              {description="rofi apps", group="rofi"}),
    awful.key({ modkey,           }, "d", function () awful.spawn.with_shell("~/.config/rofi/launchers/type-6/launcher.sh") end,
              {description = "open rofi", group = "rofi"}),

    awful.key({ modkey }, "o",function() require("awful").screen.focused().selected_tag.gap = require("awful").screen.focused().selected_tag.gap+1 end,
              {description="sets kayboard to us", group="awesome"}),
    awful.key({ modkey,"Shift"}, "o",function() require("awful").screen.focused().selected_tag.gap = require("awful").screen.focused().selected_tag.gap-1 end,
              {description="sets kayboard to us", group="awesome"}),

    awful.key({ modkey,"Shift"}, "c",function() awful.spawn("kitty --class calcer calcer -s ")  end,
              {description="spawn calculatro", group="apps"}),

    awful.key({"Control", "Shift"          }, "k",      function() awful.spawn.with_shell("setxkbmap us") end,
              {description="sets kayboard to us", group="awesome"}),
    awful.key({"Control", "Shift"           }, "l",      function() awful.spawn.with_shell("setxkbmap se") end,
              {description="sets kayboard to se", group="awesome"}),
    awful.key({ modkey,           }, "w", function () awful.spawn(browser) end,
              {description = "open broweser", group = "launcher"}),
    awful.key({ modkey,      "Shift"}, "e", function () awful.spawn("alacritty -e oec") end,
              {description = "open broweser", group = "launcher"}),
    awful.key({ modkey,           }, "e", function () awful.spawn(fm) end,
              {description = "open fm", group = "launcher"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Control"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,  "Control"}, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),

    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),

    awful.key({ modkey,"Shift"}, "q", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey,    }, "q", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

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

    -- Prompt
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
    -- Menubar
    awful.key({ modkey,"Shift" }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)
end
