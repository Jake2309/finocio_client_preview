import 'package:equatable/equatable.dart';
import 'package:stockolio/library/k_chart_library/renderer/base_chart_painter.dart';

abstract class SocketIOEvent extends Equatable {}

class OnConnect extends SocketIOEvent {
  @override
  List<Object> get props => [];
}

class OnConnecting extends SocketIOEvent {
  @override
  List<Object> get props => [];
}

class OnConnected extends SocketIOEvent {
  final String connectedMsg;
  OnConnected(this.connectedMsg);
  @override
  List<Object> get props => [connectedMsg];
}

class OnReconnect extends SocketIOEvent {
  @override
  List<Object> get props => [];
}

class OnSubcribe extends SocketIOEvent {
  final List<String> channelNames;
  OnSubcribe({required this.channelNames});
  @override
  List<Object> get props => [this.channelNames];
}

class OnReceiveSocketData extends SocketIOEvent {
  final dynamic receivedData;
  OnReceiveSocketData({required this.receivedData});
  @override
  List<Object> get props => [this.receivedData];
}

class OnDisconnect extends SocketIOEvent {
  @override
  List<Object> get props => [];
}

class OnError extends SocketIOEvent {
  final String errMsg;
  OnError({required this.errMsg});
  @override
  List<Object> get props => [errMsg];
}

class OnTimeout extends SocketIOEvent {
  @override
  List<Object> get props => [];
}
