import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/home_screen_data.dart';
import '../widgets/custom_grid_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appBarColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                color: backgroundgrey,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: height * 0.059, bottom: height * 0.035),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: height * 0.134,
                      height: height * 0.134,
                      child: Image.asset(
                        'assets/images/muet logo.png',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.032, bottom: height * 0.045),
                          child: Text(
                            textAlign: TextAlign.center,
                            'Select Your Role'.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 20,
                                color: Color(0xfffffc817),
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Expanded(
                          child: CustomGridView(
                            names: RoleScreenData.names,
                            imagePath: RoleScreenData.imagePath,
                          /*Steps to add more GridViewCards
                            1. Update RoleScreenData: Add new event image path, name, and route.
                            2. Define Route in main.dart: Add new route in the route table.
                            3. Create New Event Screen: Create a new screen for the event.
                            4. Verify Changes: Ensure HomeScreen and CustomGridView are correctly configured.
                            By following these steps, you can add new items to the grid and ensure they navigate to the correct screens. */
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
