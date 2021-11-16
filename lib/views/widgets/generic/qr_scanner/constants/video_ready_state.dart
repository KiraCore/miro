enum VideoReadyState {
  /// No information is available about the media resource.
  haveNothing,

  /// Enough of the media resource has been retrieved that the metadata attributes are initialized.
  /// Seeking will no longer raise an exception.
  haveMetadata,

  /// Data is available for the current playback position, but not enough to actually play more than one frame.
  haveCurrentData,

  /// Data for the current playback position as well as for at least a little bit of time into
  /// the future is available (in other words, at least two frames of video, for example).
  haveFutureData,

  /// Enough data is available—and the download rate is high enough—that the media can
  /// be played through to the end without interruption.
  haveEnoughData,
}
