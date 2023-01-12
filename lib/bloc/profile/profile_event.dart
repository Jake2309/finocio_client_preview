import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ProfileEvent extends Equatable {}

class ProfileStarted extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class ProfileFetchData extends ProfileEvent {
  final String symbol;
  ProfileFetchData({required this.symbol});
  @override
  List<Object> get props => [symbol];
}
