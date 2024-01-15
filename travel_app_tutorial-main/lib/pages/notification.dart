import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Notifications",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage("assets/places/place3.jpg"),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          color: const Color.fromARGB(255, 194, 194, 194))
                      // color: Colors.red,
                      ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ouad kherouf ! ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    Text("a new place has been added ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400)),
                    Text("ouad kherouf - El meghaier ",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400)),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () {},
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "view",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    width: 60,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage("assets/places/place1.jpg"),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: const Color.fromARGB(255, 194, 194, 194))
                        // color: Colors.red,
                        ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Mareot Hotel",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      Text("discover the 5 stars hotel",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      Text("Hotel Mariot - Constantine ",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(
                    width: 46,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "view",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      width: 60,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
