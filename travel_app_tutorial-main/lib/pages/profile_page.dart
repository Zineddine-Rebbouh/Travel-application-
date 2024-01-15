import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/config/config.dart';
import 'package:travel_app/pages/Admin.dart';
import 'package:travel_app/pages/login.dart';
import 'package:travel_app/provider/provider.dart';
import 'package:travel_app/widgets/PostList.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showFavourites = true;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Access user properties
    String? username = userProvider.user?.username;
    String? email = userProvider.user?.email;
    String? profilePic = userProvider.user?.profilePic;
    print(profilePic);
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          //profile picture + name & local

          Padding(
            padding: const EdgeInsets.only(left: 30, right: 20),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(_getImage(profilePic)),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          color: const Color.fromARGB(255, 194, 194, 194))
                      // color: Colors.red,
                      ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          username ?? '',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        // if (isAdmin) // Replace 'isAdmin' with the actual condition to check if the user is an admin
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Admin(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons
                                      .dashboard, // Replace with the desired icon
                                  color: Colors.blue,
                                  size: 35, // Replace with the desired color
                                ),
                                SizedBox(
                                    width:
                                        4), // Adjust the width based on your preference
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Constantine , Algeria",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Divider(thickness: 0.5, color: Colors.grey[400]),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  "Account Settings",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: .5),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: 340,
              height: 65,
              decoration: BoxDecoration(
                  // color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: const Color.fromARGB(255, 194, 194, 194))),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.account_circle,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Edit your profile",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 90),
                      child: TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.black),
                          label: Text("")),
                    )
                  ],
                ),
              ),
            ),
          ), //button 2
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: 340,
              height: 65,
              decoration: BoxDecoration(
                  // color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: const Color.fromARGB(255, 194, 194, 194))),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.translate_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Change language",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 79),
                      child: TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                          ),
                          label: Text("")),
                    )
                  ],
                ),
              ),
            ),
          ),

          //button3
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: 340,
              height: 65,
              decoration: BoxDecoration(
                  // color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: const Color.fromARGB(255, 194, 194, 194))),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.auto_stories_sharp,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Terms and conditions",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 45),
                      child: TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                          ),
                          label: Text("")),
                    )
                  ],
                ),
              ),
            ),
          ),

          SizedBox(
            height: 100,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                label: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
                icon: Text(
                  "Logout",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red),
                  shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                  minimumSize: MaterialStateProperty.all(
                      Size(120, 50)), // Adjust width and height as needed
                  maximumSize: MaterialStateProperty.all(Size(
                      200, 60)), // Adjust maximum width and height if necessary
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

String _getImage(String? image) {
  if (image != null) {
    if (image.startsWith('http')) {
      // If it's an absolute URL, return it directly
      return image;
    } else {
      // If it's a relative URL, prepend the base URL
      return '${AppConfig().baseUrl}/$image';
    }
  } else {
    // Return a default image URL or an empty string
    return 'assets/aizen.jpeg';
  }
}
