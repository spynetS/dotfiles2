"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var PanelButton_1 = require("../PanelButton");
var colorpicker_1 = require("service/colorpicker");
var _1 = require("gi://Gdk");
var css = function (color) { return "\n* {\n    background-color: ".concat(color, ";\n    color: transparent;\n}\n*:hover {\n    color: white;\n    text-shadow: 2px 2px 3px rgba(0,0,0,.8);\n}"); };
exports.default = (function () {
    var menu = Widget.Menu({
        class_name: "colorpicker",
        children: colorpicker_1.default.bind("colors").as(function (c) { return c.map(function (color) { return Widget.MenuItem({
            child: Widget.Label(color),
            css: css(color),
            on_activate: function () { return colorpicker_1.default.wlCopy(color); },
        }); }); }),
    });
    return (0, PanelButton_1.default)({
        class_name: "color-picker",
        child: Widget.Icon("color-select-symbolic"),
        tooltip_text: colorpicker_1.default.bind("colors").as(function (v) { return "".concat(v.length, " colors"); }),
        on_clicked: colorpicker_1.default.pick,
        on_secondary_click: function (self) {
            if (colorpicker_1.default.colors.length === 0)
                return;
            menu.popup_at_widget(self, _1.default.Gravity.SOUTH, _1.default.Gravity.NORTH, null);
        },
    });
});
