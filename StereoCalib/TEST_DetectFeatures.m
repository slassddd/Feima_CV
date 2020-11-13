I = rgb2gray( imread('checkboard_blackwhite_8_8.png') );
KP.SURF = detectSURFFeatures(I);
KP.FAST = detectFASTFeatures(I);
KP.Harris = detectHarrisFeatures(I);
KP.ORB = detectHarrisFeatures(I);
numSelPoints = 81;
figure;
subplot(221)
imshow(I); hold on;
plot(KP.SURF.selectStrongest(numSelPoints)); hold on;
ylabel('SURF')
subplot(222)
imshow(I); hold on;
plot(KP.FAST.selectStrongest(numSelPoints)); hold on;
ylabel('FAST')
subplot(223)
imshow(I); hold on;
plot(KP.Harris.selectStrongest(numSelPoints)); hold on;
ylabel('Harris')
subplot(224)
imshow(I); hold on;
plot(KP.ORB.selectStrongest(numSelPoints)); hold on;
ylabel('ORB')