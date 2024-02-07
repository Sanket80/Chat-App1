import 'package:chat_app/Utils/textfield_styles.dart';
import 'package:chat_app/chat_page.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  Future<void> loginUser(BuildContext context) async{
    if (_formKey.currentContext != null && _formKey.currentState!.validate()) {
      print('Username: ${UserNameController.text}');
      print('Password: ${PasswordController.text}');
      print('Login User');
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => ChatPage(username: UserNameController.text,)));

      await context.read<AuthService>().loginUser(UserNameController.text);
      Navigator.pushReplacementNamed(context, '/chat',
          arguments: '${UserNameController.text}');
    } else {
      print('Not Successful');
    }
  }

  final UserNameController = TextEditingController();
  final PasswordController = TextEditingController();
  final _mainUrl = 'https://www.linkedin.com/in/sanket-kadam-0905a6225/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/banner_image.png'),
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Let\'s Sign you in',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Welcome back! \n You\'ve been missed!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          } else if (value.length < 6) {
                            return 'Username must be atleast 6 characters long';
                          }
                          return null; // if the value is valid
                        },
                        controller: UserNameController,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          hintStyle: ThemeTextStyle.loginTextFieldStyle,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be atleast 6 characters long';
                          }
                          return null; // if the value is valid
                        },
                        controller: PasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: ThemeTextStyle.loginTextFieldStyle,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: () async {
                    await loginUser(context);
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(8),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                GestureDetector(
                    onTap: () async {
                      if (!await launch(_mainUrl)) {
                        throw 'Could not launch $_mainUrl';
                      }
                    },
                    child: Column(children: [
                      Text(
                        'Connect with me on LinkedIn',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '$_mainUrl',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ])),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SocialMediaButton.linkedin(
                      url:
                          'https://www.linkedin.com/in/sanket-kadam-0905a6225/',
                      size: 50,
                      color: Colors.blue,
                    ),
                    SocialMediaButton.github(
                      url: 'https://github.com/Sanket80',
                      size: 50,
                      color: Colors.black,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
