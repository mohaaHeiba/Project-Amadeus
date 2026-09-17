import 'package:amadeus_app/core/constants/app_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<String?> getName() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(AppKeys.operatorName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<String?>(
          future: getName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('sadasdasdas ${snapshot.error}');
            }

            final name = snapshot.data;
            return Text(name ?? 'sada');
          },
        ),
      ),
    );
  }
}
