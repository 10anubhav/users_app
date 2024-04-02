
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:users_app/authentication/login_screen.dart';
import 'package:users_app/methods/common_methods.dart';
import 'package:users_app/pages/home_page.dart';
import 'package:users_app/widgets/loading_dialog.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}


class _SignUpScreenState extends State<SignUpScreen>
{
  TextEditingController phoneTextEditingController= TextEditingController();
  TextEditingController userNameTextEditingController= TextEditingController();
  TextEditingController emailTextEditingController= TextEditingController();
  TextEditingController passwordTextEditingController= TextEditingController();
  CommonMethods cMethods = CommonMethods();


  checkIfNetworkIsAvailable()
  {
    cMethods.checkConnectivity(context);//Used to check Network

    signUpFormValidation();
  }
  signUpFormValidation() {
    if(userNameTextEditingController.text.trim().length <3)
      {
        cMethods.displaySnackBar("Your name must be 4 or more character ", context);
      }
    else if(phoneTextEditingController.text.trim().length <7)
    {
      cMethods.displaySnackBar("Your number is incorrect ", context);
    }
    else if(!emailTextEditingController.text.contains("@"))
    {
      cMethods.displaySnackBar("Invalid Email ", context);
    }
    else if(passwordTextEditingController.text.trim().length <5)
    {
      cMethods.displaySnackBar("Password is to Small ", context);
    }
    else
      {
        registerNewUser();
        //register the User
      }
  }
  registerNewUser() async
  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context)=> LoadingDialog(messageText: "Registering Your Account...."),
    );
    final User? userFirebase=(
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((errorMsg)
        {
          Navigator.pop(context);
          cMethods.displaySnackBar(errorMsg.toString(), context);
        })
    ).user;
    if(!context.mounted)return;
    Navigator.pop(context);

    DatabaseReference userRef= FirebaseDatabase.instance.ref().child("users").child(userFirebase!.uid);
    Map userDataMap =
    {
      "name": userNameTextEditingController.text.trim(),
      "email": emailTextEditingController.text.trim(),
      "phone": phoneTextEditingController.text.trim(),
      "id": userFirebase.uid,
      "blockStatus": "no",
    };
    userRef.set(userDataMap);

    Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomePage()));

  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [


              Image.asset(
                  "assets/images/logo.png"
              ),
              const Text(
                "Create a User's Account",
                style: TextStyle(
                  fontSize: 26,
                    fontWeight: FontWeight.bold,
                ),
              ),
              //text fields + button
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [

                    TextField(
                      controller: userNameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "User Name",
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),//userName

                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "User Phone Number",
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),//userPhone

                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "User Email",
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),//userEmail

                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "User Password",
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),//userPassword

                    const SizedBox(height: 22,),

                    ElevatedButton(
                      onPressed: ()
                      {
                          checkIfNetworkIsAvailable();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(horizontal: 80)
                      ),
                      child: const Text(
                        "SignUp"
                      ),
                    )
                    //text button
                  ],
                ),
              ),
              const SizedBox(height: 12,),
              //text button
              TextButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>LogInScreen()));
                },
                child: const  Text(
                    "Already have an Account? Login Here",
                    style: TextStyle(
                      color: Colors.grey
                    ),
                ),
              ),
            ],
          ),
        ),
       ),
    );
  }
}
