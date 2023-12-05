import 'package:socket_io_client/socket_io_client.dart';
import 'package:talk_to_me/constants.dart';

class SocketService {
  Socket socket = io("http://$kIp:3000", {
    "transports": ["websocket"],
    'autoConnect': false,
  });

  void startConnection() {
    socket.connect();
  }

  void sendEvent(String event,[dynamic data]) {
    socket.emit(event,data);
  }

  void recieveEvent(String event,Function(dynamic data) callBack) {
    socket.on(event, callBack);
  }
}
