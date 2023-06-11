import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/text_box.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final userCollection = FirebaseFirestore.instance.collection('Users');

  Future<void> editField(String field) async {
    String newValue = '';
    await showDialog(
        context: (context),
        builder: (ctx) {
          return AlertDialog(
              backgroundColor: Colors.grey.shade900,
              title: Text(
                'Edit $field',
                style: TextStyle(color: Colors.white),
              ),
              content: TextField(
                style: TextStyle(color: Colors.white),
                autofocus: true,
                onChanged: (value) {
                  newValue =value ;
                },
                decoration: InputDecoration(
                  hintText: 'enter new $field',
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () =>Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(newValue);
                    },
                    child: const Text('Save',
                        style: TextStyle(color: Colors.white))),
              ]);
        });
    if(newValue.trim().length>0){
      // update only if there is something in field
      await userCollection.doc(currentUser!.uid).update({
        field:newValue,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text('P R O F I L E'),
          centerTitle: true,
          backgroundColor:Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              return ListView(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  // profile pic
                  const Icon(
                    Icons.person,
                    size: 72,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // user email
                  Text(
                    currentUser!.email.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // user details
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      'My Details',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),

                  // username
                  MyTextBox(
                    text: data!['username'],
                    sectionName: 'Username',
                    onPressed: () => editField('username'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // bio
                  MyTextBox(
                    text: data['bio'],
                    sectionName: 'Bio',
                    onPressed: () => editField('bio'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // user posts
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      'My Post',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error as String),
              );
            } else {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            }
          },
        ));
  }
}
