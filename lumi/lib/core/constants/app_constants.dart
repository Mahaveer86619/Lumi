class AppConstants {
  static const String appName = 'Lumi';

  // SharedPreferences keys (for non-sensitive data)
  static const String prefUserKey = 'user_data';
  
  // Secure storage keys (for sensitive data)
  static const String secureTokenKey = 'access_token';
  static const String secureRefreshTokenKey = 'refresh_token';

  static String notificationChannelGroupKey =
      'lumi_notification_channel_group';
  static String notificationChannelGroupName =
      'lumi_notification_channel_group_name';
  static String notificationChannelId = 'lumi_notification_channel';
  static String notificationChannelName = 'lumi Notifications';
  static String notificationChannelDescription = 'Notifications for lumi';

  static String defaultAvatarUrl = 'https://feji.us/a593ri';
  static String defaultGroupAvatarUrl = 'https://tinyurl.com/223bcs7k';
}
