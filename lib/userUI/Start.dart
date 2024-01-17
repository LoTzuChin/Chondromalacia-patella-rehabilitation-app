import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:rehabilitation_app/database/firbase_db.dart';
import 'package:rehabilitation_app/provider/UserIdProvider.dart';
import 'package:provider/provider.dart';
import 'package:rehabilitation_app/userUI/userInterface.dart';
import 'package:rehabilitation_app/generated/l10n.dart';


class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int count = 50;
  bool _rehabCompleted = false;
  final firstController = TextEditingController();
  final secondController = TextEditingController();
  final rehab_idController = TextEditingController();

  Db db = Db();

  @override
  Widget build(BuildContext context) {
    var userIdProvider = Provider.of<UserIdProvider>(context);
    // 获取用户 ID
    var userId = userIdProvider.userId;
    String rehabId = '$userId${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(
          'Start Page',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/rehab2.gif'),
            SizedBox(height: 20),
            Text(
              "Secure the phone on the knee as shown in the illustration.\n During the rehabilitation process, keep the leg in an extended position.\n Perform 50 repetitions each session.\n Upon completion, a notification sound and vibration will occur as a reminder. \nPress the \"GO\" button when ready to proceed.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20),
            Text(
              '$count',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                // listenToGyroscope();
                if (await db.readRehabData(rehabId: rehabId) == false) {
                  await db.writeRehabData(id: userId);
                  doneMessage();
                } else {
                  await db.writeRehabSecondData(id: userId);
                  await doneMessage();
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                backgroundColor: Colors.deepOrange,
              ),
              child: Text('GO', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 20),
            // Text(
            //     _rehabCompleted ? '本次復健結束' : '',
            //   style: TextStyle(fontSize: 24), // Increase font size
            // ),
          ],
        ),
      ),
    );
  }


  void listenToGyroscope() {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      double x = event.x; // X 轴的值
      double y = event.y; // Y 轴的值
      double z = event.z; // Z 轴的值

      // 在这里处理陀螺仪的值，可以更新 UI 等操作
      print('Gyroscope values: X=$x, Y=$y, Z=$z');

      while(count <= 50){
        if (x > 0.5) {
          count++;
        }
      }
      _rehabCompleted = true;

      playSound();
      vibrate();
    });
    return;
  }

  void playSound() async{
    AudioPlayer player = AudioPlayer();
    player.play(AssetSource('audio/sound.mp3')); // 你的声音文件应该放在assets文件夹下
  }

  void vibrate() {
    Vibration.vibrate(duration: 500); // 以毫秒为单位的震动时长
  }

  Future<void> doneMessage() async {
    // 弹出复健完成的对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text('复健完成'),
          content: Text(S.of(context).rehabilitation_completed_for_this_session),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserInterfacePage()));// 关闭对话框
              },
              child: Text(S.of(context).comfirm),
            ),
          ],
        );
      },
    );
  }
}