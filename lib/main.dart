import 'package:flutter/material.dart';
import 'package:rehabilitation_app/register/home_page.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:rehabilitation_app/provider/UserIdProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCxUbojR1vQUZRx6c8DM-2QD-0_BassfWM",
      appId: "1:93839207878:android:5fcc115bc4af1f85f9d6c7",
      messagingSenderId: "93839207878",
      projectId: "patella-rehabilitation-project",
    ),
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserIdProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate,
      ],
      home: HomePage(),
    );
  }
}