enum LoginStatus {
  ideal,
  gesturlogin,
  login,
  loginError,
  otpSuccess,
  otpFailed,
  signupSuccess,
  signupFailed,
  verifyFirst,
  verifyAgo,
  updateName,
  notUpdateName,
}

enum UserComplete {
  localAddressNotFound,
  localAddressFound,
  addressNotFound,
  addressFound
}

enum RequestState {
  ideal,
  loading,
  success,
  nullData,
  failed,
  error,
}

enum MapStatus {
  ideal,
  loading,
  done,
  notpermition,
}

enum MapFunctionality {
  display,
  displayOnTracking,
  track,
  chooser,
}

enum MapChooserType { page, sheet }

enum Lang { english, arbic }

enum NavPages {
  profile,
  myrequest,
  home,
  expereance,
  notification,
}
