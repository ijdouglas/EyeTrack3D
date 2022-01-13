Data Analysis Steps
1. Download/export gaze_positions.csv from Pupil Player
2. Read it into analysis platform (python)
3. Multiply column with x position (in pixels) by 1088
4. Multiply column with y position (in pixels) by 1080
5. Read in the world_timestamp file for elapsed time (Seconds)
6. Define unproject_pts from python script
7. Using the info.invisible.json file, manually enter the serial number (for the scene camera) into: https://api.cloud.pupil-labs.com/hardware/<SERIAL_NUMBER>/calibration.v1?json (excluding the greater than and less than)
8. Manually define the camera_matrix and dist_coefs objects in python
9. Using the x and y columns that have been adjusted for resolution already, as well as the camera_matrix and dist_coefs, run `unproject_pts` and save result as pandas data frame
10. Create a column for the elapsed time contained in `world_timestamps`
11. Write out this csv with x, y, and z (normed) columns
12. Read it back into matlab.
13. Run fixation script 