function [Points] = PointLocations(n,type,datfile)
%number of resulting points for this particular truss type:
% type 1 = Octahedron
% type 2 = Bitruncated Octahedron
% type 3 = Octet
%  type 5= %%Input grid from .dat file
%for the Octahedron:
if type==1
    nr=n*2-1;
    np=n*nr+n*(nr-n);
    Pointsx=ones(nr); 
    Points=zeros(np,2);%initialize the point matrix to be tracked
    for i=1:nr
        for j=1:nr
            if mod(i,2)==0
                if mod(j,2)==0
                    Pointsx(i,j)=0;
                else
                    Pointsx(i,j)=j;
                end
            else
                Pointsx(i,j)=j;
            end
        end
    end
    counter=0;
    %regrettably, this loop has to be apart from the other (I think) since
    %Pointsx needs a lower loop level to be fully defined than Points.
    for i=1:nr
        for j=1:nr
            if Pointsx(i,j)==0
                counter=counter+1;
            else
                Points(i*nr-nr+j-counter,:)=[Pointsx(i,j),i];
            end
        end
    end

%for the Bitruncated Octahedron:
elseif type==2
    nr=4*n-1;
    np=4*n^2+2*(n-1)*n;
    Pointsx=zeros(nr);
    Points=zeros(np,2);
    %reuse the code from above, with small tweaks
    for i=2:4:nr
        for j=1:nr
            Pointsx(i,j)=j;
        end
    end
    for j=2:4:nr
        for i=1:nr
            Pointsx(i,j)=j;
        end
    end
    for i=2:4:nr
        for j=2:4:nr
            Pointsx(i,j)=0;
        end
    end
    
    counter=0;
    for i=1:nr
        for j=1:nr
            if Pointsx(i,j)==0
                counter=counter+1;
            else
                Points(i*nr-nr+j-counter,:)=[Pointsx(i,j),i];
            end
        end
    end
    Points=Points-[1,0];
    
%for the Octet:  
elseif type==3
    nr=2*n-1;
    np=n^2+(n-1)^2;
    Pointsx=zeros(nr);
    Points=zeros(np,2);
    %reuse the code from above, with small tweaks
    for i=1:nr
        for j=1:nr
            if mod(i,2)==0
                if mod(j,2)==0
                    Pointsx(i,j)=j;
                end
            else
                if mod(j,2)~=0
                    Pointsx(i,j)=j;
                end
            end
        end
    end
    counter=0;
    for i=1:nr
        for j=1:nr
            if Pointsx(i,j)==0
                counter=counter+1;
            else
                Points(i*nr-nr+j-counter,:)=[Pointsx(i,j),i];
            end
        end
    end
elseif type==4
    nr=n*2+3;
    np=8*(n-1);
    Pointsx=zeros(nr,n-1);
    Points=zeros(np,2);
    %reuse the code from above, with small tweaks
    for i=1:nr
        for j=1:n-1
            if mod(i,3)~=0
                if mod(i,2)==0
                    if mod(j,2)~=0
                        Pointsx(i,j)=j;
                    end
                else 
                    if mod(j,2)==0
                        Pointsx(i,j)=j;
                    end
                end 
            end
        end
    end
    counter=0;
    for i=1:nr
        for j=1:n-1
            if Pointsx(i,j)==0
                counter=counter+1;
            else
                Points(i*(n-1)-(n-1)+j-counter,:)=[Pointsx(i,j),i];
            end
        end
    end
    Points=Points-[1,0];
elseif type==5                             %%Input g4id from .dat file
    filename = datfile;
    delimiter = ',';
    formatSpec = '%f%f%f%[^\n\r]';
    fileID = fopen(filename,'r');
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);
    fclose(fileID);
    temp = [dataArray{1:end-1}];
    Points = temp(:,2:3);
    clearvars filename delimiter formatSpec fileID dataArray ans;
end

