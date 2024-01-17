import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rehabilitation_app/animation/FadeAnimation.dart';
import 'package:rehabilitation_app/database/firbase_db.dart';
import 'package:rehabilitation_app/register/signup.dart';
import 'package:rehabilitation_app/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rehabilitation_app/userUI/userInterface.dart';
import 'package:rehabilitation_app/provider/UserIdProvider.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({Key? key}) : super(key: key);
  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final IdController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userIdProvider = Provider.of<UserIdProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeAnimation(1, const Text("Login", style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ))),
                      SizedBox(height: 20,),
                      FadeAnimation(1.2, const Text("Login to your account", style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ))),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      FadeAnimation(1.2,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: TextField(
                              controller: IdController,
                              maxLength: 10,
                              // onChanged: (value) {
                              //   id = value;
                              // },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: S.of(context).your_id, //'輸入手機號碼'
                                counterText: "",
                                prefixIcon: Icon(
                                  Icons.perm_identity,
                                  color: Colors.grey //Theme.of(context).primaryColor,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey //Theme.of(context).primaryColor,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, //Theme.of(context).primaryColor,
                                      width: 2.0
                                  ),
                                ),
                                //errorText: phoneErrorText,
                              ),
                            ),
                          )
                      ),
                      SizedBox(height: 16), // 添加垂直間隔
                      FadeAnimation(1.3,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: TextField(
                              controller: passwordController,
                              // onChanged: (value) {
                              //   password = value;
                              // },
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: S.of(context).your_password, //'輸入密碼'
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.grey //Theme.of(context).primaryColor,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey //Theme.of(context).primaryColor,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, //Theme.of(context).primaryColor,
                                      width: 2.0
                                  ),
                                ),
                                //errorText: passwordErrorText,
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                  FadeAnimation(1.4, Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          )
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          final password = passwordController.text;
                          final id = IdController.text;
                          userIdProvider.setUserId(id);

                          loginUser(id: id, password: password); // 調用 handleLogin 函數
                        },
                        color: Colors.greenAccent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: Text("Login", style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                        ),),
                      ),
                    ),
                  )), //Login bottom
                  FadeAnimation(1.5, Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));// 在此處添加導航到註冊頁面的程式碼
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.blueAccent, // 可以根據需要更改文本顏色
                          ),
                        ),
                      ),
                    ],
                  )) //sign up bottom
                ],
              ),
            ),
            FadeAnimation(1.2, Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/background.png'),
                      fit: BoxFit.cover
                  ),
                )) //裝飾圖片
            )],
        ),
      ),
    );
  }


  Future<void> loginUser({required String id, required String password}) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc(id);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      final user = User.fromJson(snapshot.data()!);

      // 比對密碼是否正確
      if (user.password == password) {
        // 登入成功，導航到 UserPage
        Navigator.push(context, MaterialPageRoute(builder: (context)=> UserInterfacePage()),);
      } else {
        // 顯示密碼錯誤的 SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).wrong_password),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      // 顯示使用者不存在的 SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).User_does_not_exist),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

}
