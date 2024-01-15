import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/config/config.dart';
import 'package:travel_app/pages/login.dart';
import 'package:travel_app/widgets/mytextfield.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  File? _image;

  Future<void> _performRegister(BuildContext context) async {
    final url = Uri.parse('${AppConfig().baseUrl}/auth/register');
    final request = http.MultipartRequest('POST', url);

    // Add image file to the request
    if (_image != null) {
      print('File Path: ${_image!.path}');
      final bytes = await _image!.readAsBytes();
      print('File Size: ${bytes.length} bytes');

      request.files.add(http.MultipartFile(
        'profile_picture',
        http.ByteStream.fromBytes(bytes),
        bytes.length,
        filename: _image!.path.split('/').last,
      ));
    }

    // Add other form fields
    request.fields['username'] = usernameController.text;
    request.fields['email'] = emailController.text;
    request.fields['password'] = passwordController.text;

    // Set 'Content-Type' header to 'multipart/form-data'
    request.headers['Content-Type'] = 'multipart/form-data';

    try {
      // Send the request
      final response = await request.send();

      // Check the response status code
      if (response.statusCode == 201) {
        // Successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Register Successful!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Handle registration failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Register Failed. Please check your credentials.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (error) {
      // Handle any exceptions that may occur during the request
      print('Error during registration: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred during registration.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Container(
          decoration: const BoxDecoration(
              // image: DecorationImage(
              //   // image: AssetImage('//'), // Replace with your own image path
              //   fit: BoxFit.cover,
              // ),
              ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/splash.png"),
                    // const SizedBox(height: 50),
                    // const SizedBox(height: 100),
                    Text(
                      'Create your account',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 19,
                      ),
                    ),
                    const SizedBox(height: 45),
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? Icon(
                                Icons.camera_alt,
                                size: 50,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      controller: usernameController,
                      hinttext: 'username',
                      obscuerText: false,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      controller: emailController,
                      hinttext: 'Email',
                      obscuerText: false,
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      controller: passwordController,
                      hinttext: 'Password',
                      obscuerText: true,
                    ),
                    const SizedBox(height: 20),

                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [],
                      ),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        // backgroundColor:
                        //     const Color.fromARGB(255, 255, 145, 0),:
                      ),
                      onPressed: () {
                        _performRegister(context);
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
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Allready have an account?"),
                        const SizedBox(
                          width: 4,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Text("Login now"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
