# EyeTrack3D
code related to 3-D eye tracking

* findFixations.m calculates fixations (as opposed to saccades)
* cam_params.mat stores the intrinsics of the pupil labs invisibles 
* cam_intr.m provides method for estimating above intrinsic params from scratch and a checkerboard
  * distance from camera to image plane is 787 pixels
* `undistortImage` and `undistortPoints` (see cam_intr.m) projects 2D data into 3D given intrinsic params

![](/image.png)


Using the GUI at https://alicevision.org/#meshroom, with the focal length in pixels and a 2D video, we can render a 3D model from the video
- .png files to test out meshroom with: https://drive.google.com/drive/folders/1T__yKJqktyYncYvVDYFVEK05dPd8KGXJ
- Usage:
  - use frames2png.sh to convert frames of video to png
  - use undistortImage.m to undistort 2D images given the focal length of 787 pixels specific to camera
  - add to GUI 
  - At bottom of GUI in visualizaion node, fill in first node with camera focal length


### Goals

1. Calculate 3D gaze vectors from 2D eye direction coordinates
2. Compute fixation points in 3D
3. Map back to bounding boxes of objects in 2D egocentric video
