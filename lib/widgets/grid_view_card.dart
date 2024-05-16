import 'package:flutter/cupertino.dart';

import '../utils/screen_utils.dart';

class GridViewCard extends StatelessWidget {
  final String? imagePath;
  final String? name;
  final String? networkImage;
  final double widthValue;
  final double heightValue;

  const GridViewCard({
    Key? key,
    this.imagePath,
    this.name,
    this.networkImage,
    double? heightValue,
    double? widthValue,
  })  : heightValue =
      heightValue ?? 0.05, // Set default value if heightValue is null
        widthValue =
            widthValue ?? 0.127, // Set default value if widthValue is null
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = const Color(0xff535353);
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.25),
            offset: const Offset(0, 1),
            blurRadius: 10.0,
            spreadRadius: 1.0,
          ),
        ],
        color: const Color(0XFFFFFFFF),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (networkImage == '' || networkImage == null)
              ? Image.asset(
            imagePath!,
            width: ScreenUtils.width(context) *
                widthValue, // Adjust the width of the image as needed
            height: ScreenUtils.height(context) *
                heightValue, // Adjust the height of the image as needed
            filterQuality: FilterQuality.high,
            fit: BoxFit.fill,
          )
              : Image(image: NetworkImage(networkImage!)),
          SizedBox(height: height * 0.014),
          if (name != null && name!.isNotEmpty)
            Text(
              name!, // Use ! to assert that name is not null
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: height * 0.014,
                color: textColor,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.0,
              ),
            ),
        ],
      ),
    );
  }
}
