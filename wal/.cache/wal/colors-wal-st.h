const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#020305", /* black   */
  [1] = "#737985", /* red     */
  [2] = "#7C828E", /* green   */
  [3] = "#9AA0AC", /* yellow  */
  [4] = "#B4BAC6", /* blue    */
  [5] = "#BDC3CF", /* magenta */
  [6] = "#C7CDD9", /* cyan    */
  [7] = "#bfc0c0", /* white   */

  /* 8 bright colors */
  [8]  = "#414243",  /* black   */
  [9]  = "#737985",  /* red     */
  [10] = "#7C828E", /* green   */
  [11] = "#9AA0AC", /* yellow  */
  [12] = "#B4BAC6", /* blue    */
  [13] = "#BDC3CF", /* magenta */
  [14] = "#C7CDD9", /* cyan    */
  [15] = "#bfc0c0", /* white   */

  /* special colors */
  [256] = "#020305", /* background */
  [257] = "#bfc0c0", /* foreground */
  [258] = "#bfc0c0",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
