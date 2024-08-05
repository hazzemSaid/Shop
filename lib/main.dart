import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shop/cubit/apiCubit/apicubit_cubit.dart';
import 'package:shop/cubit/auth-cubit/auth_cubit.dart';
import 'package:shop/firebase_options.dart';
import 'package:shop/screens/resister.dart';
import 'package:shop/screens/sgin_in.dart';

import '/screens/phoneScreen.dart';
import 'screens/AllCategory.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.remove();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ApiCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        routes: <String, WidgetBuilder>{
          '/': (context) => Sign_up(),
          '/AllCategory': (context) => AllCategory(),
          '/Phonescreen': (context) => Phonescreen(),
          '/regester': (context) => resister(),
        },
      ),
    );
  }
}
