% 该文件将会把视频文件转换为图片集，并以ORB_SLAM3中euroc数据集的文件夹结构存储
clc
%% 基础设置
nameVideoFolder = 'VideoFiles'; % 视频文件存放文件夹
fprintf('请确保打开工程，且将视频文件放置在工程目录中的 %s 文件夹中\n',nameVideoFolder);
mode = 'sel'; % 视频文件选择方式
objProject = currentProject; % 获取当前工程目录
rootProject = objProject.RootFolder{1}; % 工程路径
rootVideoFolder = [rootProject,'\',nameVideoFolder,'\']; % 视频文件存放路径
switch mode
    case 'dir'
        fileNames = 'phone.mp4';
        fileFullPath = [rootVideoFolder,fileNames];
    case 'sel'
        [fileNames,pathName,~] = uigetfile([rootVideoFolder,'*.*'],'选择视频文件','MultiSelect','off'); % 
        if isequal(fileNames,0)
            disp('没有选择视频文件');
            return;
        else
            fprintf('选择视频文件 %s (%s)\n',fileNames,pathName);
        end
        fileFullPath = [pathName,fileNames];
end
namePicSaveFolder = [rootVideoFolder,strrep(fileNames,'.','_'),'\mav0\cam0\data'];
mkdir([namePicSaveFolder]);
obj = VideoReader(fileFullPath);
fprintf('视频名称: %s%s\n',fileNames);
fprintf('\t分辨率: %d x %d \n',obj.Width,obj.Height);
fprintf('\t帧率: %.1f \n',obj.FrameRate);
fprintf('\t时长: %.2f sec\n',obj.Duration);
fprintf('\t总帧数: %d\n',obj.NumFrames);
%% 生成图片
nPic = 0;
tic;
for i=1:1:10 %obj.NumFrames
    if rem(i,50) == 0
        fprintf('生成 %d / %d\n',i,obj.NumFrames);
    end
    frame = read(obj,i);
    temp=sprintf('%s\\%05d.png',namePicSaveFolder,i);
    imwrite(frame,temp);
    nPic = nPic + 1;
end
timeGenPic = toc;
fprintf('完成视频到图片的转换,生成图片 %d 张, 耗时 %.2f sec \n',nPic,timeGenPic);
%% 生成时间戳
[pathImage1, pathImage2, nImage, imageNames] = getAllImagePaths(namePicSaveFolder,namePicSaveFolder);
fid=fopen([rootVideoFolder,strrep(fileNames,'.','_'),'\FeiMa_TimeStamps.txt'],'w'); %写入文件路径
for i = 1:nImage
    fprintf(fid,'%s\n',imageNames{i});
end
fclose(fid);
fprintf('完成时间戳文件生成 FeiMa_TimeStamps.txt\n');
