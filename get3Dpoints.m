% Read in the pupil labs invisibles camera parameters
% (this should be the same for every invisibles of the same model)
params = load('data/cam_params.mat');
% read in one frame to determine the pixel resolution
% (simply the size, in pixels in the x and y directions)
img1 = imread('M:\experiment_59\included\__20191111_5901\cam02_frames_p\img_1.jpg');
imres = size(img1); % get the dimensions of the image
x_res = imres(2) % how many pixels across (x-direction)
y_res = imres(1) % how many pixels top-to-bottom (y-direction)
% Read in the normalized x and y coordinates of pupil gaze location
gaze = readtable('M:\experiment_59\included\__20191111_5901\extra_p\cam02_gaze_raw_data\gaze_positions.csv');
% Now convert the normalized x and y gaze positions from `gaze` into pixels
% (simply multiply the normalized values by their resolution)
x_pixels = gaze.("norm_pos_x") * x_res;
y_pixels = gaze.("norm_pos_y") * y_res;
% Now, knowing that the z direction is 787 pixels, generate 3D eye position
% note size(x_pixels) just means how many frames; could use y_pixels
xyzPixels = [x_pixels y_pixels 787*ones(size(x_pixels))];
% Now normalize th 3D vector representing each row
xyzNorm = normr(xyzPixels);