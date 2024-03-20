import 'package:photo_manager/photo_manager.dart';

abstract class GalleryState {}

class GalleryLoading extends GalleryState {
  GalleryLoading();
}

class GalleryFetchSuccess extends GalleryState {
  final List<AssetEntity> assets ;
  bool deleteMode = false;
  List<int> itemToDelete = [];

  GalleryFetchSuccess(this.assets, {this.deleteMode =false});
}