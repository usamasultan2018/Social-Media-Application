 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/helper/helper_methods.dart';
import 'package:social_media_app/widgets/CustomCommentButton.dart';
import 'package:social_media_app/widgets/delete_button.dart';
import 'package:social_media_app/widgets/like_button.dart';

import 'comments.dart';

class CustomPost extends StatefulWidget {
  final String msg;
  final String user;
  final String postId;
  final String time;
  final List<String> likes;

  const CustomPost({
    Key? key,
    required this.msg,
    required this.user,
    required this.postId,
    required this.likes, required this.time,
  }) : super(key: key);

  @override
  State<CustomPost> createState() => _CustomPostState();
}

class _CustomPostState extends State<CustomPost> {
  bool isLiked = false;
  final currentUser = FirebaseAuth.instance.currentUser;
  final commentTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // isLiked contain email
    isLiked = widget.likes.contains(currentUser!.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    //Access the doc in firebase
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('Users Posts').doc(widget.postId);
    if (isLiked) {
      //if the post is liked add the users to email to the 'likes' field
      postRef.update({
        'likes': FieldValue.arrayUnion([currentUser!.email]),
      });
    } else {
      // otherwise remove user email  from the liked list
      postRef.update({
        'likes': FieldValue.arrayRemove([currentUser!.email]),
      });
    }
  }

  // adding a comment
  void addComment(String comment) {
    // write the comment to Firebase Firestorm collection of post
    FirebaseFirestore.instance
        .collection('Users Posts')
        .doc(widget.postId)
        .collection('comments')
        .add({
      'commentText': comment,
      'commentedBy': currentUser!.email,
      'commentTime': Timestamp.now(),
    });
  }

  // show a comment dialog to comment..
  void showCommentDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Comment'),
            content: TextField(
              controller: commentTextController,
              decoration: InputDecoration(
                hintText: 'Write a comment..',
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    commentTextController.clear();
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    addComment(commentTextController.text);
                    commentTextController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Post')),
            ],
          );
        });
  }
  // show a dialog to delete a post from firebase firestore.
  void deletePost(){
    // show a dialog to ask for confirmation to delete a or not.
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title:Text('Delete Post'),
        content:  Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);

              },
              child: Text('Cancel')),
          TextButton(
              onPressed: ()async {
                /// delete the comment first from firestore
                /// then delete the post
                final commentDocs = await FirebaseFirestore.instance.collection('Users Posts').doc(widget.postId).collection('comments').get();
                for(var doc in commentDocs.docs){
                  await FirebaseFirestore.instance.collection('Users Posts').doc(widget.postId).collection('comments').doc(doc.id).delete();

                }
                FirebaseFirestore.instance.collection('Users Posts').doc(widget.postId).delete().then((value) => print('post deleted')).catchError((error){
                  print('Failed to delete the post $error');
                });

                Navigator.pop(context);
              },
              child: Text('Delete')),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      margin: const EdgeInsets.only(left: 25, top: 25, right: 25),
      decoration: BoxDecoration(
        color:Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 25,
          ),
          // profile pic
          // Container(
          //   padding: EdgeInsets.all(10),
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: Colors.grey.shade400,
          //   ),
          //   child: Icon(
          //     Icons.person,
          //     color: Colors.white,
          //   ),
          // ),
          SizedBox(
            width: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.msg),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(widget.user,style: TextStyle(color: Colors.grey.shade400),),
                      Text(" * ",style: TextStyle(color: Colors.grey.shade400)),
                      Text(widget.time,style: TextStyle(color: Colors.grey.shade400)),
                    ],
                  )
                ],
              ),
              DeleteButton(onTap: deletePost,),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Like Button
              Column(
                children: [
                  CustomLikeButton(
                    isLiked: isLiked,
                    onTap: toggleLike,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(widget.likes.length.toString()),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              //Comment Buttons
              Column(
                children: [
                  CustomCommentButton(
                    onTap: showCommentDialog,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('0'),
                ],
              ),
            ],
          ),
          SizedBox(height: 25,),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Users Posts')
                  .doc(widget.postId)
                  .collection('comments')
                  .orderBy(
                    'commentTime',
                    descending: true,
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                } else {
                  return ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: snapshot.data!.docs.map((e) {
                      final commentData = e.data() as Map<String, dynamic>;
                      return Comments(
                        text: commentData['commentText'],
                        user: commentData['commentedBy'],
                        time:formatDate(commentData["commentTime"]),
                      );
                    }).toList(),
                  );
                }
              })
        ],
      ),
    );
  }
}
