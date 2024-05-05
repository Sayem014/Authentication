
import 'package:authentication/components/my_button.dart';
import 'package:authentication/components/my_textfield.dart';
import 'package:authentication/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
      const  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in
  void signUserIn() async{
    //show loading circle
    showDialog(
      context: context, 
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      );

    //try sign in
    try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text,
      );
      //pop the loading circle
    Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
    Navigator.pop(context);
       showErrorMessage(e.code);
    }
    

    
  }

  //error message to user
  void showErrorMessage (String message) {
    showDialog(
      context: context, 
      builder: (context) {
        return  AlertDialog(
          title: Text(
             message,
             style: const TextStyle(color: Colors.black),
            ),
        );
      }
      );
  }


   


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body:  Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const  SizedBox(height: 50,),
                //logo
                const Icon(Icons.lock, size: 100,),
          
                 const  SizedBox(height: 50,),
              
              //welcome back, you've been missed!
              Text(
                'Welcome back, you\'ve been missed',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
              
               const  SizedBox(height: 25,),
          
              //usename textfield
              MyTextField(
                controller: emailController,
                hintText: 'email',
                obscureText: false,
              ),
          
              const  SizedBox(height: 10,),
              //password textfield
              
              MyTextField(
                controller: passwordController,
                hintText: 'password',
                obscureText: true,
              ),
          
               const  SizedBox(height: 10,),
          
              //forgot password
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
              
                    ),
                  ],
                ),
              ),
          
               const  SizedBox(height: 25,),
          
               //sign in button
               MyButton(
                onTap: signUserIn,
               ),
          
               const  SizedBox(height: 50,),
              //or continue with
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                          ),
                      ),
                       Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                      ),
                  ],
                ),
              ),
          
              const  SizedBox(height: 50),
          
              //google + apple sign in button
              
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google button
                   SquareTile(imagePath: 'lib/images/google.png'), 
                   
                  SizedBox(width: 10,),
                  //apple button
                  SquareTile(imagePath: 'lib/images/apple.png'), 
                  
                ],
              ),
          
              const  SizedBox(height: 50),
          
              //not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),

                  const SizedBox(width: 10),

                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Register here',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                  ),
                ],
              ),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}