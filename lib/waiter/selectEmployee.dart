import 'package:flutter/material.dart';
import 'package:kikkomen_app/server_service.dart';
import 'package:kikkomen_app/waiter/waiter_page.dart';
import 'package:mysql1/mysql1.dart';

class SelectServerDialog extends StatelessWidget {

  SelectServerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchServers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No servers found.'));
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  'Select a Server',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1/3,
                  height: MediaQuery.of(context).size.height * 2/3,
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final server = snapshot.data![index];
                      final status = server['status'];
                      final empId = server['emp_id'];
                      final fullName = "${server['first_name']} ${server['last_name']}";
                
                      return ListTile(
                        title: Text(fullName),
                        subtitle: status == "On Shift" ? null : const Text("Off Shift"),
                        enabled: status != 'Off Shift',
                        onTap: status != 'Off Shift'
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WaiterPage(
                                      empId: empId,
                                    ),
                                  ),
                                );
                              }
                            : null,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchServers() async {
    
    final Results query = await ServerService.serverConnection.query(
      """
      SELECT DISTINCT emp_id, first_name, last_name, cur_pos, status 
      FROM employee 
      NATURAL JOIN emp_shift 
      WHERE cur_pos = 'Server';
      """
    );


    List<Map<String, dynamic>> servers = [];
    for (var row in query) {
      servers.add(row.fields);
    }

    return servers;
  }
}
