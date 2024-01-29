import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart'; // For WebSocket connection on mobile devices

WebSocketChannel channel = IOWebSocketChannel.connect(
    'ws://94.141.219.16:8000/ws2',
    headers: {'Connection': 'upgrade', 'Upgrade': 'websocket'});

class Ttttttttttttttttt extends StatefulWidget {
  const Ttttttttttttttttt({super.key});

  @override
  State<Ttttttttttttttttt> createState() => _TttttttttttttttttState();
}

class _TttttttttttttttttState extends State<Ttttttttttttttttt> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: channel.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          // Handle incoming WebSocket data
          return Text('Received: ${snapshot.data}');
        } else if (snapshot.hasError) {
          // Handle error
          return Text('Error: ${snapshot.error}');
        } else {
          // Connection state is connecting or none, show loading or initial state
          return CircularProgressIndicator();
        }
      },
    );
  }
}
