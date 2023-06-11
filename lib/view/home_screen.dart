import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/auth/login_or_register.dart';
import 'package:social_media_app/helper/helper_methods.dart';
import 'package:social_media_app/view/profile_screen.dart';
import 'package:social_media_app/widgets/custom_textfield.dart';
import 'package:social_media_app/widgets/drawer.dart';
import '../widgets/custome_post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
      return LoginOrRegister();
    }));
    print('signout');
  }

  void postMessage() {
    // if there something in the text-field then add
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('Users Posts').add({
        'userEmail': currentUser!.email,
        'message': textController.text.trim(),
        'TimeStamp': Timestamp.now(),
        'likes': [],
      });
    }
    textController.clear();
  }

  void gotoProfileScreen() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => const ProfileScreen()));
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('B U Z Z  B O O K'),
        backgroundColor:Theme.of(context).appBarTheme.backgroundColor,
      ),
      drawer: MyDrawer(
        onLogoutTap: signOut,
        onProfileTap: gotoProfileScreen,
      ),
      body: Center(
        child: Column(
          children: [
            // the wall
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Users Posts')
                        .orderBy('TimeStamp', descending: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              //get the message
                              final post = snapshot.data!.docs[index];
                                return CustomPost(
                                  msg: post['message'],
                                  user: post['userEmail'],
                                  postId: post.id,
                                  likes: List<String>.from(post['likes'] ?? []),
                                  time: formatDate(post['TimeStamp']),
                                );
                                }
                              );

                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error+${snapshot.error}'),
                        );
                      } else {
                        return Center(child: Text('${snapshot.error}'));
                      }
                    })),
            // post message
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: textController,
                      hintText: 'Write something ',
                      obscureText: false,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                          onPressed: postMessage,
                          icon: const Icon(
                            Icons.arrow_circle_up,
                            color: Colors.white,
                          ))),
                ],
              ),
            ),
            // logged in ass
            Text('Logged in as ${currentUser!.email!}'),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
