import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

class GridItem extends StatelessWidget {
  final String title, image1, image2, routes;
  final ColorPicker colors;
  const GridItem(
      {required this.title,
      required this.routes,
      required this.image1,
      this.image2 = "",
      required this.colors,
      super.key});

  Positioned renderImage2() {
    if (image2 == "") {
      return const Positioned(
        child: SizedBox(),
      );
    }

    return Positioned(
      right: 20,
      bottom: 30,
      child: SizedBox(
        height: 40,
        width: 40,
        child: Image(
          image: AssetImage(image2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(routes),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: colors.whiteSmoke,
          border: Border.all(
            color: colors.cyan.withOpacity(0.8),
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colors.black.withOpacity(0.1),
              blurRadius: 10,
            )
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: 45,
              right: 45,
              bottom: 25,
              child: SizedBox(
                height: 80,
                width: 80,
                child: Image(
                  image: AssetImage(image1),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            renderImage2(),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Heading(
                  heading: "h3", text: title, textAlign: TextAlign.center),
            )
          ],
        ),
      ),
    );
  }
}
