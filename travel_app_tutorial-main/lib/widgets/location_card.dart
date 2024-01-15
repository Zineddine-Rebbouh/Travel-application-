import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/provider/provider.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Access user properties
    String? username = userProvider.user?.username;
    return Card(
      elevation: 0.4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Image.asset(
              'assets/icons/logoo.png',
              width: 50,
            ),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.orange,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "${username}",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Color.fromARGB(255, 221, 126, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
              ],
            )
          ],
        ),
      ),
    );
  }
}
