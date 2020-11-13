function genTimeStamps(pathCalibData_1,pathCalibData_2)
% genTimeStamps_codegen('Data_Calib\20200923')
% if nargin == 1
%     pathFolder = [varargin{1},'\']; 
% else
%     pathFolder = '';
% end
% image1Folder = 'png1';
% image2Folder = 'png2';
% pathCalibData_1 = [pathFolder,image1Folder]; % 左相机
% pathCalibData_2 = [pathFolder,image2Folder]; % 右相机

[~, ~, nImage, imageNames] = getAllImagePaths(pathCalibData_1,pathCalibData_2);
fid=fopen([pathFolder,'FeiMa_TimeStamps.txt'],'w'); %写入文件路径
for i = 1:nImage
    fprintf(fid,'%s\n',imageNames{i});
end
fclose(fid);