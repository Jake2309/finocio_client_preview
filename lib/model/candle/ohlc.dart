// ignore_for_file: public_member_api_docs, sort_constructors_first
class OHLC {
  String symbol;

  /// <summary>
  /// Tgian bắt đầu 1 nến dạng Unix time
  /// </summary>
  int startTime;

  /// <summary>
  /// Tgian kết thúc 1 nến dạng Unix time
  /// </summary>
  int endTime;

  /// <summary>
  /// Time range: 1m, 5m, 1h, 2h, ....
  /// </summary>
  String interval;

  /// <summary>
  /// Giá mở cửa
  /// </summary>
  double open;

  /// <summary>
  /// Giá cao nhất
  /// </summary>
  double high;

  /// <summary>
  /// Giá thấp nhất
  /// </summary>
  double low;

  /// <summary>
  /// Giá đóng cửa
  /// </summary>
  double close;

  /// <summary>
  /// Giá thay đổi
  /// </summary>
  double change;

  /// <summary>
  /// % thay đổi
  /// </summary>
  double changePercent;

  /// <summary>
  /// Volume dựa trên tài sản giao dịch
  /// Ví dụ: cặp BTC/USDT => Base volume = volume BTC
  /// </summary>
  double baseVolume;

  /// <summary>
  /// Volume dựa trên tài sản trao đổi
  /// Ví dụ: cặp BTC/USDT => Quote volume = volume USDT
  /// </summary>
  double quoteVolume;

  /// <summary>
  /// Xác định nến này đã đóng hay chưa
  /// Để xác định so sánh End_Time vs thời gian hiện tại
  /// </summary>
  // bool IsKlineClose ;

  /// <summary>
  /// Số lượng giao dịch khớp lệnh trong 1 interval
  /// </summary>
  int trades;

  /// <summary>
  /// Taker buy base asset volume
  /// Volume giao dịch lệnh Market Order dựa trên Asset Volume
  /// </summary>
  double takerBuyAssetVolume;

  /// <summary>
  /// Taker buy quote asset volume
  /// Volume giao dịch lệnh Market Order dựa trên Quote Volume
  /// </summary>
  double takerBuyAssetQuoteVolume;
  OHLC({
    required this.symbol,
    required this.startTime,
    required this.endTime,
    required this.interval,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.change,
    required this.changePercent,
    required this.baseVolume,
    required this.quoteVolume,
    required this.trades,
    required this.takerBuyAssetVolume,
    required this.takerBuyAssetQuoteVolume,
  });

  factory OHLC.fromJson(Map<String, dynamic> json) {
    return OHLC(
      symbol: json['symbol'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      interval: json['interval'],
      open: json['open'],
      high: json['high'],
      low: json['low'],
      close: json['close'],
      change: json['change'],
      changePercent: json['changePercent'],
      trades: json['trades'],
      quoteVolume: json['quoteVolume'],
      baseVolume: json['baseVolume'],
      takerBuyAssetVolume: json['takerBuyAssetVolume'],
      takerBuyAssetQuoteVolume: json['takerBuyAssetQuoteVolume'],
    );
  }

  factory OHLC.fromString(String message) {
    var dataArr = message.split(';');
    return OHLC(
      symbol: dataArr[0],
      interval: dataArr[1],
      startTime: int.parse(dataArr[2]),
      endTime: int.parse(dataArr[3]),
      open: double.parse(dataArr[4]),
      high: double.parse(dataArr[5]),
      low: double.parse(dataArr[6]),
      close: double.parse(dataArr[7]),
      change: double.parse(dataArr[8]),
      changePercent: double.parse(dataArr[9]),
      baseVolume: double.parse(dataArr[10]),
      quoteVolume: double.parse(dataArr[11]),
      trades: int.parse(dataArr[12]),
      takerBuyAssetVolume: double.parse(dataArr[13]),
      takerBuyAssetQuoteVolume: double.parse(dataArr[14]),
    );
  }
}
