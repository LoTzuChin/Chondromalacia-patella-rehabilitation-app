import 'package:flutter/material.dart';
import 'package:rehabilitation_app/UserUI/personal.dart';
import 'package:rehabilitation_app/provider/UserIdProvider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviseDataPage extends StatefulWidget {
  @override
  _ReviseDataPageState createState() => _ReviseDataPageState();
}



class _ReviseDataPageState extends State<ReviseDataPage> {
  late TextEditingController _nameController;
  late TextEditingController _genderController;
  late TextEditingController _birthdayController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;


  @override
  void initState() {
    super.initState();
    // Initialize controllers with the existing user data
    _nameController = TextEditingController();
    _genderController = TextEditingController();
    _birthdayController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var userIdProvider = Provider.of<UserIdProvider>(context);
    // 获取用户 ID
    var userId = userIdProvider.userId;
    final docUser = FirebaseFirestore.instance.collection('user').doc(userId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(
          '修改個人資料',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '姓名'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _genderController,
              decoration: InputDecoration(labelText: '性別'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _birthdayController,
              decoration: InputDecoration(labelText: '生日'),
            ),
            // SizedBox(height: 20),
            // TextField(
            //   controller: _phoneController,
            //   decoration: InputDecoration(labelText: '手機'),
            // ),
            // SizedBox(height: 20),
            // TextField(
            //   controller: _emailController,
            //   decoration: InputDecoration(labelText: 'Email'),
            // ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Save the updated data
                // For simplicity, you can update the existing user object directly
                String namevalue = _nameController.text;
                docUser.update({'name': namevalue});
                // widget.user.gender = _genderController.text;
                // widget.user.birthday = _birthdayController.text;
                // widget.user.phone = _phoneController.text;
                // widget.user.email = _emailController.text;

                // Navigate back to the previous page
                Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalDataPage()));
              },
              child: Text('儲存修改'),
            ),
          ],
        ),
      ),
    );
  }
}