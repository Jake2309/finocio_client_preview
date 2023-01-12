// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class DeviceInfo extends Equatable {
  final String id;
  final String platform;
  final String? version;
  final String? board;
  final String? brand;
  final String? device;
  final String? display;
  final String? fingerprint;
  final String? hardware;
  final String? host;
  final String? manufacturer;
  final String? model;
  final String? product;
  DeviceInfo({
    required this.id,
    required this.platform,
    this.version,
    this.board,
    this.brand,
    this.device,
    this.display,
    this.fingerprint,
    this.hardware,
    this.host,
    this.manufacturer,
    this.model,
    this.product,
  });

  DeviceInfo copyWith({
    String? id,
    String? platform,
    String? version,
    String? board,
    String? brand,
    String? device,
    String? display,
    String? fingerprint,
    String? hardware,
    String? host,
    String? manufacturer,
    String? model,
    String? product,
  }) {
    return DeviceInfo(
      id: id ?? this.id,
      platform: platform ?? this.platform,
      version: version ?? this.version,
      board: board ?? this.board,
      brand: brand ?? this.brand,
      device: device ?? this.device,
      display: display ?? this.display,
      fingerprint: fingerprint ?? this.fingerprint,
      hardware: hardware ?? this.hardware,
      host: host ?? this.host,
      manufacturer: manufacturer ?? this.manufacturer,
      model: model ?? this.model,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'platform': platform,
      'version': version,
      'board': board,
      'brand': brand,
      'device': device,
      'display': display,
      'fingerprint': fingerprint,
      'hardware': hardware,
      'host': host,
      'manufacturer': manufacturer,
      'model': model,
      'product': product,
    };
  }

  factory DeviceInfo.fromMap(Map<String, dynamic> map) {
    return DeviceInfo(
      id: map['id'] as String,
      platform: map['platform'] as String,
      version: map['version'] as String,
      board: map['board'] as String,
      brand: map['brand'] as String,
      device: map['device'] as String,
      display: map['display'] as String,
      fingerprint: map['fingerprint'] as String,
      hardware: map['hardware'] as String,
      host: map['host'] as String,
      manufacturer: map['manufacturer'] as String,
      model: map['model'] as String,
      product: map['product'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceInfo.fromJson(String source) =>
      DeviceInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      platform,
      version!,
      board!,
      brand!,
      device!,
      display!,
      fingerprint!,
      hardware!,
      host!,
      manufacturer!,
      model!,
      product!,
    ];
  }
}
