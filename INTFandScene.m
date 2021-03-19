clc
clear
%% Reading Text Files
fileID1=fopen('BASELINE_F3.txt','r');    %reading baseline
tline1=fgetl(fileID1);
baseline=cell(0,1);
while ischar(tline1)
    baseline{end+1,1}=tline1;
    tline1=fgetl(fileID1);
end
fclose(fileID1);

fileID2=fopen('intflistF3.txt','r');  %reading intflist
tline2=fgetl(fileID2);
intflist=cell(0,1);
while ischar(tline2)
    intflist{end+1,1}=tline2;
    tline2=fgetl(fileID2);
end
fclose(fileID2);

%%  Crop the Necessary Data
for i=1:length(intflist)
    e{i}=[intflist{i}(1:7)];
    f{i}=[intflist{i}(9:15)];
    g1=strfind(baseline,e{i});
    tf1=cellfun('isempty',g1);
    g1(tf1)={0};
    g1=cell2mat(g1);
    h1=find(g1==20);    %Sometimes "e" can be find in another section of baseline but we need
    I1=extractAfter(baseline{h1},string(' '));  %since each line have different count of characters i used extractAfter
    I1=extractAfter(I1,string(' '));
    I1=extractAfter(I1,string(' '));
    I1=extractAfter(I1,string(' '));
    I1=str2double(I1);
    % Same as before 
    g2=strfind(baseline,f{i});
    tf2=cellfun('isempty',g2);
    g2(tf2)={0};
    g2=cell2mat(g2);
    h2=find(g2==20);
    I2=extractAfter(baseline{h2},string(' '));
    I2=extractAfter(I2,string(' '));
    I2=extractAfter(I2,string(' '));
    I2=extractAfter(I2,string(' '));
    I2=str2double(I2);
    Subtract(i)=I1-I2;
    % Making the matrix for intf.tab
    d{i}=['../intf_all/',intflist{i}(1:end),'/unwrap.grd ../intf_all/', ...
        intflist{i}(1:end),'/corr.grd ',baseline{h1}(4:11),' ',baseline{h2}(4:11),' ',num2str(Subtract(i))];
end
Subtract=num2cell(Subtract');

%% Placing the Cropped Data into Correct Place
for i=1:size(baseline,1)
    c{i}=[baseline{i}(4:11),' ',baseline{i}(39:43)];
end
fname1='scene.txt';
fid1=fopen(fname1,'w');
for j=1:size(baseline,1)
    fprintf(fid1,c{j});
end
fclose(fid1);

fname2='intf.txt';
fid2=fopen(fname2,'w');
for j=1:size(intflist,1)
    fprintf(fid2,d{j});
end
fclose(fid2);