import 'package:chat_app/constants.dart';
import 'package:chat_app/helpers/snack_bar_message.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const String id = "LoginView";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(height: 85),
                Image.asset(
                  KLogo,
                  height: 100,
                ),
                Center(
                  child: Text(
                    "Scholar Chat",
                    style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(height: 100),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                CustomTextFormField(
                  hintText: 'Email',
                  onChanged: (value) => email = value,
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                    obscureValue: true,
                    hintText: 'Password',
                    onChanged: (value) => password = value),
                SizedBox(height: 25),
                CustomButton(
                  text: 'Log in',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await LoginUser();
                        SnackBarMessage(context,
                            message: "Logged In succesfully");
                        Navigator.pushNamed(context, ChatView.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "user-not-found") {
                          SnackBarMessage(context,
                              message: "No user found for that email.");
                        } else if (e.code == "wrong-password") {
                          SnackBarMessage(context,
                              message:
                                  "Wrong password provided for that user.");
                        }
                      } catch (e) {
                        print(e);
                        SnackBarMessage(context, message: "There was an error");
                      }

                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?   ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      child: Text(
                        "sign up",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterView(),
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

  Future<void> LoginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email != null ? email! : "",
        password: password != null ? password! : "");
  }
}
