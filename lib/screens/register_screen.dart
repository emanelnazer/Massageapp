import 'package:flutter/material.dart';
import 'package:massage_app/screens/chat_screen.dart';
import 'package:massage_app/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const String screenroot='register root';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth=FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
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
                keyboardType:TextInputType.emailAddress,
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
                obscureText: true,
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
              MyButton(color: Colors.blue[900]!,text:'Register',onpress: ()async{
                setState((){
                      showSpinner=true;
                    });
               try{
                 final Newuser= await _auth.createUserWithEmailAndPassword(email: email, password: password);
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
                 setState((){
                   showSpinner=false;
                 });
               }catch(e)
                {
                  print(e);
                }
              },),

            ],
          ),
        ),
      ),
    );
  }
}
