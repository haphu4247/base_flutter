import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../../colors/app_colors.dart';
import '../../utils/utils.dart';

class ImageLoader extends StatelessWidget {
  const ImageLoader(this.name,
      {Key? key,
      this.fit,
      this.folder = AssetsFolder.icons,
      this.color,
      this.height,
      this.width})
      : super(key: key);
  final String name;
  final AssetsFolder folder;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (name.startsWith(IconsType.http.name)) {
      return CachedNetworkImage(
        fit: fit,
        imageUrl: name,
        color: color,
        width: width,
        height: height,
        placeholder: (BuildContext context, String url) => SizedBox(
          height: Utils.height(context, height ?? 24),
          child: const Center(
              child: CircularProgressIndicator(color: AppColors.primary)),
        ),
        errorWidget: (BuildContext context, String url, dynamic error) =>
            _ErrorLoader(fit: fit, size: width),
      );
    } else if (name.endsWith(IconsType.svg.name)) {
      return SvgPicture.asset(
        'assets/${folder.path}/$name',
        fit: fit ?? BoxFit.contain,
        color: color,
        height: height,
        width: width,
      );
    } else if (name.endsWith(IconsType.png.name) ||
        name.endsWith(IconsType.jpg.name)) {
      return Image.asset(
        'assets/${folder.path}/$name',
        fit: fit,
        color: color,
        height: height,
        width: width,
      );
    } else {
      return _ErrorLoader(fit: fit, size: width);
    }
  }
}

class _ErrorLoader extends StatelessWidget {
  const _ErrorLoader({
    Key? key,
    required this.fit,
    required this.size,
  }) : super(key: key);

  final BoxFit? fit;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.error,
      size: size,
      color: AppColors.primary,
    );
  }
}

enum IconsType { svg, png, jpg, http }

enum AssetsFolder { icons, images, home, settings }

extension AssetsFolderExt on AssetsFolder {
  String get path {
    switch (this) {
      case AssetsFolder.icons:
        return 'icons';
      case AssetsFolder.home:
        return 'icons/home';
      case AssetsFolder.settings:
        return 'icons/settings';
      case AssetsFolder.images:
        return 'images';
    }
  }
}
