// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Enter your ID`
  String get your_id {
    return Intl.message(
      'Enter your ID',
      name: 'your_id',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get your_password {
    return Intl.message(
      'Enter your password',
      name: 'your_password',
      desc: '',
      args: [],
    );
  }

  /// `Successful Login!`
  String get login_success {
    return Intl.message(
      'Successful Login!',
      name: 'login_success',
      desc: '',
      args: [],
    );
  }

  /// `login failed!`
  String get login_fail {
    return Intl.message(
      'login failed!',
      name: 'login_fail',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get id {
    return Intl.message(
      'ID',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Comfirm Password`
  String get comfirm_password {
    return Intl.message(
      'Comfirm Password',
      name: 'comfirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get birthday {
    return Intl.message(
      'Birthday',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `The ID is already exists`
  String get id_is_already {
    return Intl.message(
      'The ID is already exists',
      name: 'id_is_already',
      desc: '',
      args: [],
    );
  }

  /// `Passwords are inconsistent`
  String get password_not_same {
    return Intl.message(
      'Passwords are inconsistent',
      name: 'password_not_same',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Rehabilitation record`
  String get record {
    return Intl.message(
      'Rehabilitation record',
      name: 'record',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `personal information`
  String get person {
    return Intl.message(
      'personal information',
      name: 'person',
      desc: '',
      args: [],
    );
  }

  /// `Today's Progress`
  String get today_rehabilitation_progress {
    return Intl.message(
      'Today\'s Progress',
      name: 'today_rehabilitation_progress',
      desc: '',
      args: [],
    );
  }

  /// `Chondromalacia Patella Rehabilitation System`
  String get chondromalacia_patella_rehabilitation_system {
    return Intl.message(
      'Chondromalacia Patella Rehabilitation System',
      name: 'chondromalacia_patella_rehabilitation_system',
      desc: '',
      args: [],
    );
  }

  /// `STRAT`
  String get start {
    return Intl.message(
      'STRAT',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Wrong Password`
  String get wrong_password {
    return Intl.message(
      'Wrong Password',
      name: 'wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `User doesn't exist`
  String get User_does_not_exist {
    return Intl.message(
      'User doesn\'t exist',
      name: 'User_does_not_exist',
      desc: '',
      args: [],
    );
  }

  /// `Rehabilitation Completed for this Session!`
  String get rehabilitation_completed_for_this_session {
    return Intl.message(
      'Rehabilitation Completed for this Session!',
      name: 'rehabilitation_completed_for_this_session',
      desc: '',
      args: [],
    );
  }

  /// `confirm`
  String get comfirm {
    return Intl.message(
      'confirm',
      name: 'comfirm',
      desc: '',
      args: [],
    );
  }

  /// `First Rehabilitation Session Time`
  String get first_rehabilitation_session_time {
    return Intl.message(
      'First Rehabilitation Session Time',
      name: 'first_rehabilitation_session_time',
      desc: '',
      args: [],
    );
  }

  /// `Second Rehabilitation Session Time`
  String get second_rehabilitation_session_time {
    return Intl.message(
      'Second Rehabilitation Session Time',
      name: 'second_rehabilitation_session_time',
      desc: '',
      args: [],
    );
  }

  /// `You have not completed rehabilitation yet.`
  String get you_have_not_completed_rehabilitation_yet {
    return Intl.message(
      'You have not completed rehabilitation yet.',
      name: 'you_have_not_completed_rehabilitation_yet',
      desc: '',
      args: [],
    );
  }

  /// `Second rehabilitation is not completed yet.`
  String get second_rehabilitation_is_not_completed_yet {
    return Intl.message(
      'Second rehabilitation is not completed yet.',
      name: 'second_rehabilitation_is_not_completed_yet',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
