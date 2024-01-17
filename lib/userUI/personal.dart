import 'package:flutter/material.dart';
import 'package:rehabilitation_app/UserUI/revise.dart';
import 'package:rehabilitation_app/UserUI/message.dart';
import 'package:rehabilitation_app/UserUI/record.dart';
import 'package:rehabilitation_app/UserUI/userinterface.dart';
import 'package:rehabilitation_app/database/firbase_db.dart';
import 'package:rehabilitation_app/register/userLogin.dart';
import 'package:rehabilitation_app/provider/UserIdProvider.dart';
import 'package:provider/provider.dart';
import 'package:rehabilitation_app/generated/l10n.dart';
import 'package:rehabilitation_app/database/firbase_db.dart';


class PersonalDataPage extends StatefulWidget {
  @override
  _PersonalDataPageState createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  Db db = Db();
  @override
  Widget build(BuildContext context) {
    var userIdProvider = Provider.of<UserIdProvider>(context);
    // 获取用户 ID
    var userId = userIdProvider.userId;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        leading: PopupMenuButton(
          icon: Icon(Icons.menu),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              padding: EdgeInsets.all(16.0), // 调整这里的内边距以增加间距
              child: ListTile(
                leading: Icon(Icons.home), // 添加图标
                title: Text(S.of(context).home, style: TextStyle(fontSize: 18)),
              ),
              value: 1,
            ),
            PopupMenuItem(
              padding: EdgeInsets.all(16.0), // 调整这里的内边距以增加间距
              child: ListTile(
                leading: Icon(Icons.description), // 添加不同的图标
                title: Text(S.of(context).record, style: TextStyle(fontSize: 18)),
              ),
              value: 2,
            ),
            PopupMenuItem(
              padding: EdgeInsets.all(16.0), // 调整这里的内边距以增加间距
              child: ListTile(
                leading: Icon(Icons.notifications), // 添加不同的图标
                title: Text(S.of(context).message, style: TextStyle(fontSize: 18)),
              ),
              value: 3,
            ),
            PopupMenuItem(
              padding: EdgeInsets.all(16.0), // 调整这里的内边距以增加间距
              child: ListTile(
                leading: Icon(Icons.person), // 添加不同的图标
                title: Text(S.of(context).person, style: TextStyle(fontSize: 18)),
              ),
              value: 4,
            ),
          ],
          onSelected: (value) {
            // 处理菜单项点击事件
            if (value == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserInterfacePage()));// 点击了首頁
            } else if (value == 2) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RecordPage()));// 点击了復健紀錄
            } else if (value == 3) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MessageListPage()));// 点击了訊息通知
            } else if (value == 4) {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalDataPage()));// 点击了個人資料// 点击了個人資料
            }
          },
        ),
        //leading: Icon(Icons.event_note),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => UserLoginPage()));
            },
          ),
        ],
        title: Text(S.of(context).person,
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: FutureBuilder<User?>(
        future: db.readUser(id: userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            return user == null
                ? Center(child: Text('No user'))
                : buildUser(user, () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ReviseDataPage()));
                    },
                  );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Widget buildUser(User user, VoidCallback onEditPressed) {
  bool isMale = user.gender;
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white70,
            radius: 60,
            backgroundImage: isMale
                ? AssetImage('assets/person/man.png')
                : AssetImage('assets/person/woman.png'),
          ),
          SizedBox(height: 40),

          Text(
            user.name,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          Text(
            "User ID:  " + user.id,
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(height: 30),
          Text(
            isMale ? 'gender:  male' : 'gender:  female',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(height: 30),
          Text(
            "birthday:  " + '${user.birth}',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: onEditPressed,
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(fontSize: 28), // Adjust the font size as needed
              backgroundColor: Colors.deepOrange,
            ),
            child: Text('Revise'),
          ),
        ],
      ),
    ),
  );
}
