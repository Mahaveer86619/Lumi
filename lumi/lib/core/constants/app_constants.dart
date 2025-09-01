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

  static String defaultAvatarUrl = 'https://img.freepik.com/free-vector/blue-circle-with-white-user_78370-4707.jpg?semt=ais_hybrid&w=740&q=80';
  
}
