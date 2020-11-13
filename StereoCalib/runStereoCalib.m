clear,clc
%% 载入相片
pathCalibData_1 = '..\Data_Calib\20200924\png1'; % 左相机
pathCalibData_2 = '..\Data_Calib\20200924\png2'; % 右相机
% 
% pathCalibData_1 = 'png1'; % 左相机
% pathCalibData_2 = 'png2'; % 右相机
[imageFileNames1, imageFileNames2] = getAllImagePaths(pathCalibData_1,pathCalibData_2);
%% 检测checkerboard
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames1, imageFileNames2);

% Generate world coordinates of the checkerboard keypoints
squareSize = 2.240000e+01;  % in units of 'millimeters'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Read one of the images from the first stereo pair
I1 = imread(imageFileNames1{1});
[mrows, ncols, ~] = size(I1);

% 标定相机
[stereoParams, pairsUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', true, ...
    'NumRadialDistortionCoefficients', 3, 'WorldUnits', 'millimeters', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
    'ImageSize', [mrows, ncols]);

% View reprojection errors
h1=figure; showReprojectionErrors(stereoParams);

% Visualize pattern locations
h2=figure; showExtrinsics(stereoParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, stereoParams);

% You can use the calibration data to rectify stereo images.
I2 = imread(imageFileNames2{1});
[J1, J2] = rectifyStereoImages(I1, I2, stereoParams);
filename = ['StereoCalibParams',date,'.mat'];
save(filename,'stereoParams');