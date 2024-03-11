static const char norm_fg[] = "#c1c1c2";
static const char norm_bg[] = "#08090b";
static const char norm_border[] = "#454648";

static const char sel_fg[] = "#c1c1c2";
static const char sel_bg[] = "#7A9BC3";
static const char sel_border[] = "#c1c1c2";

static const char urg_fg[] = "#c1c1c2";
static const char urg_bg[] = "#7699B1";
static const char urg_border[] = "#7699B1";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
