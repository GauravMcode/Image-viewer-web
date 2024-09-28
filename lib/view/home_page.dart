import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:images_viewer/common/constants/colors.dart';
import 'package:images_viewer/common/widgets/image_card.dart';
import 'package:images_viewer/controller/images_controller.dart';
import 'package:images_viewer/model/image_data.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final h = constraints.maxHeight;
        final w = constraints.maxWidth;
        final screenType = getScreenType(w);
        return Scaffold(
          backgroundColor: kcPrimaryLightColor,
          appBar: AppBar(
            backgroundColor: kcPrimaryColor,
            centerTitle: true,
            title: const Text(
              "PixaBay Images App",
              style: TextStyle(color: kcSecondaryLightColor),
            ),
          ),
          body: Container(
            width: w,
            height: h,
            padding: const EdgeInsets.all(10),
            child: GetBuilder<ImagesController>(
                init: ImagesController(),
                builder: (controller) {
                  return PagedGridView<int, ImageData>(
                    showNewPageProgressIndicatorAsGridChild: true,
                    showNewPageErrorIndicatorAsGridChild: false,
                    showNoMoreItemsIndicatorAsGridChild: true,
                    pagingController: controller.pagingController,
                    builderDelegate: PagedChildBuilderDelegate(
                      itemBuilder: (context, item, index) => ImageCard(
                        imageData: item,
                        h: h * 0.2,
                        w: screenType == ScreenType.desktop ? w * 0.2 : w * 0.4,
                      ),
                      firstPageProgressIndicatorBuilder: (context) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Loading Images..",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 40),
                              LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.black, size: 41),
                            ],
                          ),
                        );
                      },
                      newPageProgressIndicatorBuilder: (context) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Loading more Images..",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 40),
                              LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.black, size: 40),
                            ],
                          ),
                        );
                      },
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 250,
                      maxCrossAxisExtent: 300,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}

enum ScreenType { desktop, tablet, mobile }

ScreenType getScreenType(double width) {
  switch (width) {
    case > 700 && < 1000:
      return ScreenType.tablet;
    case > 1000:
      return ScreenType.desktop;
    default:
      return ScreenType.mobile;
  }
}
