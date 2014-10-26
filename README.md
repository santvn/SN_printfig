SN_printfig
===========

SN_PRINTFIG saves a specified figure as an image in MATLAB

   SN_printfig(FILENAME) saves a specified figure as an JPG image with a
    specified FILENAME 
   SN_printfig(FILENAME,'OPTIONS',OPT_VAL) allows users to add more advance
   options
   The OPTIONS are:
   
        'QUALITY':  File quality of a jpeg image ranging 0-100 (integer only)
        'RESOLUTION' or 'DPI': print resolution in the unit of Dots Per Inch
            (no negative integer only)
        'PRINTSCREEN':  TRUE or FALSE, if TRUE (by default), the figure will
            be saved as displayed on the screen, which is very useful for 
            those who are used to doing that
        'FIGURE':   specific figure handle to save instead of the current
            figure handle
        'FILETYPE': A string that can specify the file type you would like to
            save. Below are the file types supported 
        'SIZE': 2x1 vector that specifies that size in inches 
                [WIDTH  HEIGHT]
        'WIDTH': width of the image in inches (height will be autoset)
        'HEIGHT': height of the image in inches (width will be autoset)
 
        
        eps, epsc       Encapsulated PostScript - Color (vector)
        epsmono         Encapsulated PostScript - Black & White (vector)
        eps2, epsc2     Encapsulated PostScript Level 2 - Color (vector)
        epsmono2        Encapsulated PostScript Level 2 - Black & White (vector)
        pdf             Portable Document Format File (vector)
        jpg, jpeg       JPEG (bitmap)
        png             PNG (bitmap)
        ppm             Portable Pixmap Image File (bitmap)
        ppmraw          Portable Pixmap Image File - Raw (bitmap)
        emf, meta       Enhanced Windows Metafile (vector) 
        bmp             Bitmap Image File (bitmap)
        bmp16m          Bitmap Image File - 24-bit (16m colors) (bitmap)
        bmp256          Bitmap Image File - 8-bit (256 colors) (bitmap)
        bmpmono         Bitmap Image File - monochrome (bitmap)
        hdf             Hierarchical Data Format File (bitmap)
        tiff            Tagged Image File Format - compressed (bitmap)
        tiffn           Tagged Image File Format - not compressed (bitmap)
        pgm             Portable Gray Map Image (bitmap)
        pgmraw          Portable Gray Map Image - Raw (bitmap)
        svg             Scalable Vector Graphics File (vector) 
        pcx, pcx24b     Paintbrush Bitmap Image File - 24-bit colors (bitmap)
        pcx16           Paintbrush Bitmap Image File - 16 colors (bitmap)
        pcx256          Paintbrush Bitmap Image File - 8-bit colors (bitmap)
        pcxmono         Paintbrush Bitmap Image File - monochrome (bitmap)
        pbm             Portable Bitmap Image (bitmap)
        pbmraw          Portable Bitmap Image - Raw (bitmap)
        ill, ai         Adobe Illustrator Image (vector)
        ps, psc         Poscript File - Color (vector)
        psmono          Poscript File - Black & White (vector)
        ps2, psc2       Poscript File Level 2 - Color (vector)
        psmono2         Poscript File Level 2 - Black & White (vector)
 
 
  Here are other options you can use without a value of each option
    -noui      % Do not print UI control objects
    -painters  % Rendering for printing to be done in Painters mode
    -zbuffer   % Rendering for printing to be done in Z-buffer mode%
    -opengl    % Rendering for printing to be done in OpenGL mode
 
  See also print, saveas, imwrite
 
  Created by San Nguyen 2012 05 09
  
  Updated by San Nguyen 2014 10 21
