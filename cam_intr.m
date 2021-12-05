cd('C:\Users\OMER\Downloads\intrinsics_vid\2021-10-26_12-07-34-754f4d67')
images = imageSet('frames'); %folder containing images of each frame
imageFileNames = images.ImageLocation;
[imagePoints, boardSize] = detectCheckerboardPoints(imageFileNames);
squareSizeInMM = 69; %size of a checker box in mm
worldPoints = generateCheckerboardPoints(boardSize,squareSizeInMM);
I = readimage(images,1);
imageSize = [size(I, 1),size(I, 2)];
params = estimateCameraParameters(imagePoints,worldPoints, ...
    'ImageSize',imageSize);

cd('frames')
x=dir;
for image=3:length(x)
    I = imread(x(image).name);
    J = undistortImage(I,params);
    figure; imshowpair(imresize(I,0.5),imresize(J,0.5),'montage');
    title('Original Image (left) vs. Corrected Image (right)');
    keyboard;
end

% determine focal length from video with measuring tape
cd('C:\Users\OMER\Downloads\pupil-cloud-download-2021-11-07T18-46-56.684421-1-recordings\2021-10-26_13-15-02-d8ac15b1\frames')
I = imread('012.bmp');
J = undistortImage(I,params);
% 30 cm  = 1053-463 = 590. Thus, 40 cm distance from camera = 787 pixels
