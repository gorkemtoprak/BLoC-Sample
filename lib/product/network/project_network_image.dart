import 'package:fake_store/product/constants/app_constants.dart';
import 'package:fake_store/product/mixin/image_mixin.dart';
import 'package:flutter/material.dart';

class ProjectNetworkImage extends Image with ImageMixin {
  ProjectNetworkImage.network({Key? key, String? src})
      : super.network(src ?? ApplicationConstant.instance.dummyImage, key: key);
}
