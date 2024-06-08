import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/account/pages/account_page.dart';
import 'package:epic/features/auth/model/user_model.dart';
import 'package:epic/features/auth/pages/login_page.dart';
import 'package:epic/features/auth/pages/logout_page.dart';
import 'package:epic/features/auth/pages/username_page.dart';
import 'package:epic/home_page.dart';
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

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const LoginPage();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    final user = FirebaseAuth.instance.currentUser;
                    return UsernamePage(
                      displayName: user!.displayName!,
                      profilePic: user.photoURL!,
                      email: user.email!,
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Loader();
                  }
                  return AccountPage(
                      user: UserModel.fromMap(snapshot.data!.data()!));
                });
          },
        ));
  }
}
