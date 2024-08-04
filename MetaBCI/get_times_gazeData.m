clc,clear all
%%读眼动数据
% path='C:\Users\ylrr\Documents\MATLAB\0314\20190214T101444Z\'
path='E:\experiment data\eye tracking\1.23\20220123T083048Z\gazedata\';

fid=fopen([path 'gazedata'],'r');  %打开文本文件

gaze_data={};
i=0;
gaze2d_data=[];
times_data = [];
while ~feof(fid)
    i=i+1;
   gaze_str = fgetl(fid);   % 读取一行, str是字符串
   gaze_data{i}=gaze_str;
   
   gaze2d_position=strfind(gaze_str,'gaze2d":[');
%    disp(gaze2d_position);
   time_position = strfind(gaze_str, 'timestamp":');
   if isempty(gaze2d_position)
    gaze2d_data(i,1)=10000;
    gaze2d_data(i,2)=10000;
   else
       gaze3d_position=strfind(gaze_str,'],"gaze3d');
       gaze2d_str=gaze_str(gaze2d_position(end)+10:gaze3d_position(1)-2);
%        disp(gaze2d_position);
       i_comma=strfind(gaze2d_str,',');
       gaze2d_data(i,1)=str2num(gaze2d_str(1:i_comma-1));
       gaze2d_data(i,2)=str2num(gaze2d_str(i_comma+1:end));
   end
   data_position = strfind(gaze_str, '"data":{"');
%    disp(time_position);
%    disp(data_position);
   time_str = gaze_str(time_position+11:time_position+19);
%    disp(time_str);
   times_data(i) = str2num(time_str);
end
times_data = times_data';
save('E:\experiment data\eye tracking\1.23\20220123T083048Z\gazedata\gazeDataAndTimes.mat', 'gaze2d_data', 'times_data');