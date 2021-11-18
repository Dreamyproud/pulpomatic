import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/home.dart';
import 'package:provider/provider.dart';

import 'bloc/movies/movies_bloc.dart';
import 'data/services_api_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //This made the entire up just in portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(Netflix());
}

class Netflix extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: MultiProvider(
        child: Home(),
        providers: [
          ChangeNotifierProvider.value(value: ServiceApiProvider()),
        ],
      ),
    );
  }
}
