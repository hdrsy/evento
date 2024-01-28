import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static void createSocketConnection() {
    print("start  socket");
    late IO.Socket socket;
    socket = IO.io('http://94.141.219.16:6001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      // 'query': {
      //   'key': '3f325939858a7eb5c2f4',
      //   'cluster': 'mt1',
      //   // add other necessary parameters
      // },
    });
    print(socket);
    socket.connect();

    socket.onConnect((_) {
      print('Connected to Pusher');
    });

    socket.on('event-name', (data) {
      print(data);
      // Handle the received data
    });

    socket.onError((data) {
      // Handle errors
      print("error in socke :$data");
    });
  }

  // void disconnect() {
  //   if (socket.connected) {
  //     socket.disconnect();
  //   }
  // }
}
