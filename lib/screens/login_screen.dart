import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mevivu_task2/controllers/auth_controller.dart';
import 'package:mevivu_task2/routes/app_routes.dart';
import 'package:mevivu_task2/screens/cart_screen.dart';
import 'package:mevivu_task2/widgets/button_widget.dart';
import 'package:mevivu_task2/widgets/text_field_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    Get.put(AuthController());

    void handleSubmit() async {
      debugPrint("login pressed");
      final AuthController currentUserController = Get.find<AuthController>();

      bool isSuccess = await currentUserController.currentUserService.loginUser(
        username: 'emilys',
        password: 'emilyspass',
        // username: emailController.text,
        // password: passwordController.text,
      );

      if (isSuccess) {
        Get.toNamed(AppRoutes.homePage);
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          debugPrint("GestureDetector pressed");
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Text(
                    "Log into\nyour account",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 32,
                    ),
                  ),
                ),
                TextFieldWidget(
                  hint: "Email address",
                  controller: emailController,
                ),
                TextFieldWidget(
                  hint: "Password",
                  controller: passwordController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Forgot Password?"),
                  ],
                ),
                SizedBox(height: 30),
                Wrap(
                  runSpacing: 30,
                  children: [
                    Center(
                      child: ButtonWidget(
                        text: "LOG IN",
                        callback: handleSubmit,
                      ),
                    ),
                    Center(child: Text("or log in with")),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                foregroundImage: NetworkImage(
                                    "https://banner2.cleanpng.com/20171218/f41/av2sz4r4b.webp"),
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                foregroundImage: NetworkImage(
                                    "https://image.similarpng.com/very-thumbnail/2020/06/Logo-google-icon-PNG.png"),
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                foregroundImage: NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_8wbBk7vsS7Gek3XHzniMLFSzrNTulANuhA&s"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account?  ",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Sign Up",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                            ],
                          ),
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
