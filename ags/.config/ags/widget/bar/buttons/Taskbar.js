"use strict";
var __spreadArray = (this && this.__spreadArray) || function (to, from, pack) {
    if (pack || arguments.length === 2) for (var i = 0, l = from.length, ar; i < l; i++) {
        if (ar || !(i in from)) {
            if (!ar) ar = Array.prototype.slice.call(from, 0, i);
            ar[i] = from[i];
        }
    }
    return to.concat(ar || Array.prototype.slice.call(from));
};
Object.defineProperty(exports, "__esModule", { value: true });
var utils_1 = require("lib/utils");
var icons_1 = require("lib/icons");
var options_1 = require("options");
var PanelButton_1 = require("../PanelButton");
var hyprland = await Service.import("hyprland");
var apps = await Service.import("applications");
var _a = options_1.default.bar.taskbar, monochrome = _a.monochrome, exclusive = _a.exclusive, iconSize = _a.iconSize;
var position = options_1.default.bar.position;
var focus = function (address) { return hyprland.messageAsync("dispatch focuswindow address:".concat(address)); };
var DummyItem = function (address) { return Widget.Box({
    attribute: { address: address },
    visible: false,
}); };
var AppItem = function (address) {
    var client = hyprland.getClient(address);
    if (!client || client.class === "")
        return DummyItem(address);
    var app = apps.list.find(function (app) { return app.match(client.class); });
    var btn = (0, PanelButton_1.default)({
        class_name: "panel-button",
        tooltip_text: Utils.watch(client.title, hyprland, function () { var _a; return ((_a = hyprland.getClient(address)) === null || _a === void 0 ? void 0 : _a.title) || ""; }),
        on_primary_click: function () { return focus(address); },
        on_middle_click: function () { return app && (0, utils_1.launchApp)(app); },
        child: Widget.Icon({
            size: iconSize.bind(),
            icon: monochrome.bind().as(function (m) { return (0, utils_1.icon)(((app === null || app === void 0 ? void 0 : app.icon_name) || client.class) + (m ? "-symbolic" : ""), icons_1.default.fallback.executable + (m ? "-symbolic" : "")); }),
        }),
    });
    return Widget.Box({
        attribute: { address: address },
        visible: Utils.watch(true, [exclusive, hyprland], function () {
            return exclusive.value
                ? hyprland.active.workspace.id === client.workspace.id
                : true;
        }),
    }, Widget.Overlay({
        child: btn,
        pass_through: true,
        overlay: Widget.Box({
            className: "indicator",
            hpack: "center",
            vpack: position.bind().as(function (p) { return p === "top" ? "start" : "end"; }),
            setup: function (w) { return w.hook(hyprland, function () {
                w.toggleClassName("active", hyprland.active.client.address === address);
            }); },
        }),
    }));
};
function sortItems(arr) {
    return arr.sort(function (_a, _b) {
        var a = _a.attribute;
        var b = _b.attribute;
        var aclient = hyprland.getClient(a.address);
        var bclient = hyprland.getClient(b.address);
        return aclient.workspace.id - bclient.workspace.id;
    });
}
exports.default = (function () { return Widget.Box({
    class_name: "taskbar",
    children: sortItems(hyprland.clients.map(function (c) { return AppItem(c.address); })),
    setup: function (w) { return w
        .hook(hyprland, function (w, address) {
        if (typeof address === "string")
            w.children = w.children.filter(function (ch) { return ch.attribute.address !== address; });
    }, "client-removed")
        .hook(hyprland, function (w, address) {
        if (typeof address === "string")
            w.children = sortItems(__spreadArray(__spreadArray([], w.children, true), [AppItem(address)], false));
    }, "client-added")
        .hook(hyprland, function (w, event) {
        if (event === "movewindow")
            w.children = sortItems(w.children);
    }, "event"); },
}); });
