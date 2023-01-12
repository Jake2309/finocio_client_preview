// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../entity/k_entity.dart';

class KLineEntity extends KEntity with EquatableMixin {
  late double open;
  late double high;
  late double low;
  late double close;
  late double vol;
  double? amount;
  double? change;
  double? ratio;
  int? time;
  KLineEntity({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.vol,
    this.amount,
    this.change,
    this.ratio,
    this.time,
  });

  KLineEntity.fromCustom({
    this.amount,
    required this.open,
    required this.close,
    this.change,
    this.ratio,
    required this.time,
    required this.high,
    required this.low,
    required this.vol,
  });

  // KLineEntity.fromJson(Map<String, dynamic> json) {
  //   open = (json['open'] as num)?.toDouble();
  //   high = (json['high'] as num)?.toDouble();
  //   low = (json['low'] as num)?.toDouble();
  //   close = (json['close'] as num)?.toDouble();
  //   vol = (json['vol'] as num)?.toDouble();
  //   amount = (json['amount'] as num)?.toDouble();
  //   time = (json['time'] as num)?.toInt();
  //   //兼容火币数据
  //   if (time == null) {
  //     time = ((json['id'] as num)?.toInt());
  //     if (time != null) {
  //       time *= 1000;
  //     }
  //   }
  //   ratio = (json['ratio'] as num)?.toDouble();
  //   change = (json['change'] as num)?.toDouble();
  // }

  KLineEntity.clone(KLineEntity entity) {
    // print(entity.toString());
    // ratio = entity.ratio;
    // change = entity.change;
    vol = entity.vol;
    amount = entity.amount;
    maValueList = entity.maValueList;
    macd = entity.macd;
    dif = entity.dif;
    dea = entity.dea;
    mb = entity.mb;
    dn = entity.dn;
    up = entity.up;
    rsi = entity.rsi;
    k = entity.k;
    low = entity.low;
    high = entity.high;
    open = entity.open;
    close = entity.close;
    // d = entity.d;
    j = entity.j;
    r = entity.r;
    // w = entity.w;
    BOLLMA = entity.BOLLMA;
    MA5Volume = entity.MA5Volume;
    MA10Volume = entity.MA10Volume;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['time'] = this.time;
  //   data['open'] = this.open;
  //   data['close'] = this.close;
  //   data['high'] = this.high;
  //   data['low'] = this.low;
  //   data['vol'] = this.vol;
  //   data['amount'] = this.amount;
  //   data['ratio'] = this.ratio;
  //   data['change'] = this.change;
  //   return data;
  // }

  // @override
  // String toString() {
  //   return 'MarketModel{open: $open, high: $high, low: $low, close: $close, vol: $vol, time: $time, amount: $amount, ratio: $ratio, change: $change}';
  // }

  @override
  List<Object> get props {
    return [
      open,
      high,
      low,
      close,
      vol,
    ];
  }

  KLineEntity copyWith({
    double? open,
    double? high,
    double? low,
    double? close,
    double? vol,
    double? amount,
    double? change,
    double? ratio,
    int? time,
  }) {
    return KLineEntity(
      open: open ?? this.open,
      high: high ?? this.high,
      low: low ?? this.low,
      close: close ?? this.close,
      vol: vol ?? this.vol,
      amount: amount ?? this.amount,
      change: change ?? this.change,
      ratio: ratio ?? this.ratio,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'open': open,
      'high': high,
      'low': low,
      'close': close,
      'vol': vol,
      'amount': amount,
      'change': change,
      'ratio': ratio,
      'time': time,
    };
  }

  factory KLineEntity.fromMap(Map<String, dynamic> map) {
    return KLineEntity(
      open: map['open'] as double,
      high: map['high'] as double,
      low: map['low'] as double,
      close: map['close'] as double,
      vol: map['vol'] as double,
      amount: map['amount'] != null ? map['amount'] as double : null,
      change: map['change'] != null ? map['change'] as double : null,
      ratio: map['ratio'] != null ? map['ratio'] as double : null,
      time: map['time'] != null ? map['time'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory KLineEntity.fromJson(String source) =>
      KLineEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
