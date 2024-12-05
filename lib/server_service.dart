import 'package:mysql1/mysql1.dart';

class ServerService {
  static late MySqlConnection serverConnection;

  static Future<void> establishConnection() async {
//    await Future.delayed(Duration(seconds: 2));
    serverConnection = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'password',
      db: 'sushi'
    ));
    print("success!");
  }

  // static Iterable<Future<Map>> makeQuery() {
  //   final queryResult = serverConnection.query('SELECT * FROM dish');
  //   for row in result
  // } 
}