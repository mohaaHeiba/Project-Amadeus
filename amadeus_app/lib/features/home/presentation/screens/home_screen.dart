import 'package:amadeus_app/core/Extensions/spacing.dart';
import 'package:amadeus_app/core/widgets/custom_background/custom_background.dart';
import 'package:amadeus_app/features/avatar/presentation/screens/avatar_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          32.verticalSpace,
          Expanded(
            child: Stack(
              children: [
                customBackground(context),

                // 2. Character
                const AvatarScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
