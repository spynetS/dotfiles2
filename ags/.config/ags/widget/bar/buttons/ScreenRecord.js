"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var PanelButton_1 = require("../PanelButton");
var screenrecord_1 = require("service/screenrecord");
var icons_1 = require("lib/icons");
exports.default = (function () { return (0, PanelButton_1.default)({
    class_name: "recorder",
    on_clicked: function () { return screenrecord_1.default.stop(); },
    visible: screenrecord_1.default.bind("recording"),
    child: Widget.Box({
        children: [
            Widget.Icon(icons_1.default.recorder.recording),
            Widget.Label({
                label: screenrecord_1.default.bind("timer").as(function (time) {
                    var sec = time % 60;
                    var min = Math.floor(time / 60);
                    return "".concat(min, ":").concat(sec < 10 ? "0" + sec : sec);
                }),
            }),
        ],
    }),
}); });
