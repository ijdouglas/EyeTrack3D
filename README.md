# EyeTrack3D
code related to 3-D eye tracking

* findFixations.m calculates fixations (as opposed to saccades)
* cam_params.mat stores the intrinsics of the pupil labs invisibles 
* cam_intr.m provides method for estimating above intrinsic params from scratch and a checkerboard
  * distance from camera to image plane is 787 pixels
* `undistortImage` and `undistortPoints` (see cam_intr.m) projects 2D data into 3D given intrinsic params

![](/image.png)
