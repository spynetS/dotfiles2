"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var PanelButton_1 = require("../PanelButton");
var icons_1 = require("lib/icons");
var asusctl_1 = require("service/asusctl");
var notifications = await Service.import("notifications");
var bluetooth = await Service.import("bluetooth");
var audio = await Service.import("audio");
var network = await Service.import("network");
var powerprof = await Service.import("powerprofiles");
var ProfileIndicator = function () {
    var visible = asusctl_1.default.available
        ? asusctl_1.default.bind("profile").as(function (p) { return p !== "Balanced"; })
        : powerprof.bind("active_profile").as(function (p) { return p !== "balanced"; });
    var icon = asusctl_1.default.available
        ? asusctl_1.default.bind("profile").as(function (p) { return icons_1.default.asusctl.profile[p]; })
        : powerprof.bind("active_profile").as(function (p) { return icons_1.default.powerprofile[p]; });
    return Widget.Icon({ visible: visible, icon: icon });
};
var ModeIndicator = function () {
    if (!asusctl_1.default.available) {
        return Widget.Icon({
            setup: function (self) {
                Utils.idle(function () { return self.visible = false; });
            },
        });
    }
    return Widget.Icon({
        visible: asusctl_1.default.bind("mode").as(function (m) { return m !== "Hybrid"; }),
        icon: asusctl_1.default.bind("mode").as(function (m) { return icons_1.default.asusctl.mode[m]; }),
    });
};
var MicrophoneIndicator = function () { return Widget.Icon()
    .hook(audio, function (self) { return self.visible =
    audio.recorders.length > 0
        || audio.microphone.is_muted
        || false; })
    .hook(audio.microphone, function (self) {
    var _a;
    var vol = audio.microphone.is_muted ? 0 : audio.microphone.volume;
    var _b = icons_1.default.audio.mic, muted = _b.muted, low = _b.low, medium = _b.medium, high = _b.high;
    var cons = [[67, high], [34, medium], [1, low], [0, muted]];
    self.icon = ((_a = cons.find(function (_a) {
        var n = _a[0];
        return n <= vol * 100;
    })) === null || _a === void 0 ? void 0 : _a[1]) || "";
}); };
var DNDIndicator = function () { return Widget.Icon({
    visible: notifications.bind("dnd"),
    icon: icons_1.default.notifications.silent,
}); };
var BluetoothIndicator = function () { return Widget.Overlay({
    class_name: "bluetooth",
    passThrough: true,
    visible: bluetooth.bind("enabled"),
    child: Widget.Icon({
        icon: icons_1.default.bluetooth.enabled,
    }),
    overlay: Widget.Label({
        hpack: "end",
        vpack: "start",
        label: bluetooth.bind("connected_devices").as(function (c) { return "".concat(c.length); }),
        visible: bluetooth.bind("connected_devices").as(function (c) { return c.length > 0; }),
    }),
}); };
var NetworkIndicator = function () { return Widget.Icon().hook(network, function (self) {
    var _a;
    var icon = (_a = network[network.primary || "wifi"]) === null || _a === void 0 ? void 0 : _a.icon_name;
    self.icon = icon || "";
    self.visible = !!icon;
}); };
var AudioIndicator = function () { return Widget.Icon()
    .hook(audio.speaker, function (self) {
    var _a;
    var vol = audio.speaker.is_muted ? 0 : audio.speaker.volume;
    var _b = icons_1.default.audio.volume, muted = _b.muted, low = _b.low, medium = _b.medium, high = _b.high, overamplified = _b.overamplified;
    var cons = [[101, overamplified], [67, high], [34, medium], [1, low], [0, muted]];
    self.icon = ((_a = cons.find(function (_a) {
        var n = _a[0];
        return n <= vol * 100;
    })) === null || _a === void 0 ? void 0 : _a[1]) || "";
}); };
exports.default = (function () { return (0, PanelButton_1.default)({
    window: "quicksettings",
    on_clicked: function () { return App.toggleWindow("quicksettings"); },
    on_scroll_up: function () { return audio.speaker.volume += 0.02; },
    on_scroll_down: function () { return audio.speaker.volume -= 0.02; },
    child: Widget.Box([
        ProfileIndicator(),
        ModeIndicator(),
        DNDIndicator(),
        BluetoothIndicator(),
        NetworkIndicator(),
        AudioIndicator(),
        MicrophoneIndicator(),
    ]),
}); });
