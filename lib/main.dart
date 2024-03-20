import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Routes/route_generator.dart';
import 'Screen/screen_gallery.dart';
import 'bloc/gallery_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GalleryCubit>(
            create: (context) => GalleryCubit()),
      ],
      child: const MaterialApp(
        title: 'Photo Manager Demo',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: Gallery.routeName,

      ),
    );
  }
}
