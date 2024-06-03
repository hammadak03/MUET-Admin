import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;
  final String title;

  const CustomBackground({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(
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
              padding:
                  EdgeInsets.only(top: height * 0.059, bottom: height * 0.035),
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
                        title.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xfffffc817),
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(child: child),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
