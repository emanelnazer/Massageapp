import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _firestore=FirebaseFirestore.instance;
late User SignInUser;
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const String screenroot='chat root';
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  final _auth=FirebaseAuth.instance;
  String? MessageText;
  final messageeditcontroller=TextEditingController();
  @override
  void initState() {
   getCurrentUser();
  }
  void getCurrentUser(){
     try{
       final user=_auth.currentUser;
       if(user!=null){
         SignInUser=user;
         print(SignInUser.email);
     }
    }catch(e){
       print(e);
     }
  }
  /*void getMessage(){
    final messages=_firestore.collection('message').get();
    for(var message in messages.docs){
      print(message.data());
    }
  }*/
  void MessageStream()async
  {
    await for(var snapshot in _firestore.collection('message').snapshots()){
      for(var message in snapshot.docs){
        print(message.data());
      }
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(
          children: [
            Image.asset('images/logo.png',height: 25,),
            SizedBox(width: 10,),
            Text('Massege Me'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: (){
             _auth.signOut();
              Navigator.pop(context);
              //MessageStream();
            },
            icon: Icon(Icons.close),
          )
        ],
      ),
      body: SafeArea(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStreamBuilder(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  )
                )
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: TextField(
                        controller: messageeditcontroller,
                        onChanged: (value){
                          MessageText=value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20
                          ),
                          hintText: 'Write Your Massage Here',
                          border: InputBorder.none,
                        ),
                      ),
                  ),
                  TextButton(
                      onPressed: (){
                        messageeditcontroller.clear();
                        _firestore.collection('messsage').add({
                          'text':MessageText,
                          'sender':SignInUser.email,
                          'time':FieldValue.serverTimestamp(),
                        });
                      },
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
        
      ),
    );
  }
}
class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messsage').orderBy('time').snapshots(),
        builder:(context,snapshot){
          List<MessageLine>messageWidgets=[];
          if(!snapshot.hasData){
            return Center(
                child:CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                )
            );
          }
          final messages=snapshot.data!.docs.reversed;
          for(var message in messages){
            final messagetext=message.get('text');
            final messagesender=message.get('sender');
            final currentuser=SignInUser.email;
            if(currentuser==messagesender){

            }
            final messagewidget=MessageLine(
              sender: messagesender,
              text: messagetext,
            isme: currentuser==messagesender,);
            messageWidgets.add(messagewidget);
          }

          return Expanded(
            child: ListView(
              reverse: true,
                padding:EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                children: messageWidgets
            ),
          );
        }
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({Key? key, this.sender, this.text, required this.isme}) : super(key: key);
  final String? sender;
  final String? text;
  final bool isme;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: isme ?CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text('$sender',style: TextStyle(fontSize: 12,color: Colors.yellow[900]),),
            Material(
              elevation: 5,
              borderRadius:isme ? BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ):BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: isme ? Colors.blue[800] : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                  child: Text( '$text - $sender',
                  style: TextStyle(fontSize: 15,color: isme ? Colors.white : Colors.black45),
                  ),
                )
            ),
          ],
        ),
      ),
    );

  }
}
