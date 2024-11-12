"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var icons_1 = require("lib/icons");
var PanelButton_1 = require("../PanelButton");
var options_1 = require("options");
var _a = options_1.default.bar.powermenu, monochrome = _a.monochrome, action = _a.action;
exports.default = (function () { return (0, PanelButton_1.default)({
    window: "powermenu",
    on_clicked: action.bind(),
    child: Widget.Icon(icons_1.default.powermenu.shutdown),
    setup: function (self) { return self.hook(monochrome, function () {
        self.toggleClassName("colored", !monochrome.value);
        self.toggleClassName("box");
    }); },
}); });
