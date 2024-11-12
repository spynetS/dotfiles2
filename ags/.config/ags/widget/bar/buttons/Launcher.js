"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var PanelButton_1 = require("../PanelButton");
var options_1 = require("options");
var nix_1 = require("service/nix");
var _a = options_1.default.bar.launcher, icon = _a.icon, label = _a.label, action = _a.action;
function Spinner() {
    var child = Widget.Icon({
        icon: icon.icon.bind(),
        class_name: Utils.merge([
            icon.colored.bind(),
            nix_1.default.bind("ready"),
        ], function (c, r) { return "".concat(c ? "colored" : "", " ").concat(r ? "" : "spinning"); }),
        css: "\n            @keyframes spin {\n                to { -gtk-icon-transform: rotate(1turn); }\n            }\n\n            image.spinning {\n                animation-name: spin;\n                animation-duration: 1s;\n                animation-timing-function: linear;\n                animation-iteration-count: infinite;\n            }\n        ",
    });
    return Widget.Revealer({
        transition: "slide_left",
        child: child,
        reveal_child: Utils.merge([
            icon.icon.bind(),
            nix_1.default.bind("ready"),
        ], function (i, r) { return Boolean(i || r); }),
    });
}
exports.default = (function () { return (0, PanelButton_1.default)({
    window: "launcher",
    on_clicked: action.bind(),
    child: Widget.Box([
        Spinner(),
        Widget.Label({
            class_name: label.colored.bind().as(function (c) { return c ? "colored" : ""; }),
            visible: label.label.bind().as(function (v) { return !!v; }),
            label: label.label.bind(),
        }),
    ]),
}); });
