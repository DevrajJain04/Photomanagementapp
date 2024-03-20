import 'dart:typed_data';
import 'package:Gallery_app/Screen/screen_single_image.dart';
import 'package:Gallery_app/bloc/gallery_cubit.dart';
import 'package:Gallery_app/bloc/gallery_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryItem extends StatefulWidget {
  const GalleryItem(this.asset, this.index, {Key? key}) : super(key: key);

  final AssetEntity asset;
  final int index;

  @override
  _GalleryItemState createState() => _GalleryItemState();
}

class _GalleryItemState extends State<GalleryItem> {
  Future<Uint8List?> loadImageData(AssetEntity asset) async {
  final file = await asset.file;
  if (file == null) {
    return null;
  }
  final bytes = await file.readAsBytes();
  return bytes;
}
  @override
  Widget build(BuildContext context) {
    AssetEntity asset = widget.asset;
    int index = widget.index;

    return FutureBuilder<Uint8List?>(
      future: loadImageData(asset),
        builder: (_, snapshot) {
          var bytes = snapshot.data;
          if (bytes == null) return const Center(child:  CircularProgressIndicator());
          return BlocBuilder<GalleryCubit, GalleryState>(
              builder: (context, state) {
                var provider = state as GalleryFetchSuccess;
                return InkWell(
                  onTap: () {
                    if(provider.deleteMode){
                      setState(() {
                        if(state.itemToDelete.contains(index)){
                          state.itemToDelete.remove(index);
                        }else {
                          state.itemToDelete.add(index);
                        }
                      });

                    }else {
                      Navigator.of(context).pushNamed(ScreenImage.routeName,arguments:asset).then((value){
                        if(value!=null) {
                          BlocProvider.of<GalleryCubit>(context).fetchAssets();
                        }
                      });
                    }
                  },
                  child: Container(
                      padding: const EdgeInsets.all(1.2),
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: Image.memory(bytes,cacheHeight: 1000, cacheWidth: 600,
                                  fit: BoxFit.cover)),
                          if(provider.deleteMode)
                            Align( alignment: Alignment.topRight,
                              child: Checkbox(
                                value: state.itemToDelete.contains(index),
                                activeColor: Colors.brown,
                                onChanged: (value) {
                                  setState(() {
                                    if(state.itemToDelete.contains(index)){
                                      state.itemToDelete.remove(index);
                                    }else {
                                      state.itemToDelete.add(index);
                                    }
                                  });
                                },
                              ),
                            ),
                        ],
                      )),
                );
              }
          );
        }
    );
  }
}