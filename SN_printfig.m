function SN_printfig(filename,varargin)
%SN_PRINTFIG saves a specified figure as an image
%
%  SN_PRINTFIG(FILENAME) saves a specified figure as an JPG image with a
%   specified FILENAME 
%  SN_PRINTFIG(FILENAME,'OPTIONS',OPT_VAL) allows users to add more advance
%  options
%  The OPTIONS are:
%       'QUALITY':  File quality of a jpeg image ranging 0-100 (integer only)
%       'RESOLUTION' or 'DPI': print resolution in the unit of Dots Per Inch
%           (no negative integer only)
%       'PRINTSCREEN':  TRUE or FALSE, if TRUE (by default), the figure will
%           be saved as displayed on the screen, which is very useful for 
%           those who are used to doing that
%       'FIGURE':   specific figure handle to save instead of the current
%           figure handle
%       'FILETYPE': A string that can specify the file type you would like to
%           save. Below are the file types supported 
%       'SIZE': 2x1 vector that specifies that size in inches 
%               [WIDTH  HEIGHT]
%       'WIDTH': width of the image in inches (height will be autoset)
%       'HEIGHT': height of the image in inches (width will be autoset)
%       'FONTSIZE': the specific fontsize for the figure upon saving
%       'FONTSIZERATIO': font size ratio upon saving the figure, the
%           FONTSIZERATIO can specified in percentage string like '125%' or
%           just numerical values like 1.25
%       'NOFOOTNOTE': set to have no foot notes generated
%           footnote is generated to indicate the time and source of the
%           figure
%       'NOSOURCE': set to not indicate source (if figure is generated from
%           an m-file
%       'NOTIMESTAMP': set to not indicate a timestamp of a figure being saved
%
%       eps, epsc       Encapsulated PostScript - Color (vector)
%       epsmono         Encapsulated PostScript - Black & White (vector)
%       eps2, epsc2     Encapsulated PostScript Level 2 - Color (vector)
%       epsmono2        Encapsulated PostScript Level 2 - Black & White (vector)
%       pdf             Portable Document Format File (vector)
%       jpg, jpeg       JPEG (bitmap)
%       png             PNG (bitmap)
%       ppm             Portable Pixmap Image File (bitmap)
%       ppmraw          Portable Pixmap Image File - Raw (bitmap)
%       emf, meta       Enhanced Windows Metafile (vector) 
%       bmp             Bitmap Image File (bitmap)
%       bmp16m          Bitmap Image File - 24-bit (16m colors) (bitmap)
%       bmp256          Bitmap Image File - 8-bit (256 colors) (bitmap)
%       bmpmono         Bitmap Image File - monochrome (bitmap)
%       hdf             Hierarchical Data Format File (bitmap)
%       tiff            Tagged Image File Format - compressed (bitmap)
%       tiffn           Tagged Image File Format - not compressed (bitmap)
%       pgm             Portable Gray Map Image (bitmap)
%       pgmraw          Portable Gray Map Image - Raw (bitmap)
%       svg             Scalable Vector Graphics File (vector) 
%       pcx, pcx24b     Paintbrush Bitmap Image File - 24-bit colors (bitmap)
%       pcx16           Paintbrush Bitmap Image File - 16 colors (bitmap)
%       pcx256          Paintbrush Bitmap Image File - 8-bit colors (bitmap)
%       pcxmono         Paintbrush Bitmap Image File - monochrome (bitmap)
%       pbm             Portable Bitmap Image (bitmap)
%       pbmraw          Portable Bitmap Image - Raw (bitmap)
%       ill, ai         Adobe Illustrator Image (vector)
%       ps, psc         Poscript File - Color (vector)
%       psmono          Poscript File - Black & White (vector)
%       ps2, psc2       Poscript File Level 2 - Color (vector)
%       psmono2         Poscript File Level 2 - Black & White (vector)
%
%
% Here are other options you can use without a value of each option
%   -noui      % Do not print UI control objects
%   -painters  % Rendering for printing to be done in Painters mode
%   -zbuffer   % Rendering for printing to be done in Z-buffer mode%
%   -opengl    % Rendering for printing to be done in OpenGL mode
%
% See also PRINT, SAVEAS, IMWRITE
%
% Created by San Nguyen 2012 05 09
% Updated by San Nguyen 2014 10 26
%

persistent argsNameToCheck;
if isempty(argsNameToCheck);
    argsNameToCheck = {'FileType','Quality','DPI','Resolution',...
        'PrintScreen','Figure','Percent','Size','Units',...
        'Height','Width','FontSize','FontSizeRatio',...
        'NoFootNote','NoSource','NoTimeStamp'};
end

persistent fileExtensions;
if isempty(fileExtensions)
    fileExtensions = {'eps','pdf','jpg','png','ppm','emf','bmp','hdf',...
        'tiff','pgm','svg','pcx','pbm','ai', 'ps'};
                       %1    2      3     4     5     6     7     8 
          %9     10    11   12    13    14    15
end

persistent fileTypes;
if isempty(fileTypes)
    fileTypes = {...
        'eps',      '-depsc',        1;... % Encapsulated PostScript - Color (vector)
        'epsc',     '-depsc',        1;... % Encapsulated PostScript - Color (vector)
        'epsmono',  '-deps',         1;... % Encapsulated PostScript - Black & White (vector)
        'eps2',     '-depsc2',       1;... % Encapsulated PostScript Level 2 - Color (vector)
        'epsc2',    '-depsc2',       1;... % Encapsulated PostScript Level 2 - Color (vector)
        'epsmono2', '-deps2',        1;... % Encapsulated PostScript Level 2 - Black & White (vector)
        'pdf',      '-dpdf',         2;... % Portable Document Format File (vector)
        'jpg',      '-djpeg',        3;... % JPEG (bitmap
        'jpeg',     '-djpeg',        3;... % JPEG (bitmap)
        'png',      '-dpng',         4;... % PNG (bitmap)
        'ppm',      '-dppm',         5;... % Portable Pixmap Image File (bitmap)
        'ppmraw',   '-ppmraw',       5;... % Portable Pixmap Image File - Raw (bitmap)
        'emf',      '-dmeta',        6;... % Enhanced Windows Metafile (vector) 
        'meta',     '-dmeta',        6;... % Enhanced Windows Metafile (vector) 
        'bmp',      '-dbmp',         7;... % Bitmap Image File (bitmap)
        'bmp16m',   '-dbmp16m',      7;... % Bitmap Image File - 24-bit (16m colors) (bitmap)
        'bmp256',   '-dbmp256',      7;... % Bitmap Image File - 8-bit (256 colors) (bitmap)
        'bmpmono',  '-dbmpmono',     7;... % Bitmap Image File - monochrome (bitmap)
        'hdf',      '-dhdf',         8;... % Hierarchical Data Format File (bitmap)
        'tiff',     '-dtiff',        9;... % Tagged Image File Format - compressed (bitmap)
        'tiffn',    '-dtiffn',       9;... % Tagged Image File Format - not compressed (bitmap)
        'pgm',      '-dpgm',        10;... % Portable Gray Map Image (bitmap)
        'pgmraw',   '-dpgmraw',     10;... % Portable Gray Map Image - Raw (bitmap)
        'svg',      '-dsvg',        11;... % Scalable Vector Graphics File (vector) 
        'pcx',      '-dpcx24b',     12;... % Paintbrush Bitmap Image File - 24-bit colors (bitmap)
        'pcx16',    '-dpcx16',      12;... % Paintbrush Bitmap Image File - 16 colors (bitmap)
        'pcx24b',   '-dpcx24b',     12;... % Paintbrush Bitmap Image File - 24-bit colors (bitmap)
        'pcx256',   '-dpcx256',     12;... % Paintbrush Bitmap Image File - 8-bit colors (bitmap)
        'pcxmono',  '-dpcxmono',    12;... % Paintbrush Bitmap Image File - monochrome (bitmap)
        'pbm',      '-dpbm',        13;... % Portable Bitmap Image (bitmap)
        'pbmraw',   '-dpbmraw',     13;... % Portable Bitmap Image - Raw (bitmap)
        'ill',      '-dill',        14;... % Adobe Illustrator Image (vector)
        'ai',       '-dill',        14;... % Adobe Illustrator Image (vector)
        'ps',       '-dpsc',        15;... % Poscript File - Color (vector)
        'psc',      '-dpsc',        15;... % Poscript File - Color (vector)
        'psmono',   '-dps',         15;... % Poscript File - Black & White (vector)
        'ps2',      '-dpsc2',       15;... % Poscript File Level 2 - Color (vector)
        'psc2',     '-dpsc2',       15;... % Poscript File Level 2 - Color (vector)
        'psmono2',  '-dps2',        15;};   % Poscript File Level 2 - Black & White (vector)
end
if isempty(filename) || ~ischar(filename)
    error('MATLAB:SN_printfig:emptyFilename','You are missing a filename...');
end
FileType = '';
FileTypeN = [];
FileTypePrintCmd = '';
Quality = 90;
DPI = 72;
PrintScreen = true;
Figure = gcf;
Percent = 100;
isOtherPrintOptions = false(size(varargin));
PSize = [];
PUnits = 'inches';
Width = [];
Height = [];
FontSizeRatio = 1; % this means 100%
FontSize = NaN;
orgFontSize = NaN;
FootNote = false;
NoSource = false;
NoTimeStamp = false;
SourceAX = NaN;
SourceText = NaN;


index = 1;
n_items = nargin-1;
while (n_items > 0)
    argsMatch = strcmpi(varargin{index},argsNameToCheck);
    i = find(argsMatch,1);
    if isempty(i)
        isOtherPrintOptions(index) = true;
        index = index +1;
        n_items = n_items-1;
        continue;
    end
    
    switch i
        case 1 % filetype
            if n_items == 1
                error('MATLAB:SN_printfig:missingArgs','Missing input arguments');
            end
            FileType = varargin{index+1};
            if isempty(FileType) || ~ischar(FileType)
                error('MATLAB:SN_printfig:emptyFileType','Please check your filetype');
            end            
            FileTypeN = find(strcmpi(FileType,fileTypes(:,1)),1);
            if isempty(FileTypeN)
                error('MATLAB:SN_printfig:wrongFileType','Please check your filetype');
            end
            index = index +2;
            n_items = n_items-2;
        case 2 % quality
            if n_items == 1
                error('MATLAB:SN_printfig:missingArgs','Missing input arguments');
            end
            Quality = ceil(varargin{index+1});

            if (Quality < 1)
                error('MATLAB:SN_printfig:QualInteger',...
                    'Quality value must be an integer greater than zero');
            end
            
            index = index +2;
            n_items = n_items-2;
        case {3,4} % dpi
            if n_items == 1
                error('MATLAB:SN_printfig:missingArgs','Missing input arguments');
            end
            DPI = ceil(varargin{index+1});
            if DPI < 1
                error('MATLAB:SN_printfig:DPIInteger',...
                    'Resolution value (DPI) value must be an integer greater than zero');
            end
            
            index = index +2;
            n_items = n_items-2;
        case 5 % printscreen
            if n_items == 1
                error('MATLAB:SN_printfig:missingArgs','Missing input arguments');
            end
            PrintScreen = varargin{index+1};
            if ~islogical(PrintScreen)
                error('MATLAB:SN_printfig:PrintScreent',...
                    'PrintScreen must be logical');
            end
            
            index = index +2;
            n_items = n_items-2;
        case 6 % figure
            if n_items == 1
                error('MATLAB:SN_printfig:missingArgs','Missing input arguments');
            end
            Figure = varargin{index+1};
            
            % check for a valid figure;
            iptcheckhandle(Figure,{'figure'},'SN_printfig','Figure',index+1)
            
            index = index +2;
            n_items = n_items-2;
        case 7 % percent
            if n_items == 1
                error('MATLAB:SN_printfig:missingArgs','Missing input arguments');
            end
            Percent = varargin{index+1};
            if Percent < 0
                error('MATLAB:SN_printfig:Percent0','Percentage must be greater than zero');
            end
            
            index = index +2;
            n_items = n_items-2;
        case 8 % size
            if n_items == 1
                error('MATLAB:SN_printfig:missingArgs','Missing input arguments');
            end
            PSize = varargin{index+1};
            if (PSize(1) <= 0) || (PSize(2) <= 0)
                error('MATLAB:SN_printfig:PSize','Image size must be greater than zero');
            end
            
            index = index +2;
            n_items = n_items-2;
        case 9 % units
            if n_items == 1
                error('MATLAB:SN_printfig:missingArgs','Missing input arguments');
            end
            PUnits = varargin{index+1};
            if ~ischar(Units);
                error('MATLAB:SN_printfig:Units','Must specify the right units');
            end
            
            if (~strcmp(PUnits,'centimeters')) || (~strcmp(PUnits,'inches')) || (~strcmp(PUnits,'normalized')) || (~strcmp(PUnits,'points'))
                error('MATLAB:SN_printfig:Units','Units are either ''centimeters'', ''inches'', ''normalized'', or ''points''.');
            end
            
            index = index +2;
            n_items = n_items-2;
        case 10 % height
            if n_items == 1
                error('MATLAB:SN_printfig:missingArgs','Missing input arguments');
            end
            Height = varargin{index+1};
            if ~isnumeric(Height) || Height <= 0;
                error('MATLAB:SN_printfig:Height','Height must be numeric and greater than zero');
            end
            
            if isempty(Width)
                scrpos = get(Figure,'Position');
                Width = scrpos(4)/Height*scrpos(3);
            end
            
            PSize = [Width Height];
            
            index = index +2;
            n_items = n_items-2;
        case 11 % width
            if n_items == 1
                error('MATLAB:SN_printfig:missingArgs','Missing input arguments');
            end
            Width = varargin{index+1};
            if ~isnumeric(Width) || Width <= 0;
                error('MATLAB:SN_printfig:Width','Width must be numeric and greater than zero');
            end
            
            if isempty(Height)
                scrpos = get(Figure,'Position');
                Height = scrpos(3)/Width*scrpos(4);
            end
            
            PSize = [Width Height];
            
            index = index +2;
            n_items = n_items-2;
        case 12 % fontsize
            if n_items == 1
                error('MATLAB:SN_printfig:missingArgs','Missing input arguments');
            end
            FontSize = varargin{index+1};
            if ~isnumeric(FontSize) || FontSize <= 0;
                error('MATLAB:SN_printfig:FontSize','FontSize must be numeric and greater than zero');
            end
            if ~isscalar(FontSize)
                error('MATLAB:SN_printfig:FontSize','FontSize must be a scalar value');
            end
            index = index +2;
            n_items = n_items-2;
        case 13 % fontsizeRatio
            if n_items == 1
                error('MATLAB:SN_printfig:missingArgs','Missing input arguments');
            end
            FontSizeRatio = varargin{index+1};
            
            if ischar(FontSizeRatio)
                FontSizeRatio = strtrim(FontSizeRatio);
                if FontSizeRatio(end) ~= '%'
                    error('MATLAB:SN_printfig:FontSizeRatio','FontSizeRatio must be a number or a number string with percent sign');
                end
                
                FontSizeRatio = str2double(FontSizeRatio(1:end-1));
                if isnan(FontSizeRatio)
                    error('MATLAB:SN_printfig:FontSizeRatio','FontSizeRatio must be a number or a number string with percent sign');
                end
                FontSizeRatio = FontSizeRatio/100;
            elseif ~isnumeric(FontSizeRatio) || FontSizeRatio <= 0;
                error('MATLAB:SN_printfig:FontSizeRatio','FontSizeRatio must be numeric and greater than zero');
            elseif ~isscalar(FontSizeRatio)
                error('MATLAB:SN_printfig:FontSizeRatio','FontSizeRatio must be a scalar value');
            end
            index = index +2;
            n_items = n_items-2;
        case 14 % NoFootNote
            FootNote = false;
            index = index +1;
            n_items = n_items-1;  
        case 15 % NoSource
            NoSource = true;
            index = index +1;
            n_items = n_items-1;
        case 16 % NoTimeStamp
            NoTimeStamp = true;
            index = index +1;
            n_items = n_items-1;
    end
end
if ~isnan(FontSize)
    orgFontSize = setFontSize(gcf,FontSize);
    FontSizeRatio = 1;
end

if FontSizeRatio ~= 1
    setFontSizeRatio(gcf,FontSizeRatio);
end

% the next few lines will determine the right filetype to print
FileEnding = find(filename == '.',1,'last');
FileAddExt = true;
if ~isempty(FileEnding)
    FileEnding = filename(FileEnding+1:end);
end
    
% if ~isempty(FileType)
%     FileTypeN = find(strcmpi(FileType,fileTypes{:,1}),1);
% end
if ~isempty(FileTypeN)
    FileExt = fileExtensions{fileTypes{FileTypeN,3}};
    FileTypePrintCmd = fileTypes{FileTypeN,2};
    if strcmpi(FileEnding,fileTypes(FileTypeN,1))
        FileAddExt = false;
    end    
else    
    i = find(strcmpi(FileEnding,fileTypes(:,1)),1);
    if isempty(i)
        FileExt = 'jpg';
%         FileType = 'jpg';
        FileTypeN = 8;
    else
        FileExt = FileEnding;
%         FileType = FileEnding;
        FileTypeN = find(strcmpi(FileEnding,fileTypes(:,1)),1);
        FileAddExt = false;
    end
    FileTypePrintCmd = fileTypes{FileTypeN,2};
end

if FileAddExt
    filename = sprintf('%s.%s',filename,FileExt);
end

if FileTypeN == 8 % specify quality for JPG only
    FileTypePrintCmd = sprintf('%s%02d',FileTypePrintCmd,Quality);
end

DPI = ceil(DPI*Percent/100);
DPIcmd = sprintf('-r%d',DPI);

% this is where we set the proportions of the figure correctly so that the output looks 
% like what's on the screen 
if PrintScreen
    oldscreenunits = get(Figure,'Units');
    oldpaperunits = get(Figure,'PaperUnits');
    oldpaperpos = get(Figure,'PaperPosition');
    oldpapertype = get(Figure,'PaperType');
    oldpaperposmode = get(Figure,'PaperPositionMode');
    oldpapersize = get(Figure,'PaperSize');
    
    set(Figure,'Units','pixels');
    scrpos = get(Figure,'Position');
    newpos = [0 0 scrpos(end-1:end)]/get(0,'ScreenPixelsPerInch');
    set(Figure,'PaperUnits','inches',...
        'PaperPosition',newpos,'PaperSize',newpos(end-1:end))
    writeSource();
%     set(Figure,'renderer','painters');
    drawnow;
    print(Figure,FileTypePrintCmd,filename,DPIcmd,varargin{isOtherPrintOptions});
    set(Figure,'Units',oldscreenunits,...
        'PaperUnits',oldpaperunits,...
        'PaperPosition',oldpaperpos,...
        'PaperPositionMode',oldpaperposmode,...
        'PaperSize',oldpapersize,...
        'PaperType',oldpapertype);
    if isobject(SourceText)
        delete(SourceText);
    end
    if isobject(SourceAX) || ~isempty(axescheck(SourceAX))
        delete(SourceAX)
    end
    if ~isnan(orgFontSize)
        setFontSize(gcf,orgFontSize);
    end
    if FontSizeRatio ~= 1
        setFontSizeRatio(gcf,1/FontSizeRatio);
    end
    return;
elseif ~empty(PSize)
    oldscreenunits = get(Figure,'Units');
    oldpaperunits = get(Figure,'PaperUnits');
    oldpaperpos = get(Figure,'PaperPosition');
    oldpapertype = get(Figure,'PaperType');
    oldpaperposmode = get(Figure,'PaperPositionMode');
    oldpapersize = get(Figure,'PaperSize');
    
    set(Figure,'Units','pixels');
    newpos = [0 0 PSize(1) PSize(2)];
    set(Figure,'PaperUnits',PUnits,...
        'PaperPosition',newpos,'PaperSize',[Psize(1) Psize(2)]);
    writeSource();
%     set(Figure,'rensderer','painters');
    drawnow;
    print(Figure,FileTypePrintCmd,filename,DPIcmd,varargin{isOtherPrintOptions});
    set(Figure,'Units',oldscreenunits,...
        'PaperUnits',oldpaperunits,...
        'PaperPosition',oldpaperpos,...
        'PaperPositionMode',oldpaperposmode,...
        'PaperSize',oldpapersize,...
        'PaperType',oldpapertype);
    if isobject(SourceText)
        delete(SourceText);
    end
    if isobject(SourceAX) || ~isempty(axescheck(SourceAX))
        delete(SourceAX)
    end
    if ~isnan(orgFontSize)
        setFontSize(gcf,orgFontSize);
    end
    if FontSizeRatio ~= 1
        setFontSizeRatio(gcf,1/FontSizeRatio);
    end
    return;
end
writeSource();
% set(Figure,'renderer','painters');
print(Figure,FileTypePrintCmd,filename,DPIcmd,varargin{isOtherPrintOptions});
if isobject(SourceText)
    delete(SourceText);
end
if isobject(SourceAX) || ~isempty(axescheck(SourceAX))
    delete(SourceAX)
end
if ~isnan(orgFontSize)
    setFontSize(gcf,orgFontSize);
end
if FontSizeRatio ~= 1
    setFontSizeRatio(gcf,1/FontSizeRatio);
end
    
    % write source text on Figure
    function writeSource()
        
        mFileName = '';
%         mFileLine = NaN;
        mFileDate = now;
        
        % if the user uses SN_figure, it would really help to have the
        % UserData information that contains the source information of the
        % m-file that generates the figure
        fig_UserData = get(Figure,'UserData');
        if ~isstruct(fig_UserData) || ...
                sum(isfield(fig_UserData,{'mfilename','line','date'}))~=3
            fig_UserData = NaN;
        else
            mFileName = fig_UserData.mfilename;
%             mFileLine = fig_UserData.line;
            mFileDate = fig_UserData.date;
        end
        
        % if the figure doesn't contain the source we might try to extract
        % from the m-file that calls this function
        if ~isstruct(fig_UserData) && isnan(fig_UserData)
            [ST,~] = dbstack('-completenames');
            for ii=1:numel(ST)
                if strncmp(ST(ii).name,'SN_printfig',11)
                    continue;
                else
                    tmp = ST(ii).name;
                    ind = strfind(tmp,'/');
                    if isempty(ind)
                        mFileName = tmp;
                    else
                        mFileName = tmp(1:ind(1)-1);
                    end
                    break;
                end
            end
        end
        
        if (NoSource && NoTimeStamp)
            return;
        end
        
        if (~(NoSource) || ~(NoTimeStamp)) && FootNote
            
            % generates a floating axes to put the source text
            if(Figure ~= gcf)
                figure(Figure);
            end
            
            
            gcf_pos = get(gcf,'position');
            gcf_w = gcf_pos(3);
            gcf_h = gcf_pos(4);
            
            fontSize = 1/100;
            
            if isempty(mFileName) || NoSource
                if NoTimeStamp
                    return;
                end
                textStr = sprintf('%s',datestr(mFileDate));
                if usejava('jvm')
                    nowDate = java.util.Date();
                    timeZone =  -nowDate.getTimezoneOffset()/60;
                    if timeZone<0
                        textStr = sprintf('%s [GMT-%d]',textStr,abs(timeZone));
                    elseif timeZone >0
                        textStr = sprintf('%s [GMT+%d]',textStr,abs(timeZone));
                    else
                        textStr = sprintf('%s [GMT]',textStr);
                    end
                end
            elseif NoTimeStamp
                textStr = sprintf('%s ',mFileName);
            else
                textStr = sprintf('%s on %s',mFileName,datestr(mFileDate));
                if usejava('jvm')
                    nowDate = java.util.Date();
                    timeZone =  -nowDate.getTimezoneOffset()/60;
                    if timeZone<0
                        textStr = sprintf('%s [GMT-%d]',textStr,abs(timeZone));
                    elseif timeZone >0
                        textStr = sprintf('%s [GMT+%d]',textStr,abs(timeZone));
                    else
                        textStr = sprintf('%s [GMT]',textStr);
                    end
                end
            end
            %             textStr = sprintf('%s',textStr);
            %             SourceText = text(0.995,0.005,textStr,...
            
            
            SourceAX = axes('position',[0 0 1 1]);
            if verLessThan('matlab','8.4')
                set(SourceAX,...
                    'xcolor',get(gcf,'Color'),...
                    'xgrid','off',...
                    'xTickLabel',{},...
                    'xtick',[],...
                    'XLim',[0 1],...
                    'xMinorGrid','off',...
                    'ycolor',get(gcf,'Color'),...
                    'ygrid','off',...
                    'yTickLabel',{},...
                    'ytick',[],...
                    'yLim',[0 1],...
                    'yMinorGrid','off',...
                    'zcolor',get(gcf,'Color'),...
                    'zgrid','off',...
                    'zTickLabel',{},...
                    'ztick',[],...
                    'zLim',[0 1],...
                    'zMinorGrid','off',...
                    'box','off',...
                    'fontname','arial',...
                    'tickdir','out');
                SourceText = text(0.005,0.005,textStr,...
                    'horizontalalignment','left',...
                    'verticalalignment','bottom',...
                    'fontname','courier new',...
                    'Interpreter','none',...
                    'fontunits','normalized',...
                    'fontsize',fontSize,...
                    'FontAngle','normal',...
                    'FontWeight','normal',...
                    'margin',1,...
                    'backgroundColor','w',...
                    'color',[1 1 1]*0.5);
            else

                set(SourceAX,...
                    'xcolor','none',...
                    'xgrid','off',...
                    'xTickLabel',{},...
                    'xtick',[],...
                    'XLim',[0 1],...
                    'xMinorGrid','off',...
                    'ycolor','none',...
                    'ygrid','off',...
                    'yTickLabel',{},...
                    'ytick',[],...
                    'yLim',[0 1],...
                    'yMinorGrid','off',...
                    'zcolor','none',...
                    'zgrid','off',...
                    'zTickLabel',{},...
                    'ztick',[],...
                    'zLim',[0 1],...
                    'zMinorGrid','off',...
                    'box','off',...
                    'fontname','arial',...
                    'tickdir','out');
                SourceText = text(0.005,0.005,textStr,...
                    'horizontalalignment','left',...
                    'verticalalignment','bottom',...
                    'fontname','courier new',...
                    'Interpreter','none',...
                    'fontunits','normalized',...
                    'fontsize',fontSize,...
                    'FontAngle','normal',...
                    'FontSmoothing','on',...
                    'FontWeight','normal',...
                    'margin',1,...
                    'backgroundColor','w',...
                    'color',[1 1 1]*0.5);
            end
            
            
            set(SourceText,'Tag','SN_generationStampText');
            set(SourceAX,'Tag','SN_generationStampAX');
        end
    end
end

% recursively set all objects under ax
function orgFontSize = setFontSize(ax,FontSize)
    
    orgFontSize = [];
    fs = [];
    if isempty(ax)
        return;
    end
    
    if iscell(ax)
        for i = 1:numel(ax)
            fs = cat(1,fs,setFontSize(ax{i},FontSize));
        end
        if ~isempty(fs)
            orgFontSize = mean(fs);
        end
        return;
    end
    
    if ~isobject(ax) && ~verLessThan('matlab','8.4')
        return;
    end
    if numel(ax)>1
        for i = 1:numel(ax)
            fs = cat(1,fs,setFontSize(ax(i),FontSize));
        end
        if ~isempty(fs)
            orgFontSize = mean(fs);
        end
        return;
    end
    
    if isprop(ax,'type')
        type = get(ax,'type');
        if strncmpi(type(end-3:end),'menu',4);
            return;
        end
        if sum(strcmpi(type,{'line','patch'}))>0;
            return;
        end
        if strncmpi(type(end-3:end),'tool',4);
            return;
        end
    end
    
    if isprop(ax,'FontSize')
        orgFontSize = get(ax,'FontSize');
        set(ax,'FontSize',FontSize);
    end
    
    if verLessThan('matlab','8.4') && isa(ax, 'double')
        ax = handle(ax);
        if isgraphics(ax)
            if ~graphicsversion(ax,'handlegraphics')
                mc = metaclass(ax);
                prop = mc.PropertyList;
                prop = {prop.Name};
            else
                prop = fieldnames(ax);
            end
           
        else
            prop = {};
        end
    else
        prop = properties(ax);
    end
    % go through all properties to get the children text to set interpreter
    for i = 1:numel(prop)
        % advoiding an infinite recursion
        if strcmpi(prop{i},'parent');
            continue;
        end
        
        if strcmpi(prop{i},'FigureHandle');
            continue;
        end
        
        if strcmpi(prop{i},'UserData');
            continue;
        end
        
        % advoiding an infinite recursion of refering to the same object
        % again and again
        if strncmpi(prop{i},'current',7);
            continue;
        end
        
        if strncmpi(prop{i}(end-2:end),'fcn',3);
            continue;
        end
        if numel(prop{i})>5 && strncmpi(prop{i}(end-5:end),'object',3);
            continue;
        end
        if verLessThan('matlab','8.4')
            if (numel(prop{i})>4 && strncmpi(prop{i}(end-4:end),'label',3)) ||...
                    strcmpi(prop{i},'children') || ...
                    strcmpi(prop{i},'title');
                propDetails = get(ax,prop{i});
            else
                continue;
            end
        else
            propDetails = get(ax,prop{i});
        end
        if iscell(propDetails)
            for j = 1:numel(propDetails)
                if isobject(propDetails{j}) || verLessThan('matlab','8.4')
                    fs = cat(1,fs,setFontSize(propDetails{j},FontSize));
                end
            end
            if ~isempty(orgFontSize)
                continue;
            end
            if ~isempty(fs)
                fs = cat(1,fs,orgFontSize);
                orgFontSize = mean(fs);
            end
            continue
        end
        if isobject(propDetails) || verLessThan('matlab','8.4')
            for j = 1:numel(propDetails)
                fs = cat(1,fs,setFontSize(propDetails(j),FontSize));
            end
            if ~isempty(orgFontSize)
                continue;
            end
            if ~isempty(fs)
                fs = cat(1,fs,orgFontSize);
                orgFontSize = mean(fs);
            end
            continue;
        end
    end
end
% recursively set all objects under ax
function setFontSizeRatio(ax,FontSizeRatio)

    if isempty(ax)
        return;
    end
    
    if iscell(ax)
        for i = 1:numel(ax)
            setFontSizeRatio(ax{i},FontSizeRatio);
        end
        return;
    end
    
    if ~isobject(ax) && ~verLessThan('matlab','8.4')
        return;
    end
    if numel(ax)>1
        for i = 1:numel(ax)
            setFontSizeRatio(ax(i),FontSizeRatio);
        end
        return;
    end
    
    
    if isprop(ax,'type')
        type = get(ax,'type');
        if strncmpi(type(end-3:end),'menu',4);
            return;
        end
        if sum(strcmpi(type,{'line','patch'}))>0;
            return;
        end
        if strncmpi(type(end-3:end),'tool',4);
            return;
        end
    end
    
    if isprop(ax,'FontSize')
        orgFontSize = get(ax,'FontSize');
        set(ax,'FontSize',orgFontSize*FontSizeRatio);
    end
    
    if verLessThan('matlab','8.4') && isa(ax, 'double')
        ax = handle(ax);
        if isgraphics(ax)
            if ~graphicsversion(ax,'handlegraphics')
                mc = metaclass(ax);
                prop = mc.PropertyList;
                prop = {prop.Name};
            else
                prop = fieldnames(ax);
            end
           
        else
            prop = {};
        end
    else
        prop = properties(ax);
    end
    % go through all properties to get the children text to set interpreter
    for i = 1:numel(prop)
        % advoiding an infinite recursion
        if strcmpi(prop{i},'parent');
            continue;
        end
        
        if strcmpi(prop{i},'FigureHandle');
            continue;
        end
        
        if strcmpi(prop{i},'UserData');
            continue;
        end
        
        % advoiding an infinite recursion of refering to the same object
        % again and again
        if strncmpi(prop{i},'current',7);
            continue;
        end
        
        if strncmpi(prop{i}(end-2:end),'fcn',3);
            continue;
        end
        
        if numel(prop{i})>5 && strncmpi(prop{i}(end-5:end),'object',3);
            continue;
        end
        
        %skip labels and titles because that is taken care by axes
        if numel(prop{i})>5
            if strncmpi(prop{i}(end-4:end),'label',5);
                continue;
            end
        end
        if strcmpi(prop{i},'title');
            continue;
        end
        
        if verLessThan('matlab','8.4')
            if (numel(prop{i})>4 && strncmpi(prop{i}(end-4:end),'label',3)) ||...
                    strcmpi(prop{i},'children') || ...
                    strcmpi(prop{i},'title');
                propDetails = get(ax,prop{i});
            else
                continue;
            end
        else
            propDetails = get(ax,prop{i});
        end
        if iscell(propDetails)
            for j = 1:numel(propDetails)
                if isobject(propDetails{j}) || verLessThan('matlab','8.4')
                    setFontSizeRatio(propDetails{j},FontSizeRatio);
                end
            end
            continue
        end
        if isobject(propDetails) || verLessThan('matlab','8.4')
            for j = 1:numel(propDetails)
                setFontSizeRatio(propDetails(j),FontSizeRatio);
            end
            continue;
        end
    end
end

