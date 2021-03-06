ImageJ macros
====================
Szu-Chin Fu

Some simple macros for ImageJ/FIJI that I used for quantitation of nuclear export activity in cells.
* [F1] Generating max intensity projection for z-stacks (total: 4 slices). 
  * Input: the bottom stack.
* [F2] Generating average intensity projection for z-stacks (total: 4 slices). 
  * Input: the bottom stack.
* [F3] Generating nuclear ROI(s) for DAPI/Hoechst stained nuclei images using [Nuclei Watershed Separation](http://imagej.net/Nuclei_Watershed_Separation). 
* [F4] Generating cytoplasmic ring ROI(s) with a thickness of 150nm. 

Steps:
1. Load you multichannel images *e.g.* YFP and Hoechest.
2. Select 4 nuclear z-planes spanning the middle of the nucleus.
3. Collapse into a single Hoechest (by average intensity projection using [F1]) and YFP image (by average intensity projection using [F2]).
4. Generate nuclear ROI(s) for DAPI/Hoechst stained nuclei images using [F3].
5. Remove unwanted nuclear ROIs *e.g.* untransfected cells.
6. Generate cytoplasmic "ring" ROI(s) using [F4].

![fig_1](https://user-images.githubusercontent.com/10090315/33915255-fd1e5ed2-df67-11e7-9176-97d2be34d699.jpg)

7. Measure nuclear and cytoplasmic YFP intensity.
8. Correct for background noise by subtracting the intensity in a nearby region without any cell.
