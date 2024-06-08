import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic/cores/screens/error_page.dart';
import 'package:epic/cores/screens/loader.dart';
import 'package:epic/features/account/pages/account_page.dart';
import 'package:epic/features/auth/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    "Epic",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.segment_sharp,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(currentUserprovider).when(
                        data: (currentUser) => Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AccountPage(
                                          user: currentUser,
                                        ),
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: CachedNetworkImageProvider(
                                        currentUser.profilePic),
                                  )),
                            ),
                        error: (error, stackTrace) => const ErrorPage(),
                        loading: () => const Loader());
                  },
                )
              ],
            ),
            const Expanded(child: Center(child: Text("Home Page"))),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigation(
      //   currentIndex: currentIndex,
      //   onTap: (index) {
      //     if(index != 2){
      //       currentIndex = index;
      //       setState(() {});
      //     }else{
      //       // showModalBottomSheet(context: context, builder: (context) => const CreateBottomSheet());
      //     }
      //   },

      // ),
    );
  }
}
