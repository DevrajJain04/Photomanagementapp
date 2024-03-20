import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'Component/ui_component.dart';


class ScreenImage extends StatelessWidget {
  const ScreenImage({Key? key, required this.asset,}) : super(key: key);

  final AssetEntity asset;
  final Color commonColor = Colors.brown;
  static const  String routeName = "imageView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: commonColor),
        title:  Text('PhotoApp' ,style: TextStyle(color: commonColor), ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){

            Ui.showConfirmationAlert(context,  () async {
              Ui.showLoadingDialog(context);

              try{
                await PhotoManager.editor.deleteWithIds([asset.id]);
              }catch(error){
                debugPrint("ERROR: "+error.toString());
              }
              Navigator.of(context).pop();
              Navigator.of(context).pop(true);
            });

          }, icon: const Icon(Icons.delete_forever_sharp,))
        ],
      ),
      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: FutureBuilder<File?>(
          future: asset.file,
          builder: (_, snapshot) {
            final file = snapshot.data;
            if (file == null) return Container();
            return Image.file(file);
          },
        ),
      ),
    );
  }
}