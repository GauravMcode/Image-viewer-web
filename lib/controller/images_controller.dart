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
  final imageService = ImagesService();
  final PagingController<int, ImageData> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      getImages(pageKey);
    });
    super.onInit();
  }

  getImages(int pageKey) async {
    try {
      final newImages = await imageService.fetchImages(
          page: (pageKey ~/ pageSize) + 1, pageSize: pageSize);
      final isLastPage = newImages.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newImages);
      } else {
        final nextPageKey = pageKey + newImages.length;
        pagingController.appendPage(newImages, nextPageKey);
      }
    } catch (e) {
      logger.e(e);
      pagingController.error(e);
    }
  }
}
