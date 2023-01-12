import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:stockolio/bloc/socketio/socketio_event.dart';
import 'package:stockolio/bloc/socketio/socketio_state.dart';
import 'package:stockolio/helpers/definitions.dart';
import 'package:stockolio/helpers/server_define.dart';
import 'package:stockolio/model/candle/ohlc.dart';
import 'package:stockolio/model/market/mini_ticker.dart';

class SocketIOBloc extends Bloc<SocketIOEvent, SocketIOState> {
  late Socket _socket;
  final _socketOHLCData = StreamController<OHLC>.broadcast();
  final _socketMiniTickerData = StreamController<MiniTicker>.broadcast();

  Stream<OHLC> get getOHLCResponse => _socketOHLCData.stream;
  Stream<MiniTicker> get getMiniTickerResponse => _socketMiniTickerData.stream;

  SocketIOBloc() : super(SocketIOStateInitial()) {
    // Socket initialize
    // IO.Socket socket = IO.io('http://localhost:3000');
    this._socket = io(
      ServerUri.FINO_SOCKET,
      OptionBuilder()
          .setTransports(['websocket'])
          .setTimeout(3000)
          .disableAutoConnect()
          .disableReconnection()
          .build(),
    );

    this._socket.onConnecting((data) => add(OnConnecting()));
    this
        ._socket
        .onConnect((data) => add(OnConnected('Connected websocket!!!')));
    this._socket.onConnectError((data) =>
        add(OnError(errMsg: 'Connect websocket error: ${data.toString()}')));
    this._socket.onError((data) => add(OnError(errMsg: data.toString())));
    this._socket.onConnectTimeout((data) => add(OnTimeout()));
    this._socket.onDisconnect((data) => add(OnDisconnect()));
    this._socket.onReconnect((data) => add(OnReconnect()));
    // this._socket.on('join', (data) => null);

    // Event register
    on<OnConnect>((event, emit) {
      emit(SocketIOStateConnecting());
      this._socket.connect();
    });
    on<OnConnecting>((event, emit) => emit(SocketIOStateConnecting()));
    on<OnConnected>(
        (event, emit) => emit(SocketIOStateConnected(event.connectedMsg)));
    on<OnSubcribe>((event, emit) {
      try {
        for (var i = 0; i < event.channelNames.length; i++) {
          print(
              'channel subcribe: ${'${Definition.BINANCE_CHANNEL}:${event.channelNames[i]}:4H'}');
          this._socket.on(
              '${Definition.BINANCE_CHANNEL}:${event.channelNames[i]}:4H',
              (jsonString) => {
                    // print(jsonString),
                    _socketOHLCData.sink.add(OHLC.fromString(jsonString)),
                  });
          this._socket.on(
              '${Definition.CHANNEL_CRYPTO_MINI_DATA}:${event.channelNames[i]}',
              (jsonString) => {
                    _socketMiniTickerData.sink
                        .add(MiniTicker.fromJson(jsonString)),
                    // _socketOHLCData.sink.add(OHLC.fromJson(jsonString)),
                  });
        }

        emit(SocketIOStateSubcribed(channelNames: event.channelNames));
      } catch (e) {
        print(e.toString());
        emit(SocketIOStateDisconnected());
        rethrow;
      }
    });
    on<OnReceiveSocketData>((event, emit) {});
    on<OnReconnect>((event, emit) {});
    on<OnDisconnect>((event, emit) {
      print('ws disconnected');
      emit(SocketIOStateDisconnected());
    });
    on<OnError>((event, emit) {
      print('ws connect error');
      print(event.errMsg);
      emit(SocketIOStateError(errMsg: event.errMsg));
    });
    on<OnTimeout>((event, emit) {
      print('ws timeout');
      emit(SocketIOStateTimedOut());
    });
  }

  @override
  Future<void> close() {
    _socket.dispose();
    _socketOHLCData.close();
    _socketMiniTickerData.close();
    return super.close();
  }
}
