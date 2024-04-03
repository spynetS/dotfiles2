static const char norm_fg[] = "#bfc0c0";
static const char norm_bg[] = "#020305";
static const char norm_border[] = "#414243";

static const char sel_fg[] = "#bfc0c0";
static const char sel_bg[] = "#7C828E";
static const char sel_border[] = "#bfc0c0";

static const char urg_fg[] = "#bfc0c0";
static const char urg_bg[] = "#737985";
static const char urg_border[] = "#737985";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
