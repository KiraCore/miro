enum FacingMode {
  /// The video source is facing toward the user; this includes,
  /// for example, the front-facing camera on a smartphone.
  user,

  /// The video source is facing away from the user,
  /// thereby viewing their environment. This is the back camera on a smartphone.
  environment,

  /// The video source is facing toward the user but to their left,
  /// such as a camera aimed toward the user but over their left shoulder.
  left,

  /// The video source is facing toward the user but to their right,
  /// such as a camera aimed toward the user but over their right shoulder.
  right,
}
