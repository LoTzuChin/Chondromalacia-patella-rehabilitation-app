import 'package:flutter/material.dart';
import 'package:rehabilitation_app/register/userLogin.dart';
import 'package:rehabilitation_app/UserUI/userinterface.dart';
import 'package:rehabilitation_app/UserUI/record.dart';
import 'package:rehabilitation_app/UserUI/personal.dart';
import 'package:rehabilitation_app/generated/l10n.dart';

/// @Author wywinstonwy
/// @Date 2022/1/19 10:46 下午
/// @Description:

class MessageListPage extends StatefulWidget {
  const MessageListPage({Key? key}) : super(key: key);
  @override
  _MyScrollControllerState createState() => _MyScrollControllerState();
}

class _MyScrollControllerState extends State<MessageListPage> {
  final ScrollController _controller = ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      //打印滚动位置
      print(_controller.offset);
      if (_controller.offset < 50 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 50 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }
  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
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
                title: Text('首頁', style: TextStyle(fontSize: 18)),
              ),
              value: 1,
            ),
            PopupMenuItem(
              padding: EdgeInsets.all(16.0), // 调整这里的内边距以增加间距
              child: ListTile(
                leading: Icon(Icons.description), // 添加不同的图标
                title: Text('復健紀錄', style: TextStyle(fontSize: 18)),
              ),
              value: 2,
            ),
            PopupMenuItem(
              padding: EdgeInsets.all(16.0), // 调整这里的内边距以增加间距
              child: ListTile(
                leading: Icon(Icons.notifications), // 添加不同的图标
                title: Text('訊息通知', style: TextStyle(fontSize: 18)),
              ),
              value: 3,
            ),
            PopupMenuItem(
              padding: EdgeInsets.all(16.0), // 调整这里的内边距以增加间距
              child: ListTile(
                leading: Icon(Icons.person), // 添加不同的图标
                title: Text('個人資料', style: TextStyle(fontSize: 18)),
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
              //Navigator.push(context, MaterialPageRoute(builder: (context) => MessageListPage()));// 点击了訊息通知
            } else if (value == 4) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalDataPage()));// 点击了個人資料// 点击了個人資料
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
        title: Text(S.of(context).message,
          style: TextStyle(fontSize: 20),
        ),
      ),
      //body: _buildScollbar(),
      body: Container(
        child: ListView.builder(
            itemCount: 2,
            itemBuilder:(BuildContext context,int index){
              return ListTile(
                title: const Text("官方通知"),
                subtitle: Container(
                  alignment: Alignment.bottomCenter,
                  height: 25,
                  padding: const EdgeInsets.only(right: 5),
                  child: const Text("今天還沒完成復健喔！",overflow: TextOverflow.ellipsis,),
                ),
                //头像
                leading: Container(
                  width: 45,height: 45,//宽高
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),//圆角
                    image: const DecorationImage(image:AssetImage("assets/message.png"))
                  ),
                ),
              );
            }
        ),
      ),
      floatingActionButton: showToTopBtn==false?null:FloatingActionButton(
        onPressed: (){
          //返回到顶部时候执行动画
          _controller.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
        },
        child: const Icon(Icons.arrow_upward),),
    );
  }
// _buildScollbar(){
//   return Scrollbar(
//       child: ListView.builder(
//           controller: _controller,
//           itemCount: 100,
//           itemExtent: 44,
//           itemBuilder: (context,index){
//             return ListTile(title: Text('$index'),);
//           })
//   );
// }
}