function [imagePathNames1, imagePathNames2, nImage1, imageNames, imageFullNames] = getAllImagePaths(pathCalibData_1,pathCalibData_2)
if exist(pathCalibData_1,'dir') ~= 7
    fprintf('指定文件夹 %s 不存在\n',pathCalibData_1);
    return;
elseif exist(pathCalibData_2,'dir') ~= 7
    fprintf('指定文件夹 %s 不存在\n',pathCalibData_2);
    return;
end
imageStruct1 = dir(pathCalibData_1);  
imageStruct1(1:2) = []; % 去掉前两维无效数据
nImage1 = length(imageStruct1);
imageStruct2 = dir(pathCalibData_2);
imageStruct2(1:2) = []; % 去掉前两维无效数据
nImage2 = length(imageStruct2);
if nImage1 ~= nImage2
    fprintf('Image number of left and right is different,left %d,right %d\n',nImage1,nImage2); 
    return;
end
imagePathNames1 = cell(nImage1,1);
imagePathNames2 = imagePathNames1;
imageFullNames = {imageStruct1.name}; % 包括文件类型
dotIdx = strfind(imageFullNames,'.');
nIm = 0;
for i = 1:nImage1
    % 单纯文件名称，不含类型
    if contains(imageFullNames{i},[".png"]) || ...
            contains(imageFullNames{i},[".jpg"]) || ...
            contains(imageFullNames{i},[".jpeg"])
        nIm = nIm + 1;
        imageNames{nIm} = imageFullNames{i}(1:dotIdx{i}-1);
    end
end
fprintf('Image number is %d\n',nIm);
nImage1 = nIm;
nImage2 = nIm;
for i = 1:nImage1
    imagePathNames1{i} = [imageStruct1(i).folder,'\',imageStruct1(i).name];
end
for i = 1:nImage2
    imagePathNames2{i} = [imageStruct2(i).folder,'\',imageStruct2(i).name];
end