import 'package:flutter/material.dart';

import 'package:travel_app/pages/login.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            color: Colors.grey.shade200,
            child: Image.asset(
              "assets/places/place3.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 30,
            width: width,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: SizedBox(
                height: height * 0.30,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, right: 20),
                            child: Text(
                              "Get Ready To",
                              style: TextStyle(
                                fontSize: width * 0.08,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 26, 26, 26),
                              ),
                            ),
                          ),
                        ),
                        Image.asset(
                          "assets/icons/logos.png",
                          width: width * 0.2,
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 120),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Find thousands of tourist",
                            style: TextStyle(
                              fontSize: width * 0.030,
                              fontWeight: FontWeight.w300,
                              color: const Color.fromARGB(255, 22, 22, 22),
                            ),
                          ),
                          Text(
                            "destinations ready for you to visit",
                            style: TextStyle(
                              fontSize: width * 0.030,
                              fontWeight: FontWeight.w300,
                              color: const Color.fromARGB(255, 22, 22, 22),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.013),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            // backgroundColor:
                            //     const Color.fromARGB(255, 255, 145, 0),:
                          ),
                          child: Container(
                            width: 340,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Get Started",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
