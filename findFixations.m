function [fixationList,fixationBool] = findFixations(gaze3D,frame_rate,velocity_threshold,acceleration_threshold)

%% findFixations

% gaze3D: an Nx3 array where N is the number of frames, and each row is the
% 3D unit vector direction of gaze in head relative coordinates
% frame_rate: 1/difference in time between each row of gaze3D (30FPS = 1/30
% SPF)
% velocity_threshold: desired angular velocity threshold for gaze vector
% acceleration_threhsold: desired angular acceleration threshold for gaze
% vector


% fixationList: an Mx2 array where M is number of fixations, and each
% column are the start and end frames of each fixation
% fixationBool: an Nx1 array where N is the number of frames, each row is
% just a 1 or 0 if that frame is a fixation frame


%% compute angular velocity and acceleration (instantaneous between frames, just compute change in angle between frames)

% we will do this by creating a copy of gaze3D that is shifted one time
% step forwards, so index 1 is now the second frame. Then add another copy
% of the last frame to the end, so this will give us 0 velocity at the last
% frame but that's ok.
gaze3D_nextFrame = [gaze3D(2:end,:);gaze3D(end,:)];

% calculate angle between two vectors with the numerically stable formula
angular_difference = 2*atan2(vecnorm(gaze3D_nextFrame-gaze3D,2,2),vecnorm(gaze3D_nextFrame+gaze3D,2,2));
angular_difference = rad2deg(angular_difference); % convert to degrees

% compute angular velocity based on angular difference by frame
angular_velocity = angular_difference*frame_rate;

% now compute angular acceleration, also doing the 0 end trick
angular_acceleration = diff(angular_velocity);
angular_acceleration(end+1)=0;

%% now apply the thresholds

% determine which frames are under both thresholds
fixationBool = angular_acceleration<acceleration_threshold&...
    angular_velocity<velocity_threshold;

%% generate the fixation list
% use this function that finds islands in binary images. So it will find
% blocks of consecutive 1s in the timeseries
pxIdx = bwconncomp(fixationBool);

% init
fixationList = zeros(length(pxIdx.PixelIdxList),2);

% iterate over each of the islands and find the start and end frame
for idx = 1:length(pxIdx.PixelIdxList)
   
    fixationList(idx,1) = pxIdx.PixelIdxList{idx}(1);
    fixationList(idx,2) = pxIdx.PixelIdxList{idx}(end);
end