function [] = imageTracking(directory_in,directory_out, filetype,videosave,txtsave,filename,n,type,skipframe,datfile)

filelist_import=dir(strcat(directory_in,'*',filetype));
filelist=cell(length(filelist_import),1);
for i=1:length(filelist_import)
  filelist(i,1)={strcat(directory_in,filelist_import(i).name)};%access with filelist{x} for the x-th entry.
end

img=imread(filelist{1},'tif');

%since img is a 12bit-image, we either have to divide or multiply 
%it by 16. dividing leads to rounding of the grey-values, so we'd rather multiply.
img=uint8(img/16); 
imshow(img);

%we first want to have the upper left reference point, then the lower
%right. Be aware that it has to be an actual Point!! (a point that will be 
%part of the tracked points) order: y before x

referencepoints=zeros(4,2);
title('select upper left, then upper right, then lower right and lower left ref. points (outermost nodes to track)');
for i=1:length(referencepoints)
referencepoints(i,:)=getPosition(impoint); %1=low_left,2=low_right,3=upp_right,4=upp_left
end

low_left=referencepoints(1,:);
low_right=referencepoints(2,:);
upp_right=referencepoints(3,:);
upp_left=referencepoints(4,:);

%run a function to get a Pointlist to track
TrackPoints=PointLocations(n,type,datfile);

upp_refn=[min(TrackPoints(:,1)),min(TrackPoints(:,2))]; %this one is the top-/leftmost node
low_refn=[max(TrackPoints(:,1)),max(TrackPoints(:,2))]; %this one is the bottom-/rightmost node
TrackPoints=TrackPoints-min(TrackPoints);

%we define the new width and heigth of the network, as well as of the one we're referencing to.

wm=abs(upp_refn(1)-low_refn(1));
hm=abs(upp_refn(2)-low_refn(2));

%now we define the Points in terms of Pixels.
impoints=zeros(length(TrackPoints),2);
%here follows a rather complicated bit of calculation to enable better mask
%placement on the structure of interest. in the end, it's just linear
%interpolation though.
impoints(:,1)=TrackPoints(:,1)./wm.*((low_right(1)-low_left(1)).*(1-TrackPoints(:,2)./max(TrackPoints(:,2)))+(upp_right(1)-upp_left(1)).*TrackPoints(:,2)./max(TrackPoints(:,2)))+TrackPoints(:,2)./max(TrackPoints(:,2))*(upp_left(1)-low_left(1));
impoints(:,2)=TrackPoints(:,2)./hm.*((upp_left(2)-low_left(2)).*(1-TrackPoints(:,1)./max(TrackPoints(:,1)))+(upp_right(2)-low_right(2)).*TrackPoints(:,1)./max(TrackPoints(:,1)))+TrackPoints(:,1)./max(TrackPoints(:,1))*(low_right(2)-low_left(2));
impoints(:,1)=impoints(:,1)+referencepoints(1,1);
impoints(:,2)=impoints(:,2)+referencepoints(1,2);
%determine the size of the inserted marker. It does not matter but for the
%visibility in images.
impoints(:,3)=6;
%We display all the points defined by marking them with a marker of choice
pointImage = insertShape(img,'FilledCircle',impoints,'Color','green');

%for later reference (if so desired), we save the initial position of our points. 
%initialposition=impoints;

figure;
imshow(pointImage);
title('Detected interest points');

%need to have the image processing toolbox installed for this!!
videoPlayer = vision.VideoPlayer('Position',[50,50,900,900]); 

%now we use a modified matlab example code for the tracking.
tracker = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker,impoints(:,1:2),img);

%assuming the tracker reads through every single frame of the videofile and
%that we know the global displacement at each frame, we safe each frames
%and therefore timesteps location data 
if videosave
    %v=VideoWriter('Compression1_DIC_highQ.avi', 'Uncompressed AVI');%huge files, bad
    v=VideoWriter(strcat(directory_out,filename,'_DIC_medQ.avi'));
        v.Quality=100;
        v.FrameRate=24;
        open(v)

    for i=1:length(filelist)/skipframe
        frame=imread(filelist{i*skipframe},'tif');           
        frame = uint8(frame/16);
        [impoints(:,1:2),~] = tracker(frame);
        out = insertShape(frame,'FilledCircle',impoints,'Color','green');
        videoPlayer(out);
        writeVideo(v,out);
        xpos_track(i,:)=impoints(:,1);
        ypos_track(i,:)=impoints(:,2);
    end
    %endposition=impoints;
    close(v)
    release(videoPlayer);
    release(tracker);
else
    for i=1:length(filelist)/skipframe
        frame=imread(filelist{i*skipframe},'tif');
        frame = uint8(frame/16);
        [impoints(:,1:2),~] = tracker(frame);
        out = insertShape(frame,'FilledCircle',impoints,'Color','green');
        videoPlayer(out);
        xpos_track(i,:)=impoints(:,1);
        ypos_track(i,:)=impoints(:,2);
    end

    release(videoPlayer);
    release(tracker);
end

if txtsave
    dlmwrite(strcat(directory_out,'x_',filename,'.txt'),xpos_track,'delimiter','\t') 
    dlmwrite(strcat(directory_out,'y_',filename,'.txt'),ypos_track,'delimiter','\t') 
end

%{ 
%these lines are for re-normalising the tracked positions again, if needed.
[h,w]=size(xpositiontracker);
X5=zeros(h,w);
Y5=zeros(h,w);
%normalize the just gained positions while getting displacements from them:
for i=1:w-1
    X5(:,i+1)=(xpositiontracker(:,i)-initialposition(:,1))/wpx*wm;
    Y5(:,i+1)=(ypositiontracker(:,i)-initialposition(:,2))/hpx*hm;
end
%}
