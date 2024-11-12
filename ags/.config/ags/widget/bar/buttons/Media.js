"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var PanelButton_1 = require("../PanelButton");
var options_1 = require("options");
var icons_1 = require("lib/icons");
var utils_1 = require("lib/utils");
var mpris = await Service.import("mpris");
var _a = options_1.default.bar.media, length = _a.length, direction = _a.direction, preferred = _a.preferred, monochrome = _a.monochrome, format = _a.format;
var getPlayer = function (name) {
    if (name === void 0) { name = preferred.value; }
    return mpris.getPlayer(name) || mpris.players[0] || null;
};
var Content = function (player) {
    var revealer = Widget.Revealer({
        click_through: true,
        visible: length.bind().as(function (l) { return l > 0; }),
        transition: direction.bind().as(function (d) { return "slide_".concat(d); }),
        setup: function (self) {
            var current = "";
            self.hook(player, function () {
                if (current === player.track_title)
                    return;
                current = player.track_title;
                self.reveal_child = true;
                Utils.timeout(3000, function () {
                    !self.is_destroyed && (self.reveal_child = false);
                });
            });
        },
        child: Widget.Label({
            truncate: "end",
            max_width_chars: length.bind().as(function (n) { return n > 0 ? n : -1; }),
            label: Utils.merge([
                player.bind("track_title"),
                player.bind("track_artists"),
                format.bind(),
            ], function () { return "".concat(format)
                .replace("{title}", player.track_title)
                .replace("{artists}", player.track_artists.join(", "))
                .replace("{artist}", player.track_artists[0] || "")
                .replace("{album}", player.track_album)
                .replace("{name}", player.name)
                .replace("{identity}", player.identity); }),
        }),
    });
    var playericon = Widget.Icon({
        icon: Utils.merge([player.bind("entry"), monochrome.bind()], (function (entry) {
            var name = "".concat(entry).concat(monochrome.value ? "-symbolic" : "");
            return (0, utils_1.icon)(name, icons_1.default.fallback.audio);
        })),
    });
    return Widget.Box({
        attribute: { revealer: revealer },
        children: direction.bind().as(function (d) { return d === "right"
            ? [playericon, revealer] : [revealer, playericon]; }),
    });
};
exports.default = (function () {
    var player = getPlayer();
    var btn = (0, PanelButton_1.default)({
        class_name: "media",
        child: Widget.Icon(icons_1.default.fallback.audio),
    });
    var update = function () {
        player = getPlayer();
        btn.visible = !!player;
        if (!player)
            return;
        var content = Content(player);
        var revealer = content.attribute.revealer;
        btn.child = content;
        btn.on_primary_click = function () { player.playPause(); };
        btn.on_secondary_click = function () { player.playPause(); };
        btn.on_scroll_up = function () { player.next(); };
        btn.on_scroll_down = function () { player.previous(); };
        btn.on_hover = function () { revealer.reveal_child = true; };
        btn.on_hover_lost = function () { revealer.reveal_child = false; };
    };
    return btn
        .hook(preferred, update)
        .hook(mpris, update, "notify::players");
});
