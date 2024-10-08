import 'package:flutter/material.dart';
import 'package:images_viewer/common/constants/asset_path.dart';
import 'package:images_viewer/common/constants/colors.dart';
import 'package:images_viewer/model/image_data.dart';

class ImageCard extends StatefulWidget {
  const ImageCard(
      {super.key, required this.imageData, required this.h, required this.w});
  final ImageData imageData;
  final double w;
  final double h;

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: 20,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..scale(isHovering ? 1.2 : 1.0, isHovering ? 1.2 : 1,
              isHovering ? 1.5 : 1),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            kcPrimaryLightColor,
            kcSecondaryLightColor,
            kcPrimaryColor
          ]),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 1),
        ),
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {},
          onHover: (value) {
            setState(() {
              isHovering = value;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          widget.imageData.userImageUrl ?? placeHolderImage),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      widget.imageData.user?.toString() ?? "User",
                      style: const TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 3),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        widget.imageData.largeImageUrl ?? placeHolderImage,
                        fit: BoxFit.fill,
                        width: widget.w,
                        height: widget.h,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              FittedBox(
                  child: Text(
                      "#${widget.imageData.tags?.replaceAll(', ', ' #')}")),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.thumb_up_alt_outlined,
                          size: 25,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 5),
                        Text(widget.imageData.likes?.toString() ?? "0")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.remove_red_eye_sharp,
                          size: 25,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 5),
                        Text(widget.imageData.views?.toString() ?? "0")
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


