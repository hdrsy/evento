// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class SocketService {
//   static void createSocketConnection() {
//     print("start  socket");
//     late IO.Socket socket;
//     socket = IO.io('ws://echo.websocket.org', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': true,
//       // 'query': {
//       //   'key': '3f325939858a7eb5c2f4',
//       //   'cluster': 'mt1',
//       //   // add other necessary parameters
//       // },
//     });
//     print(socket);
//     socket.connect();

//     socket.onConnect((_) {
//       print('Connected to Pusher');
//     });

//     socket.on('event-name', (data) {
//       print(data);
//       // Handle the received data
//     });

//     socket.onError((data) {
//       // Handle errors
//       print("error in socke :$data");
//     });
//   }

// void disconnect() {
//   if (socket.connected) {
//     socket.disconnect();
//   }
// }
// }
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';

Future<void> connectToServer() async {
  final String host = '94.141.219.16';
  final int port = 6001; // Replace with the port your server is listening on

  try {
    // final channel = WebSocketChannel.connect(
    //   Uri.parse('ws://94.141.219.16:6001'),
    // );

    // channel.stream.listen((message) {
    //   // Handle WebSocket messages
    //   print(message);
    // }, onError: (error) {
    //   // Handle errors
    //   print(error);
    // });
    // import 'package:web_socket_channel/web_socket_channel.dart';

    final channel = WebSocketChannel.connect(
      Uri.parse('ws://94.141.219.16:8000/ws2'),
    );
    print("channel$channel");
    channel.stream.listen((message) {
      // Handle incoming messages
      print(message);
    });

    // To send messages
    // channel.sink.add('Your Message');

    // final socket = await Socket.connect(host, port);
    // print("socket is:${socket}");
    // // Handle socket events
    // socket.listen(
    //   (data) {
    //     final message = utf8.decode(data);
    //     print('Received: $message');
    //   },
    //   onError: (error) {
    //     print('Error: $error');
    //     socket.close();
    //   },
    //   onDone: () {
    //     print('Connection closed');
    //     socket.destroy();
    //   },
    // );

    // // Send data to the server
    // final message = 'Hello, Server!';
    // socket.write(utf8.encode(message));

    // You can continue sending/receiving data as needed
  } catch (e) {
    print('Error: $e');
  }
}
