import 'package:cached_network_image/cached_network_image.dart';
import 'package:amerika_foods/generated/assets.dart';
import 'package:flutter/material.dart';

class NetworkImageItem extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final Alignment? alignment;
  final FilterQuality? filterQuality;
  final String? placeholderImage;
  final VoidCallback? onError;

  const NetworkImageItem({
    required this.imageUrl,
    super.key,
    this.fit,
    this.alignment,
    this.filterQuality,
    this.placeholderImage, this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: ValueKey<String>(imageUrl),
      cacheKey: imageUrl,
      imageUrl: imageUrl,
      // progressIndicatorBuilder: (context, url, progress) {
      //   return Loading();
      // },
      errorWidget: (BuildContext context, String url, Object error) {
        if(onError != null) {
          onError!();
        }

        return Image.asset(
          placeholderImage ??  Assets.imagesImagePlaceholder,
          fit: fit ?? BoxFit.contain,
        );
      },
      alignment: alignment ?? Alignment.center,
      filterQuality: filterQuality ?? FilterQuality.low,
      fit: fit ?? BoxFit.contain,
      placeholder: (BuildContext context, String url) {
        return Image.asset(
          placeholderImage ?? Assets.imagesImagePlaceholder,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.low,
        );
      },
    );
  }
}
