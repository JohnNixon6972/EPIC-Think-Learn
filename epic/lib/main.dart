// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/auth/pages/login_page.dart';
import 'package:epic/features/account/pages/stenghts_difficulties.dart';
import 'package:epic/features/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  String _type = '';
  void _setType(String type) {
    _type = type;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'SourceSansPro',
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return LoginPage(
                setUserType: _setType,
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData ||
                      !snapshot.data!.exists ||
                      snapshot.data!.data()!['strategies'] == null) {
                    final user = FirebaseAuth.instance.currentUser;
                    return StrenghtsDifficulties(
                      displayName: user!.displayName!,
                      profilePic: user.photoURL!,
                      email: user.email!,
                      type: _type,
                    );
                    // return LogoutPage();
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Loader();
                  }
                  return const HomePage();
                });
          },
        ));
  }
}
