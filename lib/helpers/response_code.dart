class ResponseCode {
  static const int GOOGLE_ACCOUNT_EXIST_WITH_DIFFERENCE_CREDENTICAL = 300;
  static const int GOOGLE_ACCOUNT_INVALID_CREDENTICAL = 301;
  static const int UNKNOW_ERROR = 999;

  /// <summary>
  /// Thành công
  /// </summary>
  static const int OK = 200;

  /// <summary>
  /// Xuất hiện lỗi trong logic xử lý của service
  /// </summary>
  static const int SYS_GENERIC_ERROR = 1;

  /// <summary>
  /// Request không được phản hồi lại sau thời gian expected
  /// </summary>
  static const int TIMEOUT = 2;

  /// <summary>
  /// Tham số truyền vào cho service không hợp lệ
  /// </summary>
  static const int INVALID_PARAMETER = 3;

  /// <summary>
  /// Không có đủ quyền gọi đến function trong service
  /// </summary>
  static const int UNAUTHORIZED = 4;

  /// <summary>
  /// Token expired
  /// </summary>
  static const int TOKEN_INVALID = 5;

  /// <summary>
  /// Token expired
  /// </summary>
  static const int TOKEN_EXPIRED = 6;

  /// <summary>
  /// Record not found
  /// </summary>
  static const int RECORD_NOT_FOUND = 7;

  /// <summary>
  /// Duplicate entry
  /// </summary>
  static const int DUPLICATE_ENTRY = 8;

  /// <summary>
  /// Dữ liệu hệ thống không chính xác, không thể xử lý tiếp
  /// </summary>
  static const int INVALID_DATA = 9;

  /// <summary>
  /// Dữ liệu hệ thống không cho phép thực hiện yêu cầu
  /// </summary>
  static const int REQUEST_NOT_ALLOWED = 10;

  /// <summary>
  /// Dữ liệu tạm khóa
  /// </summary>
  static const int LOCK_DATA = 11;

  /// <summary>
  /// Giới hạn dữ liệu
  /// </summary>
  static const int LIMIT_ACCESS = 12;

  static bool isOk(int code) => OK == code;

  static bool isNotOk(int code) {
    return OK != code;
  }
}
