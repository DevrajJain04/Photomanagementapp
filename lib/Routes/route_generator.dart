import 'package:Gallery_app/Screen/screen_gallery.dart';
import 'package:Gallery_app/Screen/screen_single_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Gallery.routeName:
        return MaterialPageRoute(
          builder: (_) => const Gallery(),
        );
      case ScreenImage.routeName:
        return MaterialPageRoute(
          builder: (_) => ScreenImage(asset: args as AssetEntity,),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
        );
    }
  }
}