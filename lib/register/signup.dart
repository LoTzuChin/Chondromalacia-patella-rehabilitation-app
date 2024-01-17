import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rehabilitation_app/animation/FadeAnimation.dart';
import 'package:rehabilitation_app/register/userLogin.dart';
import 'package:rehabilitation_app/generated/l10n.dart';
import 'package:rehabilitation_app/userUI/userInterface.dart';
import 'package:rehabilitation_app/database/firbase_db.dart';
import 'package:rehabilitation_app/provider/UserIdProvider.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
const SignupPage({super.key});
@override
State<SignupPage> createState() => _RegistPageState();
}

class _RegistPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final IdController = TextEditingController();
  final passwordController = TextEditingController();
  final comfirm_passwordController = TextEditingController();
  final genderController = TextEditingController();
  final birthdayController = TextEditingController();


  Db db = Db();

  String? name;
  bool _gender = false;
  DateTime? _birthday = DateTime.now();
  String? id;
  String? password;
  String? comfirm_password;
  String? idErrorText;
  String? passwordErrorText;


  @override
  Widget build(BuildContext context) {
    var userIdProvider = Provider.of<UserIdProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => UserLoginPage()));
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ), systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 70,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeAnimation(1, Text("Sign up", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),)),
                  SizedBox(height: 20,),
                  FadeAnimation(1.2, Text("Create an account, It's free", style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700]
                  ),)),
                ],
              ),
              Column(
                children: <Widget>[
                FadeAnimation(
                  1.2,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: TextField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.drive_file_rename_outline),
                        labelText: S.of(context).name, //'名字'
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                        // errorText: phoneErrorText,
                      ),
                      // onChanged: (value) {
                      //   setState(() {
                      //     name = value;
                      //   });
                      // },
                    ),
                  ),
                ), //name
                FadeAnimation(
                  1.2,
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.transgender),
                            labelText: S.of(context).gender, //'性別'
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: const OutlineInputBorder(),
                          ),
                          items: [
                            DropdownMenuItem(
                              child: Text('Male'),
                              value: 'male',
                            ),
                            DropdownMenuItem(
                              child: Text('Female'),
                              value: 'female',
                            ),
                          ],
                          onChanged: (value) {
                            if(value == 'male'){
                              setState(() {
                                _gender = true;
                              });
                            } else{
                              setState(() {
                                _gender = false;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ), //gender
                FadeAnimation(
                  1.3,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: TextField(
                      controller: birthdayController, // 使用 controller
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.drive_file_rename_outline),
                        labelText: S.of(context).birthday, //'生日'
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                        // errorText: phoneErrorText,
                      ),
                      onChanged: (value) {
                        // 这里可以处理输入值的逻辑
                      },
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null && pickedDate != _birthday) {
                          setState(() {
                            _birthday = pickedDate;
                            birthdayController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                          });
                        }
                      },
                    ),
                  ),
                ), //birthday
                FadeAnimation(
                  1.3,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: TextField(
                      //maxLength: 8,
                      controller: IdController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.drive_file_rename_outline),
                        labelText: S.of(context).id, //'id'
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                        // errorText: phoneErrorText,
                      ),
                    ),
                  ),
                ), //id
                FadeAnimation(
                  1.4,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.drive_file_rename_outline),
                        labelText: S.of(context).password, //'password'
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                        // errorText: phoneErrorText,
                      ),
                    ),
                  ),
                ), //password
                FadeAnimation(
                  1.4,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.drive_file_rename_outline),
                        labelText: S.of(context).comfirm_password, //'comfirm_password'
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                        // errorText: phoneErrorText,
                      ),
                      onChanged: (value) {
                        setState(() {
                          comfirm_password = value;
                        });
                      },
                    ),
                  ),
                ), //confirm_password
                //FadeAnimation(1.2, makeInput(label: S.of(context).name)),
                //FadeAnimation(1.2, makeInput(label: S.of(context).gender, isDropdown:true)),
                //FadeAnimation(1.3, makeInput(label: S.of(context).birthday, hasDatePicker: true)),
                //FadeAnimation(1.3, makeInput(label: S.of(context).id)), //"ID"
                //FadeAnimation(1.4, makeInput(label: S.of(context).password, obscureText: true)), //"Password"
                //FadeAnimation(1.4, makeInput(label: S.of(context).comfirm_password, obscureText: true)), //"Confirm Password"
                ],
              ),
              FadeAnimation(1.5, Container(
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
                  onPressed: (){
                    final name = nameController.text;
                    final password = passwordController.text;
                    final id = IdController.text;
                    final bool gender = _gender;
                    final DateTime birthday = _birthday ?? DateTime.now(); // 或者使用其他默认值

                    if(password == comfirm_password){
                      db.createUser(id: id,name: name, password: password, gender: gender, birth: birthday);
                      userIdProvider.setUserId(id);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserInterfacePage()));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(S.of(context).wrong_password),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }



                    // bool phoneExists = await Database.checkphone(id!);
                    // setState(() {
                    //   if (phoneExists) {
                    //     idErrorText = S.of(context).id_is_already; //"此手機號碼已被註冊過"
                    //   } else {
                    //     idErrorText = null;
                    //   }
                    // });
                    // setState(() {
                    //   if ((password != comfirm_password)) {
                    //     passwordErrorText = S.of(context).password_not_same; //"兩次輸入的密碼不一致，請確認密碼"
                    //   } else {
                    //     passwordErrorText = null;
                    //   }
                    // });
                    // if (idErrorText == null &&
                    //     passwordErrorText == null) {
                    //
                    // }
                  },
                  color: Colors.greenAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Text("Sign up", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                  ),),
                ),
              )),
              FadeAnimation(1.6, Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserLoginPage()));// 在此處添加導航到註冊頁面的程式碼
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.blueAccent, // 可以根據需要更改文本顏色
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false, isDropdown = false, bool hasDatePicker = false}) {
    if (isDropdown) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black87
          ),),
          SizedBox(height: 7,),
          DropdownButtonFormField(
            items: [
              DropdownMenuItem(
                child: Text('Male'),
                value: 'male',
              ),
              DropdownMenuItem(
                child: Text('Female'),
                value: 'female',
              ),
            ],
            onChanged: (value) {
              // 在這裡處理性別選擇的邏輯
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          SizedBox(height: 15,),
        ],
      );
    }else if(hasDatePicker) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),),
          SizedBox(height: 7,),
          TextField(
            obscureText: obscureText,
            decoration: InputDecoration(
              labelText: 'YYYYMMDD',
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          SizedBox(height: 15,),
        ],
      );
    }else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black87
          ),),
          SizedBox(height: 7,),
          TextField(
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          SizedBox(height: 15,),
        ],
      );
    }
  }
}