clearvars
clc

%decide which kind of input you want to use: images=1; video=2;
input=1;

%set the number of unit cell per row/column (assuming they're the same!!)
%fully visible in image.
n=1;

%specify which truss-structure is used:
%Octahedron=1; bitruncated-octahedron=2; Octet=3; 2D hexagon=4; dat file=5;
type=5;

%for a dat/csv/other file import for the point list, specify the file name and
%directory if not in working directory:
datfile='G:\MMLab_ExperimentaData\03Metamaterials\RadiKaoutar\01Impact_experiments\Exp01062022\Octa.csv';

%specify the filetype (as a string) if images are imported. (otherwise just
%leave as is)
filetype='.tif';

%specify the directory from/into which data is to be loaded/written.
%under the current folder. e.g. 'Input\' or 'Input\Raw_Images\' backslash at the end!!
%if current directory is desired, simply write ''
directory_in='G:\MMLab_ExperimentaData\03Metamaterials\RadiKaoutar\01Impact_experiments\Exp01062022\0.01\Octet_0.01\'; % in case of video add filename like: '\outvid_Octahedron.mp4'
directory_out='G:\MMLab_ExperimentaData\03Metamaterials\RadiKaoutar\01Impact_experiments\Exp01062022\0.01\Octet_0.01\';

%choose if you want to save the tracking process in a video: (yes=1;no=0;)
%if a save file is desired, specify it's filename (both txt and video); if
%the name is non-unique, i.e. such a file already exists, errors may ensue.
filename='DG';
videosave=1;

%choose if you want to save the tracked node-coordinates as .txt-files
txtsave=1;

%if we don't want to analyse all frames (due to too many
%frames/deformation), we can select how many we skip between two tracked
%ones. if none should be skipped, write 1 -this can possibly lead to errors
%if the total number of images is divisible by the skipframe number.
skipframe=1;

if input==1
    imageTracking(directory_in,directory_out,filetype,videosave,txtsave,filename,n,type,skipframe,datfile)
elseif input==2
    videoTracking(directory_in,directory_out,videosave,txtsave,filename,n,type,datfile)
end

close all

