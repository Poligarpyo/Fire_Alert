
enum SGRoute {
  splash,

  home,

  login,

  register,

  forgotPassword,

  accountInfo,

  editProfile,

  trackfiretruck,

  reportIncident,

  reportsHistory,

  about,

  privacyPolicy,

  termsAndConditions,

  offlineSMS;

  String get route => '/${toString().replaceAll('SGRoute.', '')}';

  String get name => toString().replaceAll('SGRoute.', '');
}
