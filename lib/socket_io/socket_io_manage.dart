import 'dart:async';
import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:stockolio/model/candle/ohlc.dart';
import 'package:stockolio/model/market/mini_ticker.dart';

class SocketIOManage {
  final _socketOHLCData = StreamController<OHLC>.broadcast();
  final _socketMiniTickerData = StreamController<MiniTicker>.broadcast();

  Stream<OHLC> get getResponse => _socketOHLCData.stream;
  Stream<MiniTicker> get getMiniTickerResponse => _socketMiniTickerData.stream;

  void dispose() {
    _socketOHLCData.close();
    _socketMiniTickerData.close();
  }

  void handleMessage(String message) {
    // print(message);
    _socketOHLCData.sink.add(OHLC.fromString(message));

    // print('message: ${_socketResponse.stream.length}');
  }

  void handleMiniTickerMessage(Map<dynamic, dynamic> json) {
    // print(json);
    // _socketMiniTickerData.sink.add(MiniTicker.fromJson(json));

    // print('message: ${_socketResponse.stream.length}');
  }
}

//STEP2: Add this function in main function in main.dart file and add incoming data to the stream
void connectAndListen(SocketIOManage socketIOManage) {
  // IO.Socket socketIOClient = io(
  //     'http://127.0.0.1:3000',
  //     OptionBuilder()
  //         .setTransports(['websocket']) // for Flutter or Dart VM
  //         .disableAutoConnect() // disable auto-connection
  //         .build());

  IO.Socket socketIOClient = IO.io('http://127.0.0.1:3000',
      OptionBuilder().setTransports(['websocket']).build());

  // Connect to websocket
  // socketIOClient.connect();

  socketIOClient.onConnect((_) {
    print('socket client connected!!!');
    print(socketIOClient.id);
  });

  //When an event recieved from server, data is added to the stream
  // Channel mini_tiker de nhan message o portfolio
  socketIOClient.on('mini_data',
      (data) => socketIOManage.handleMiniTickerMessage(jsonDecode(data)));

  // Channel theo tung symbol de ve chart
  // socketIOClient.on('crypto:binance:BTCUSDT:5m',
  //     (data) => socketIOManage.handleMessage(data));

  // socketIOClient.on('message', (data) => handleMessage('message', data));
  socketIOClient.onDisconnect((_) => print('disconnect'));
}
