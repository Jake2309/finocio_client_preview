import 'package:equatable/equatable.dart';
import 'package:stockolio/library/k_chart_library/renderer/base_chart_painter.dart';

abstract class SocketIOState extends Equatable {}

class SocketIOStateInitial extends SocketIOState {
  @override
  List<Object> get props => [];
}

class SocketIOStateConnecting extends SocketIOState {
  @override
  List<Object> get props => [];
}

class SocketIOStateConnected extends SocketIOState {
  final String connectedMsg;
  SocketIOStateConnected(this.connectedMsg);
  @override
  List<Object> get props => [this.connectedMsg];
}

class SocketIOStateJoinedChannel extends SocketIOState {
  final String channelName;
  final dynamic receiveData;
  SocketIOStateJoinedChannel(
      {required this.channelName, required this.receiveData});
  @override
  List<Object> get props => [this.channelName, this.receiveData];
}

class SocketIOStateSubcribed extends SocketIOState {
  final List<String> channelNames;
  SocketIOStateSubcribed({required this.channelNames});
  @override
  List<Object> get props => [channelNames];
}

class SocketIOStateDisconnected extends SocketIOState {
  @override
  List<Object> get props => [];
}

class SocketIOStateError extends SocketIOState {
  final String errMsg;
  SocketIOStateError({required this.errMsg});
  @override
  List<Object> get props => [this.errMsg];
}

class SocketIOStateTimedOut extends SocketIOState {
  @override
  List<Object> get props => [];
}
