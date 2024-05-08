import 'package:flutter/material.dart';
import 'package:massage_app/screens/chat_screen.dart';
import 'package:massage_app/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static const String screenroot='signin root';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth=FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 180,
              child: Image.asset('images/logo.png'),
            ),
            SizedBox(height: 50,),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value){
                email=value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your Email',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10),)
                ),
                enabledBorder:  OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.orange,
                        width: 1
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10),)
                ),
                focusedBorder:  OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10),)
                ),
              ),

            ),
            SizedBox(height: 8,),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value){
                password=value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your Password',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10),)
                ),
                enabledBorder:  OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.orange,
                        width: 1
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10),)
                ),
                focusedBorder:  OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10),)
                ),
              ),

            ),
            SizedBox(height: 8,),
            MyButton(color: Colors.blue[900]!,text:'Sign In',onpress: ()async{
               try{
                 final user=await _auth.signInWithEmailAndPassword(email: email, password: password);
                 if (user!=null){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
                 }
               }catch(e){
                 print(e);
               }
            },),

          ],
        ),
      ),
    );
  }
}
