import 'package:get/get.dart';
import 'package:images_viewer/model/image_data.dart';
import 'package:images_viewer/service/images_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

class ImagesController extends GetxController {
  RxBool loading = false.obs;
  final imagesData = RxList<ImageData>([]);
  int pageSize = 10;
  var logger = Logger();
  RxString? searchWord;
  final imageService = ImagesService();
  var pagingController = PagingController<int, ImageData>(firstPageKey: 1).obs;

  //initialize pageController when controller is initialized
  @override
  void onInit() {
    pagingController.value.addPageRequestListener((pageKey) {
      getImages(pageKey);
    });
    super.onInit();
  }

  //calls fetchImage from service file and add list of images to pageController
  getImages(int pageKey) async {
    try {
      final newImages = await imageService.fetchImages(
          page: (pageKey ~/ pageSize) + 1,
          pageSize: pageSize,
          searchWord: searchWord?.value);
      final isLastPage = newImages.length < pageSize;
      if (isLastPage) {
        pagingController.value.appendLastPage(newImages);
      } else {
        final nextPageKey = pageKey + newImages.length;
        pagingController.value.appendPage(newImages, nextPageKey);
      }
    } catch (e) {
      logger.e(e);
      pagingController.value.error(e);
    }
  }
}
