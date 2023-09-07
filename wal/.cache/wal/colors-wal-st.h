const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#000203", /* black   */
  [1] = "#6C8A5D", /* red     */
  [2] = "#7F9C6F", /* green   */
  [3] = "#699494", /* yellow  */
  [4] = "#58B9C7", /* blue    */
  [5] = "#93B3AB", /* magenta */
  [6] = "#AEC8B5", /* cyan    */
  [7] = "#bfbfc0", /* white   */

  /* 8 bright colors */
  [8]  = "#3f4142",  /* black   */
  [9]  = "#6C8A5D",  /* red     */
  [10] = "#7F9C6F", /* green   */
  [11] = "#699494", /* yellow  */
  [12] = "#58B9C7", /* blue    */
  [13] = "#93B3AB", /* magenta */
  [14] = "#AEC8B5", /* cyan    */
  [15] = "#bfbfc0", /* white   */

  /* special colors */
  [256] = "#000203", /* background */
  [257] = "#bfbfc0", /* foreground */
  [258] = "#bfbfc0",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
