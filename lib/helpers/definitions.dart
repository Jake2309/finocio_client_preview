class Definition {
  // static const TOKEN_KEY = 'AUTH_TOKEN';
  static const DEVICE_INFO_KEY = 'DEVICE_INFO';
  static const ANDROID_PLATFORM = 'ANDROID';
  static const IOS_PLATFORM = 'IOS';
  static const UNKNOW_PLATFORM = 'UNKNOW';
  static const CHANNEL_CRYPTO_MINI_DATA = 'crypto:mini_data';
  static const BINANCE_CHANNEL = 'crypto:binance';
  static const CHANNEL_VNSTOCK = 'stock:vn';
  static const int HTTP_REQUEST_TIMEOUT = 5;
}

class TechnicalInterval {
  static const MINUTE_1 = "1m";
  static const MINUTE_5 = "5m";
  static const MINUTE_15 = "15m";
  static const MINUTE_30 = "30m";
  static const HOUR_1 = "1H";
  static const HOUR_2 = "2H";
  static const HOUR_4 = "4H";
  static const HOUR_6 = "6H";
  static const HOUR_12 = "12H";
  static const DAY_1 = "1D";
  static const DAY_3 = "3D";
  static const WEEK_1 = "1W";
  static const MONTH_1 = "1M";
}

class ButtonCommand {
  static const TEXT_BUTTON = 'TEXT_BUTTON';
  static const TEXT_BUTTON_ICON = 'TEXT_BUTTON_ICON';
  static const OUTLINEED_BUTTON = 'OUTLINEED_BUTTON';
}

class LoginSource {
  static const ANONYMOUS = 'ANONYMOUS';
  static const GOOGLE = 'GOOGLE';
  static const FACEBOOK = 'FACEBOOK';
  static const APP = 'APP';
}

class Preferences {
  Preferences._();

  static const String is_logged_in = "isLoggedIn";
  static const String auth_token = "AUTH_TOKEN";
  static const String is_dark_mode = "is_dark_mode";
  static const String current_language = "current_language";
}

enum InputType { user_name, email, password, confirm_password }
