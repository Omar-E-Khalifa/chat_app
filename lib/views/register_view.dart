import 'package:chat_app/constants.dart';
import 'package:chat_app/helpers/snack_bar_message.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static const String id = "RegisterView";

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
                    "Sign Up",
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
                  text: 'Register',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await RegisterUser();
                        SnackBarMessage(context,
                            message:
                                "Account created succefully! Please log In");
                        Navigator.pop(context);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "weak-password") {
                          SnackBarMessage(context,
                              message: "Weak password used");
                        } else if (e.code == "email-already-in-use") {
                          SnackBarMessage(context,
                              message:
                                  "Account with this email already exists");
                        } else {
                          print(e);
                        }
                      } on Exception catch (e) {
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
                      "Already have an account?   ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      child: Text(
                        "sign in",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      onTap: () => Navigator.pop(context),
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

  Future<void> RegisterUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email != null ? email! : "",
        password: password != null ? password! : "");
  }
}
