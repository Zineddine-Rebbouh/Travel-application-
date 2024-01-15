import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/config/config.dart';
import 'package:travel_app/pages/register.dart';
import 'package:travel_app/pages/home.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/provider/provider.dart';
import 'package:travel_app/widgets/UserList.dart';
import 'package:travel_app/widgets/mytextfield.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Future<void> _performLogin(BuildContext context) async {
    // Get the email and password from the text fields (you may need to use a form for this)
    // Define the API endpoint
    String email = emailController.text;
    String password = passwordController.text;

    print(email);
    print(password);
    // Create the request body
    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    try {
      // Send the POST request
      final response = await http.post(
        Uri.parse('${AppConfig().baseUrl}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // Check the response status
      if (response.statusCode == 200) {
        // Successful login, handle the response
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Successful!'),
            duration: Duration(seconds: 2),
          ),
        );

        final loggedInUser = jsonDecode(response.body);
        print('1');
        print(loggedInUser);
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final user = loggedInUser["user"];
        userProvider.setUser(User.fromJson(user));
      } else if (response.statusCode == 422) {
        // Validation error: Display errors received from the server
        print(response.body);
        Map<String, dynamic> responseData = jsonDecode(response.body);
        print(responseData);
        // Example: Display email validation error
        List<dynamic> errors =
            responseData['errors']; // Correct path to 'errors'
        for (dynamic error in errors) {
          String type = error['type'];
          String value = error['value'];
          String msg = error['msg'];
          String path = error['path'];
          print('Type: $type');
          print('Value: $value');
          print('Message: $msg');
          print('Path: $path');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$path: $msg', style: TextStyle(color: Colors.red)),
              duration: Duration(seconds: 20),
            ),
          );
        }
      }
    } catch (error) {
      print(error);
      // Handle network or other errors
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again.',
              style: TextStyle(color: Colors.red)),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                //logo
                Image.asset(
                  "assets/icons/splash.png",
                ),

                //wlcome text
                Text("Welcome to Discover",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                Text(
                  "please fill your login infos",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 25,
                ),

                //email textholder

                MyTextField(
                  controller: emailController,
                  hinttext: 'email',
                  obscuerText: false,
                ),
                const SizedBox(
                  height: 25,
                ),

                //password textholder

                MyTextField(
                  controller: passwordController,
                  hinttext: 'password',
                  obscuerText: true,
                ),

                const SizedBox(
                  height: 25,
                ),

                //forgot pass

                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("forgot password?",
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                // sign in button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    // backgroundColor:
                    //     const Color.fromARGB(255, 255, 145, 0),:
                  ),
                  onPressed: () {
                    _performLogin(context);
                  },
                  child: Container(
                    width: 330,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //log wit
                Row(
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
                        "or sign in with",
                        style: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                //alt buttons
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //dont have account ?

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Dont have an account?"),
                    const SizedBox(
                      width: 4,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                      child: Text("Register now"),
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
