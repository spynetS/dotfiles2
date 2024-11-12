"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var icons_1 = require("lib/icons");
var PanelButton_1 = require("../PanelButton");
var options_1 = require("options");
var n = await Service.import("notifications");
var notifs = n.bind("notifications");
var action = options_1.default.bar.messages.action.bind();
exports.default = (function () { return (0, PanelButton_1.default)({
    class_name: "messages",
    on_clicked: action,
    visible: notifs.as(function (n) { return n.length > 0; }),
    child: Widget.Box([
        Widget.Icon(icons_1.default.notifications.message),
    ]),
}); });
