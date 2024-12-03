import 'package:mysql1/mysql1.dart';

class ServerService {
  static var serverConnection;

  static void establishConnection() async {
    serverConnection = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'password',
      db: 'sushi'
    ));
    print("success!");
    print(serverConnection);
  }
}