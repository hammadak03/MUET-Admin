import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/home_screen_data.dart';
import '../widgets/custom_grid_view.dart';
import '../widgets/custom_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: appBarColor,
      body: SafeArea(
        child: CustomBackground(
          title: 'Select Your Role',
          child: CustomGridView(
            names: RoleScreenData.names,
            imagePath: RoleScreenData.imagePath,
          ),
        ),
      ),
    );
  }
}
