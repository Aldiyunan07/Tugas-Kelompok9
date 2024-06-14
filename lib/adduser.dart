import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  Future<void> _addUser(String name, String job) async {
    final response = await http.post(
      Uri.parse('https://reqres.in/api/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'job': job,
      }),
    );

    if (response.statusCode == 201) {
      // Jika berhasil menambah user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Berhasil menambahkan user')),
      );
      Navigator.pop(context);
    } else {
      // Jika gagal menambah user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambahkan user')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Nama';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _jobController,
                decoration: InputDecoration(labelText: 'Pekerjaan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukan Pekerjaan';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addUser(_nameController.text, _jobController.text);
                  }
                },
                child: Text('Tambah User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}