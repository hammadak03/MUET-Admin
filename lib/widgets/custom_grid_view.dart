import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../controller/role_screen_controller.dart';
import '../utils/screen_utils.dart';
import 'grid_view_card.dart';

class CustomGridView extends StatelessWidget {
  final List<String>? imagePath;
  final List<String>? networkImage;
  final List<String>? names;
  final double widthValue;
  final double heightValue;
  final Function(int)? onTap;

  const CustomGridView({
    Key? key,
    this.networkImage,
    this.imagePath,
    this.names,
    this.onTap,
    double? heightValue,
    double? widthValue,
  })  : heightValue =
      heightValue ?? 0.05, // Set default value if heightValue is null
        widthValue =
            widthValue ?? 0.127, // Set default value if widthValue is null
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RoleScreenController());
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: ScreenUtils.height(context) * 0.040),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: ScreenUtils.height(context) * 0.040,
          mainAxisSpacing: ScreenUtils.height(context) * 0.038,
          mainAxisExtent: ScreenUtils.height(context) * 0.154,
        ),
        itemCount:
        names?.isEmpty ?? true ? (imagePath?.length ?? 0) : names!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'sign_in_screen');
              controller.selectRole(index);
            } ,
            child: GridViewCard(
              heightValue: heightValue, widthValue: widthValue,
              imagePath: (imagePath == null || imagePath!.isEmpty)
                  ? networkImage![index]
                  : imagePath![index], // Pass the image path to the widget
              name: (names != null && names!.isNotEmpty)
                  ? names![index]
                  : null, // Conditionally pass the name
            ),
          );
        },
      ),
    );
  }
}

