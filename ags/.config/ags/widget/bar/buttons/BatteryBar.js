"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var icons_1 = require("lib/icons");
var options_1 = require("options");
var PanelButton_1 = require("../PanelButton");
var battery = await Service.import("battery");
var _a = options_1.default.bar.battery, bar = _a.bar, percentage = _a.percentage, blocks = _a.blocks, width = _a.width, low = _a.low;
var Indicator = function () { return Widget.Icon({
    setup: function (self) { return self.hook(battery, function () {
        self.icon = battery.charging || battery.charged
            ? icons_1.default.battery.charging
            : battery.icon_name;
    }); },
}); };
var PercentLabel = function () { return Widget.Revealer({
    transition: "slide_right",
    click_through: true,
    reveal_child: percentage.bind(),
    child: Widget.Label({
        label: battery.bind("percent").as(function (p) { return "".concat(p, "%"); }),
    }),
}); };
var LevelBar = function () {
    var level = Widget.LevelBar({
        bar_mode: "discrete",
        max_value: blocks.bind(),
        visible: bar.bind().as(function (b) { return b !== "hidden"; }),
        value: battery.bind("percent").as(function (p) { return (p / 100) * blocks.value; }),
    });
    var update = function () {
        level.value = (battery.percent / 100) * blocks.value;
        level.css = "block { min-width: ".concat(width.value / blocks.value, "pt; }");
    };
    return level
        .hook(width, update)
        .hook(blocks, update)
        .hook(bar, function () {
        level.vpack = bar.value === "whole" ? "fill" : "center";
        level.hpack = bar.value === "whole" ? "fill" : "center";
    });
};
var WholeButton = function () { return Widget.Overlay({
    vexpand: true,
    child: LevelBar(),
    class_name: "whole",
    pass_through: true,
    overlay: Widget.Box({
        hpack: "center",
        children: [
            Widget.Icon({
                icon: icons_1.default.battery.charging,
                visible: Utils.merge([
                    battery.bind("charging"),
                    battery.bind("charged"),
                ], function (ing, ed) { return ing || ed; }),
            }),
            Widget.Box({
                hpack: "center",
                vpack: "center",
                child: PercentLabel(),
            }),
        ],
    }),
}); };
var Regular = function () { return Widget.Box({
    class_name: "regular",
    children: [
        Indicator(),
        PercentLabel(),
        LevelBar(),
    ],
}); };
exports.default = (function () { return (0, PanelButton_1.default)({
    class_name: "battery-bar",
    hexpand: false,
    on_clicked: function () { percentage.value = !percentage.value; },
    visible: battery.bind("available"),
    child: Widget.Box({
        expand: true,
        visible: battery.bind("available"),
        child: bar.bind().as(function (b) { return b === "whole" ? WholeButton() : Regular(); }),
    }),
    setup: function (self) { return self
        .hook(bar, function (w) { return w.toggleClassName("bar-hidden", bar.value === "hidden"); })
        .hook(battery, function (w) {
        w.toggleClassName("charging", battery.charging || battery.charged);
        w.toggleClassName("low", battery.percent < low.value);
    }); },
}); });
