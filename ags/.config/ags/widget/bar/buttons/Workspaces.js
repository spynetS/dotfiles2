"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var PanelButton_1 = require("../PanelButton");
var options_1 = require("options");
var utils_1 = require("lib/utils");
var hyprland = await Service.import("hyprland");
var workspaces = options_1.default.bar.workspaces.workspaces;
var dispatch = function (arg) {
    (0, utils_1.sh)("hyprctl dispatch workspace ".concat(arg));
};
var Workspaces = function (ws) { return Widget.Box({
    children: (0, utils_1.range)(ws || 20).map(function (i) { return Widget.Label({
        attribute: i,
        vpack: "center",
        label: "".concat(i),
        setup: function (self) { return self.hook(hyprland, function () {
            var _a;
            self.toggleClassName("active", hyprland.active.workspace.id === i);
            self.toggleClassName("occupied", (((_a = hyprland.getWorkspace(i)) === null || _a === void 0 ? void 0 : _a.windows) || 0) > 0);
        }); },
    }); }),
    setup: function (box) {
        if (ws === 0) {
            box.hook(hyprland.active.workspace, function () { return box.children.map(function (btn) {
                btn.visible = hyprland.workspaces.some(function (ws) { return ws.id === btn.attribute; });
            }); });
        }
    },
}); };
exports.default = (function () { return (0, PanelButton_1.default)({
    window: "overview",
    class_name: "workspaces",
    on_scroll_up: function () { return dispatch("m+1"); },
    on_scroll_down: function () { return dispatch("m-1"); },
    on_clicked: function () { return App.toggleWindow("overview"); },
    child: workspaces.bind().as(Workspaces),
}); });
