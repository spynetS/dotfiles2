"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var variables_1 = require("lib/variables");
var PanelButton_1 = require("../PanelButton");
var options_1 = require("options");
var _a = options_1.default.bar.date, format = _a.format, action = _a.action;
var time = Utils.derive([variables_1.clock, format], function (c, f) { return c.format(f) || ""; });
exports.default = (function () { return (0, PanelButton_1.default)({
    window: "datemenu",
    on_clicked: action.bind(),
    child: Widget.Label({
        justification: "center",
        label: time.bind(),
    }),
}); });
