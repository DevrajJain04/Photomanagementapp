import 'package:Gallery_app/bloc/gallery_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit() : super(GalleryLoading());
  List<AssetEntity>? assets ;

  fetchAssets() async {

    final albums = await PhotoManager.getAssetPathList(onlyAll: true,type: RequestType.image);
    final recentAlbum = albums.first;
    final recentAssets = await recentAlbum.getAssetListRange(start: 0, end: 1000000,);
    assets = recentAssets;
    emit(GalleryFetchSuccess(recentAssets));

  }

  changeDeleteMode(bool value){
    if(assets!=null) {
      emit(GalleryFetchSuccess(assets!,deleteMode: value));
    }
  }
}