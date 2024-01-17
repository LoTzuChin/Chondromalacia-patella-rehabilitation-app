import 'package:flutter/material.dart';
import 'package:rehabilitation_app/register/userLogin.dart';
import 'package:rehabilitation_app/userUI/record.dart';
import 'package:rehabilitation_app/UserUI/message.dart';
import 'package:rehabilitation_app/UserUI/personal.dart';
import 'package:rehabilitation_app/UserUI/Start.dart';
import 'package:rehabilitation_app/generated/l10n.dart';
import 'package:rehabilitation_app/provider/UserIdProvider.dart';
import 'package:provider/provider.dart';
import 'package:rehabilitation_app/database/firbase_db.dart';

DateTime? done;
class EditableCircleFrame extends StatefulWidget {
  @override
  _EditableCircleFrameState createState() => _EditableCircleFrameState();
}

class _EditableCircleFrameState extends State<EditableCircleFrame> {
  String displayText = ''; // 用于显示的文本


  @override
  void initState() {
    super.initState();
    updateDisplayText();
  }

  Future<void> updateDisplayText() async {
    var userIdProvider = Provider.of<UserIdProvider>(context, listen: false);
    var userId = userIdProvider.userId;
    String rehabId = '$userId${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}';
    Db db = Db();
    done = await db.readSecondRehab(rehabId: rehabId);

    if (await db.readSecondRehab(rehabId: rehabId) != null) {
      setState(() {
        displayText = S.of(context).today_rehabilitation_progress + "\n 2/2";
      });
    } else if (await db.readFirstRehab(rehabId: rehabId) != null) {
      setState(() {
        displayText = S.of(context).today_rehabilitation_progress + "\n 1/2";
      });
    } else {
      setState(() {
        displayText = S.of(context).today_rehabilitation_progress + "\n 0/2";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.deepOrangeAccent,
            width: 8.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              displayText,
              style: TextStyle(fontSize: 28),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


class UserInterfacePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(
          S.of(context).chondromalacia_patella_rehabilitation_system, //髕骨軟化症復健系統
          style: TextStyle(fontSize: 20),
        ),
        leading: PopupMenuButton(
          icon: Icon(Icons.menu),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              padding: EdgeInsets.all(16.0), // 调整这里的内边距以增加间距
              child: ListTile(
                leading: Icon(Icons.home), // 添加图标
                title: Text(S.of(context).home, style: TextStyle(fontSize: 18)), //'首頁'
              ),
              value: 1,
            ),
            PopupMenuItem(
              padding: EdgeInsets.all(16.0), // 调整这里的内边距以增加间距
              child: ListTile(
                leading: Icon(Icons.description), // 添加不同的图标
                title: Text(S.of(context).record, style: TextStyle(fontSize: 18)), //'復健紀錄'
              ),
              value: 2,
            ),
            PopupMenuItem(
              padding: EdgeInsets.all(16.0), // 调整这里的内边距以增加间距
              child: ListTile(
                leading: Icon(Icons.notifications), // 添加不同的图标
                title: Text(S.of(context).message, style: TextStyle(fontSize: 18)), //'訊息通知'
              ),
              value: 3,
            ),
            PopupMenuItem(
              padding: EdgeInsets.all(16.0), // 调整这里的内边距以增加间距
              child: ListTile(
                leading: Icon(Icons.person), // 添加不同的图标
                title: Text(S.of(context).person, style: TextStyle(fontSize: 18)),//'個人資料'
              ),
              value: 4,
            ),
          ],
          onSelected: (value) {
            // 处理菜单项点击事件
            if (value == 1) {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => UserInterfacePage()));// 点击了首頁
            } else if (value == 2) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RecordPage()));// 点击了復健紀錄
            } else if (value == 3) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MessageListPage()));// 点击了訊息通知
            } else if (value == 4) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalDataPage()));// 点击了個人資料
            }
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => UserLoginPage()));
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EditableCircleFrame(),
          SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () {
              if (done != null) {

              }else{
                Navigator.push(context, MaterialPageRoute(builder: (context) => StartPage()));// 处理 START 按钮点击事件// 如果条件不满足，什么都不做
              }
            },
            icon: Icon(Icons.play_arrow),
            label: Text(
              'START',
              style: TextStyle(fontSize: 42),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
            ),
          ),
        ],
      ),
    );
  }
}
