pathFolder = 'Data_Calib\ByAir1123\';
image1Folder = 'png1';
image2Folder = 'png2';
pathCalibData_1 = [pathFolder,image1Folder]; % 左相机
pathCalibData_2 = [pathFolder,image2Folder]; % 右相机
[pathImage1, pathImage2, nImage, imageNames] = getAllImagePaths(pathCalibData_1,pathCalibData_2);
%% 生成时间戳
fid=fopen([pathFolder,'FeiMa_TimeStamps.txt'],'w'); %写入文件路径
for i = 1:nImage
    fprintf(fid,'%s\n',imageNames{i});
end
fclose(fid);
%% 转换灰度图
grayFolder = [pathFolder(1:end-1),'-gray\'];
try % 
    rmdir(grayFolder)
end
mkdir([grayFolder,'png1'])
mkdir([grayFolder,'png2'])
if 1
    for i = 1:nImage
        % 相机1
        nameImage1 = pathImage1{i};
        im_rgb = imread(nameImage1);
        im_gray = rgb2gray(im_rgb);
        nameImage1_gray = strrep(nameImage1,pathFolder,grayFolder);
        imwrite(im_gray,nameImage1_gray);
        if rem(i,200) == 0
            fprintf('处理图 %d/%d\n',i,nImage)
            figure;
            subplot(121)
            imshow(im_rgb);hold on;
            subplot(122)
            imshow(im_gray);hold on;
        end
        % 相机2
        nameImage2 = pathImage2{i};
        im_rgb = imread(nameImage2);
        im_gray = rgb2gray(im_rgb);
        nameImage2_gray = strrep(nameImage2,pathFolder,grayFolder);
        imwrite(im_gray,nameImage2_gray);
        if rem(i,200) == 0
            fprintf('处理图 %d/%d\n',i,nImage)
            figure;
            subplot(121)
            imshow(im_rgb);hold on;
            subplot(122)
            imshow(im_gray);hold on;
        end    
    end
end