import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {}

class NewsInitital extends NewsEvent {
  @override
  List<Object?> get props => [];
}

class FetchNewsData extends NewsEvent {
  final List<String> symbols;

  FetchNewsData({required this.symbols});

  @override
  List<Object?> get props => [symbols];
}
