import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:massage_app/screens/Sign_in_Screen.dart';
import 'package:massage_app/screens/register_screen.dart';
import 'package:massage_app/widgets/my_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String screenroot='Welcome root';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 100,
                  child: Image.asset('images/logo.png'),
                ),
                Text('Message Me',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Colors.indigo,
                ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            MyButton(color: Colors.yellow[900]!,text:'Sign In',onpress: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
            },),
            MyButton(color: Colors.blue[900]!,text:'Register',onpress: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
            },),
          ],
        ),
      ),
    );
  }

}
