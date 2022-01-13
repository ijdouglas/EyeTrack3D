def unproject_pts(pts_2d, K, D, use_distortion=True, normalize=False):
  eps = np.finfo(np.float32).eps
  f = np.array((K[0,0], K[1,1])).reshape(1,2)
  c = np.array((K[0,2], K[1, 2])).reshape(1,2)
  if use_distortion:
    k = D.ravel().astype(np.float32)
  else:
    k = np.asarray([1.0/3.0, 2.0/15.0, 17.0/315.0, 62.0/2835.0], dtype=np.float32)
    pi = pts_2d.astype(np.float32)
    pw = (pi - c) / f
    theta_d = np.linalg.norm(pw, ord = 2, axis = 1)
    theta = theta_d
    for j in range(10):
      theta2=theta**2
      theta4=theta2**2
      theta6=theta4*theta2
      theta8=theta6*theta2
      theta=theta_d / (1 + k[0]*theta2 + k[1]*theta4 + k[2]*theta6 + k[3]*theta8)
    scale = np.tan(theta) / (theta_d + eps)
    pts_2d_undist = pw * scale.reshape(-1, 1)
    pts_3d = cv2.convertPointsToHomogeneous(pts_2d_undist)
    pts_3d.shape = -1, 3
    if normalize:
      pts_3d /= np.linalg.norm(pts_3d, axis=1)[:, np.newaxis]
    return pts_3d
