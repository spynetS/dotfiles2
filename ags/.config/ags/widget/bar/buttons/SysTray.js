"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var PanelButton_1 = require("../PanelButton");
var _1 = require("gi://Gdk");
var options_1 = require("options");
var systemtray = await Service.import("systemtray");
var ignore = options_1.default.bar.systray.ignore;
var SysTrayItem = function (item) { return (0, PanelButton_1.default)({
    class_name: "tray-item",
    child: Widget.Icon({ icon: item.bind("icon") }),
    tooltip_markup: item.bind("tooltip_markup"),
    setup: function (self) {
        var menu = item.menu;
        if (!menu)
            return;
        var id = menu.connect("popped-up", function () {
            self.toggleClassName("active");
            menu.connect("notify::visible", function () {
                self.toggleClassName("active", menu.visible);
            });
            menu.disconnect(id);
        });
        self.connect("destroy", function () { return menu.disconnect(id); });
    },
    on_primary_click: function (btn) {
        var _a;
        return (_a = item.menu) === null || _a === void 0 ? void 0 : _a.popup_at_widget(btn, _1.default.Gravity.SOUTH, _1.default.Gravity.NORTH, null);
    },
    on_secondary_click: function (btn) {
        var _a;
        return (_a = item.menu) === null || _a === void 0 ? void 0 : _a.popup_at_widget(btn, _1.default.Gravity.SOUTH, _1.default.Gravity.NORTH, null);
    },
}); };
exports.default = (function () { return Widget.Box()
    .bind("children", systemtray, "items", function (i) { return i
    .filter(function (_a) {
    var id = _a.id;
    return !ignore.value.includes(id);
})
    .map(SysTrayItem); }); });
