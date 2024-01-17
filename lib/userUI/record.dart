import 'package:flutter/material.dart';
import 'package:rehabilitation_app/UserUI/message.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:rehabilitation_app/UserUI/userinterface.dart';
import 'package:rehabilitation_app/register/userLogin.dart';
import 'package:rehabilitation_app/UserUI/personal.dart';
import 'package:rehabilitation_app/provider/UserIdProvider.dart';
import 'package:provider/provider.dart';
import 'package:rehabilitation_app/database/firbase_db.dart';
import 'package:rehabilitation_app/generated/l10n.dart';


class RecordPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<RecordPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;
  late List<String> _selectedEvents;
  bool _showDetails = false; // 控制底部弹出的显示与隐藏
  String _selectedFirstDateInfo = '';// 存储所选日期的信息
  String _selectedSecondDateInfo = '';// 存储所选日期的信息

  Db db = Db();
  String rehabId = "";

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ['事件 1', '事件 2'];
  }

  // 弹出底部详细信息的方法
  void _showBottomSheet(DateTime date) async {
    DateTime? firstDate = await db.readFirstRehab(rehabId: rehabId);
    DateTime? secondDate = await db.readSecondRehab(rehabId: rehabId);
    String firstDateInfo;
    String secondDateInfo;

    if (firstDate != null) {
      firstDateInfo = S.of(context).first_rehabilitation_session_time + ': $firstDate';

      if (secondDate != null) {
        secondDateInfo = S.of(context).second_rehabilitation_session_time + ': $secondDate';
      }else{
        secondDateInfo = 'On ${date.year}/${date.month}/${date.day}, ' + S.of(context).second_rehabilitation_is_not_completed_yet;
      }
    } else {
      firstDateInfo = 'On ${date.year}/${date.month}/${date.day}, ' + S.of(context).you_have_not_completed_rehabilitation_yet;
      secondDateInfo = 'null';
    }

    setState(() {
      _showDetails = true;
      _selectedFirstDateInfo = firstDateInfo;
      _selectedSecondDateInfo = secondDateInfo;
    });
  }


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
                //Navigator.push(context, MaterialPageRoute(builder: (context) => RecordPage()));// 点击了復健紀錄
              } else if (value == 3) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MessageListPage()));// 点击了訊息通知
              } else if (value == 4) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalDataPage()));// 点击了個人資料
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
          title: Text(S.of(context).record,
            style: TextStyle(fontSize: 20),
          ),
        ),
      body: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          if (selectedDay.isBefore(DateTime.now())) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              rehabId = '$userId${_selectedDay.year}${_selectedDay.month}${_selectedDay.day}';
            });
            _showBottomSheet(selectedDay); // 点击日历后弹出详细信息
          }
        },
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),

      // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add),
        //   onPressed: () {
        //     setState(() {
        //       if (_selectedEvents.length < 5) {
        //         _selectedEvents.add('新事件 ${_selectedEvents.length + 1}');
        //       }
        //     });
        //   },
        // ),
        // 底部弹出的详细信息
      bottomSheet: _showDetails
        ? Container(
          height: 250,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_selectedFirstDateInfo),
                SizedBox(height: 10),
                Text(_selectedSecondDateInfo != "null" ? _selectedSecondDateInfo : '',)
              ],
            ),
          ),
        )
          : null,
    );
  }
}
