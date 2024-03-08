const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#08090b", /* black   */
  [1] = "#7699B1", /* red     */
  [2] = "#7A9BC3", /* green   */
  [3] = "#A18480", /* yellow  */
  [4] = "#859AAA", /* blue    */
  [5] = "#9C9AA3", /* magenta */
  [6] = "#CDB2A9", /* cyan    */
  [7] = "#c1c1c2", /* white   */

  /* 8 bright colors */
  [8]  = "#454648",  /* black   */
  [9]  = "#7699B1",  /* red     */
  [10] = "#7A9BC3", /* green   */
  [11] = "#A18480", /* yellow  */
  [12] = "#859AAA", /* blue    */
  [13] = "#9C9AA3", /* magenta */
  [14] = "#CDB2A9", /* cyan    */
  [15] = "#c1c1c2", /* white   */

  /* special colors */
  [256] = "#08090b", /* background */
  [257] = "#c1c1c2", /* foreground */
  [258] = "#c1c1c2",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
