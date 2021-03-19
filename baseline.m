clc
clear
%% Reading Text Files
% Make Sure to change .dat files into .txt and name it accordingly
fileID1=fopen('baseline_tableF3.txt','r');
tline1=fgetl(fileID1);
Baseline=cell(0,1);
while ischar(tline1)
    Baseline{end+1,1}=tline1;
    tline1=fgetl(fileID1);
end
fclose(fileID1);
%% Adjustments
for i=1:size(Baseline,1)
    c{i}=['S1_',Baseline{i}(16:23),'_ALL_F3 ',Baseline{i}(66:end)]; 
end
%% Writing
fname1='BASELINE_F3.txt';
fid1=fopen(fname1,'w');
for j=1:size(Baseline,1)
    fprintf(fid1,c{j});
end
fclose(fid1);
