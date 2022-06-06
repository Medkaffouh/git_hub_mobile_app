import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users'),),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1, color: Colors.teal,
                      )
                    )
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}