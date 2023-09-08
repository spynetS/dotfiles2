const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#020304", /* black   */
  [1] = "#518CDC", /* red     */
  [2] = "#5494E4", /* green   */
  [3] = "#659FE1", /* yellow  */
  [4] = "#6FB0F0", /* blue    */
  [5] = "#7CBDF4", /* magenta */
  [6] = "#88B6E3", /* cyan    */
  [7] = "#bfc0c0", /* white   */

  /* 8 bright colors */
  [8]  = "#414242",  /* black   */
  [9]  = "#518CDC",  /* red     */
  [10] = "#5494E4", /* green   */
  [11] = "#659FE1", /* yellow  */
  [12] = "#6FB0F0", /* blue    */
  [13] = "#7CBDF4", /* magenta */
  [14] = "#88B6E3", /* cyan    */
  [15] = "#bfc0c0", /* white   */

  /* special colors */
  [256] = "#020304", /* background */
  [257] = "#bfc0c0", /* foreground */
  [258] = "#bfc0c0",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
