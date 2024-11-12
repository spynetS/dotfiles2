"use strict";
var __assign = (this && this.__assign) || function () {
    __assign = Object.assign || function(t) {
        for (var s, i = 1, n = arguments.length; i < n; i++) {
            s = arguments[i];
            for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p))
                t[p] = s[p];
        }
        return t;
    };
    return __assign.apply(this, arguments);
};
var __rest = (this && this.__rest) || function (s, e) {
    var t = {};
    for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
        t[p] = s[p];
    if (s != null && typeof Object.getOwnPropertySymbols === "function")
        for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
            if (e.indexOf(p[i]) < 0 && Object.prototype.propertyIsEnumerable.call(s, p[i]))
                t[p[i]] = s[p[i]];
        }
    return t;
};
Object.defineProperty(exports, "__esModule", { value: true });
var options_1 = require("options");
exports.default = (function (_a) {
    var _b = _a.window, window = _b === void 0 ? "" : _b, flat = _a.flat, child = _a.child, setup = _a.setup, rest = __rest(_a, ["window", "flat", "child", "setup"]);
    return Widget.Button(__assign({ child: Widget.Box({ child: child }), setup: function (self) {
            var open = false;
            self.toggleClassName("panel-button");
            self.toggleClassName(window);
            self.hook(options_1.default.bar.flatButtons, function () {
                self.toggleClassName("flat", flat !== null && flat !== void 0 ? flat : options_1.default.bar.flatButtons.value);
            });
            self.hook(App, function (_, win, visible) {
                if (win !== window)
                    return;
                if (open && !visible) {
                    open = false;
                    self.toggleClassName("active", false);
                }
                if (visible) {
                    open = true;
                    self.toggleClassName("active");
                }
            });
            if (setup)
                setup(self);
        } }, rest));
});
